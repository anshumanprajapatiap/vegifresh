import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:vegifresh/screen/innerScreen/productDetailScreen.dart';
import 'package:vegifresh/utility/Utility.dart';
import 'package:vegifresh/widget/textWidget.dart';

import '../model/viewedModel.dart';
import '../provider/cartProvider.dart';
import '../provider/productProvider.dart';
import '../utility/globalMethod.dart';


class RecentlyViewedWidget extends StatefulWidget {
  const RecentlyViewedWidget({Key? key}) : super(key: key);

  @override
  _RecentlyViewedWidgetState createState() => _RecentlyViewedWidgetState();
}

class _RecentlyViewedWidgetState extends State<RecentlyViewedWidget> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);

    final viewedProdModel = Provider.of<ViewedProdModel>(context);

    final getCurrProduct = productProvider.findProdById(viewedProdModel.productId);
    double usedPrice = getCurrProduct.isOnSale
        ? getCurrProduct.salePrice
        : getCurrProduct.price;
    final cartProvider = Provider.of<CartProvider>(context);
    bool? _isInCart = cartProvider.getCartItems.containsKey(getCurrProduct.id);
    Color color = Utility(context).color;
    Size size = Utility(context).getScreenSize;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ProductDetailScreen.routeName,
              arguments: getCurrProduct.id);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FancyShimmerImage(
              imageUrl: getCurrProduct.imageUrl,
              boxFit: BoxFit.fill,
              height: size.width * 0.27,
              width: size.width * 0.25,
            ),
            const SizedBox(
              width: 12,
            ),
            Column(
              children: [
                TextWidget(
                  text: getCurrProduct.title,
                  color: color,
                  textSize: 24,
                  isTitle: true,
                ),
                const SizedBox(
                  height: 12,
                ),
                TextWidget(
                  text: usedPrice.toStringAsFixed(2),
                  color: color,
                  textSize: 20,
                  isTitle: false,
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Material(
                borderRadius: BorderRadius.circular(12),
                color: Colors.green,
                child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: _isInCart
                      ? null
                      : () async {
                            cartProvider.addProductsToCart(
                              productId: getCurrProduct.id,
                              quantity: 1,
                            );
                        },
                    // onTap: _isInCart
                    //     ? null
                    //     : ()async {
                    //   final User? user = authInstance.currentUser;
                    //
                    //   if (user == null) {
                    //     GlobalMethods.errorDialog(
                    //         subtitle: 'No user found, Please login first',
                    //         context: context);
                    //     return;
                    //   }
                    //   await    GlobalMethods.addToCart(
                    //       productId: getCurrProduct.id,
                    //       quantity: 1,
                    //       context: context);await cartProvider.fetchCart();
                    //   // cartProvider.addProductsToCart(
                    //   //   productId: getCurrProduct.id,
                    //   //   quantity: 1,
                    //   // );
                    // },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        _isInCart ? IconlyBold.tickSquare :IconlyBold.plus,
                        color: Colors.white,
                        size: 20,
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}