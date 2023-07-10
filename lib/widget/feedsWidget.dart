
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vegifresh/utility/Utility.dart';
import 'package:vegifresh/widget/priceWidget.dart';
import 'package:vegifresh/widget/textWidget.dart';

import '../constant/firebaseConstant.dart';
import '../model/productsModel.dart';
import '../provider/cartProvider.dart';
import '../provider/wishlistProvider.dart';
import '../screen/innerScreen/productDetailScreen.dart';
import '../utility/globalMethod.dart';
import 'heartButtonWidget.dart';

class FeedsWidget extends StatefulWidget {


  const FeedsWidget({
    Key? key,
    }) : super(key: key);


  @override
  State<FeedsWidget> createState() => _FeedsWidgetState();
}

class _FeedsWidgetState extends State<FeedsWidget> {
  final _quantityTextController = TextEditingController();
  @override
  void initState() {
    _quantityTextController.text = '1';
    super.initState();
  }

  @override
  void dispose() {
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utility(context).color;
    Size size = Utility(context).getScreenSize;
    final productModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    bool? _isInCart = cartProvider.getCartItems.containsKey(productModel.id);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    bool? _isInWishlist = wishlistProvider.getWishlistItems.containsKey(productModel.id);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, ProductDetailScreen.routeName,
                arguments: productModel.id);
          },
          borderRadius: BorderRadius.circular(12),
          child: Column(children: [
            FancyShimmerImage(
              imageUrl: productModel.imageUrl,
              height: size.width * 0.21,
              width: size.width * 0.2,
              boxFit: BoxFit.fill,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: TextWidget(
                      text: productModel.title,
                      color: color,
                      maxLines: 1,
                      textSize: 18,
                      isTitle: true,
                    ),
                  ),
                  Flexible(
                      flex: 1,
                      child: HeartBTN(
                        productId: productModel.id,
                        isInWishlist: _isInWishlist,
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: PriceWidget(
                      salePrice: productModel.salePrice,
                      price: productModel.price,
                      textPrice: _quantityTextController.text,
                      isOnSale: productModel.isOnSale,
                    ),
                  ),
                  Flexible(
                    child: Row(
                      children: [
                        Flexible(
                          flex: 6,
                          child: FittedBox(
                            child: TextWidget(
                              text: productModel.isPiece ? 'Piece' : 'kg',
                              color: color,
                              textSize: 20,
                              isTitle: true,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Flexible(
                            flex: 2,
                            // TextField can be used also instead of the textFormField
                            child: TextField(
                              controller: _quantityTextController,
                              key: const ValueKey('10'),
                              style: TextStyle(color: color, fontSize: 18),
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              enabled: true,
                              decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(),
                                ),
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp('[0-9.]'),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  if (value.isEmpty) {
                                    _quantityTextController.text = '1';
                                  } else {
                                    // total = usedPrice *
                                    //     int.parse(_quantityTextController.text);
                                  }
                                });
                              },
                              //onSaved: (value) {},
                            )
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: _isInCart
                    ? null :
                    () {
                        final User? user = authInstance.currentUser;
                        if (user == null) {
                          GlobalMethods.errorDialog(
                              subtitle: 'No user found, Please login first',
                              context: context);
                          return;
                        }
                      cartProvider.addProductsToCart(
                          productId: productModel.id,
                          quantity: int.parse(_quantityTextController.text));
                    },
                    // onPressed: _isInCart
                //     ? null
                //     : () async {
                //   // if (_isInCart) {
                //   //   return;
                //   // }
                //   final User? user = authInstance.currentUser;

                  // if (user == null) {
                  //   GlobalMethods.errorDialog(
                  //       subtitle: 'No user found, Please login first',
                  //       context: context);
                  //   return;
                  // }
                  // await GlobalMethods.addToCart(
                  //     productId: productModel.id,
                  //     quantity: int.parse(_quantityTextController.text),
                  //     context: context);
                  //await cartProvider.fetchCart();
                  // cartProvider.addProductsToCart(
                  //     productId: productModel.id,
                  //     quantity: int.parse(_quantityTextController.text));
                // },
                child: TextWidget(
                  text: _isInCart ? 'In cart' : 'Add to cart',
                  maxLines: 1,
                  color: color,
                  textSize: 20,
                ),
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(Theme.of(context).secondaryHeaderColor),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12.0),
                          bottomRight: Radius.circular(12.0),
                        ),
                      ),
                    )),
              ),
            )
          ]),
        ),
      ),
    );
  }
}