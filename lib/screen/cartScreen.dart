import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:vegifresh/model/ordersModel.dart';
import 'package:vegifresh/utility/Utility.dart';
import 'package:vegifresh/widget/cartWidget.dart';
import 'package:vegifresh/widget/emptyScreenWidget.dart';

import '../constant/firebaseConstant.dart';
import '../provider/cartProvider.dart';
import '../provider/orderProvider.dart';
import '../provider/productProvider.dart';
import '../utility/globalMethod.dart';
import '../widget/textWidget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utility(context).color;
    Size size = Utility(context).getScreenSize;
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItemsList =
    cartProvider.getCartItems.values
        .toList()
        .reversed
        .toList();
    return cartItemsList.isEmpty
        ? const EmptyScreenWidget(
      title: 'Your cart is empty',
      subtitle: 'Add something and make me happy :)',
      buttonText: 'Shop now',
      imagePath: 'assets/images/cart.png',
    ) : Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Theme
              .of(context)
              .scaffoldBackgroundColor,
          title: TextWidget(
            text: 'Cart (${cartItemsList.length})',
            color: color,
            isTitle: true,
            textSize: 22,
          ),
          actions: [
            IconButton(
              onPressed: () {
                GlobalMethods.warningDialog(
                    title: 'Empty your cart?',
                    subtitle: 'Are you sure?',
                    fct: () async {
                      await cartProvider.clearOnlineCart();
                      cartProvider.clearLocalCart();
                    },
                    context: context);
              },
              icon: Icon(
                IconlyBroken.delete,
                color: color,
              ),
            ),
          ]),
      body: Column(
        children: [
          _checkout(ctx: context),
          Expanded(
            child: ListView.builder(
              itemCount: cartItemsList.length,
              itemBuilder: (ctx, index) {
                return ChangeNotifierProvider.value(
                    value: cartItemsList[index],
                    child: CartWidget(
                      q: cartItemsList[index].quantity,
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _checkout({required BuildContext ctx}) {
    final Color color = Utility(ctx).color;
    Size size = Utility(ctx).getScreenSize;
    final cartProvider = Provider.of<CartProvider>(ctx);
    final productProvider = Provider.of<ProductsProvider>(ctx);
    final ordersProvider = Provider.of<OrdersProvider>(ctx);
    double total = 0.0;
    cartProvider.getCartItems.forEach((key, value) {
      final getCurrProduct = productProvider.findProdById(value.productId);
      total += (getCurrProduct.isOnSale
          ? getCurrProduct.salePrice
          : getCurrProduct.price) *
          value.quantity;
    });
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.1,
      // color: ,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(children: [
          Material(
            color: Colors.green,
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () async {
                User? user = authInstance.currentUser;
                final orderId = const Uuid().v4();
                final productProvider = Provider.of<ProductsProvider>(ctx, listen: false);
                print(cartProvider.getCartItems!.length);
                //OrderModel orderData = OrderModel(orderId: orderId, userId: userId, productId: productId, userName: userName, price: price, imageUrl: imageUrl, quantity: quantity, orderDate: orderDate)

                List <Map<String, dynamic>> productData = [];
                int totalQuantity = 0;

                cartProvider.getCartItems.forEach((key, value) async {
                  final getCurrProduct = productProvider.findProdById(
                    value.productId,
                  );
                  Map<String, dynamic> data = {
                    'id': getCurrProduct.id,
                    'title': getCurrProduct.title,
                    'imageUrl': getCurrProduct.imageUrl,
                    'quantity': value.quantity,
                    'price': (getCurrProduct.isOnSale ? getCurrProduct.salePrice : getCurrProduct.price) * value.quantity,
                  };
                  totalQuantity +=value.quantity;

                  productData.add(data);

                });

                try {
                  await FirebaseFirestore.instance
                      .collection('orders')
                      .doc(orderId)
                      .set({
                    'orderId': orderId,
                    'userId': user!.uid,
                    'productsDetail': productData,
                    'totalPrice': total,
                    'totalQuantity': totalQuantity,
                    'userName': user.displayName,
                    'orderDate': Timestamp.now(),
                  });
                  await cartProvider.clearOnlineCart();
                  cartProvider.clearLocalCart();
                  ordersProvider.fetchOrders();
                  await Fluttertoast.showToast(
                    msg: "Your order has been placed",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                  );
                } catch (error) {
                  GlobalMethods.errorDialog(
                      subtitle: error.toString(), context: ctx);
                } finally {
                }

              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextWidget(
                  text: 'Order Now',
                  textSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const Spacer(),
          FittedBox(
            child: TextWidget(
              text: 'Total: \$${total.toStringAsFixed(2)}',
              color: color,
              textSize: 18,
              isTitle: true,
            ),
          ),
        ]),
      ),
    );
  }

}