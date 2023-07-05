
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:vegifresh/utility/Utility.dart';

import '../constant/firebaseConstant.dart';
import '../provider/productProvider.dart';
import '../provider/wishlistProvider.dart';
import '../utility/globalMethod.dart';

class HeartBTN extends StatefulWidget {
  const HeartBTN({Key? key, required this.productId, this.isInWishlist = false})
      : super(key: key);
  final String productId;
  final bool? isInWishlist;

  @override
  State<HeartBTN> createState() => _HeartBTNState();
}

class _HeartBTNState extends State<HeartBTN> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    //final productProvider = Provider.of<ProductsProvider>(context);
    //final getCurrProduct = productProvider.findProdById(widget.productId);
    // final wishlistProvider = Provider.of<WishlistProvider>(context);
    final Color color = Utility(context).color;
    return GestureDetector(
      onTap: (){},
      // onTap: () async {
      //   setState(() {
      //     loading = true;
      //   });
      //   try {
      //     final User? user = authInstance.currentUser;
      //
      //     if (user == null) {
      //       GlobalMethods.errorDialog(
      //           subtitle: 'No user found, Please login first',
      //           context: context);
      //       return;
      //     }
      //     if (widget.isInWishlist == false && widget.isInWishlist != null) {
      //       await GlobalMethods.addToWishlist(
      //           productId: widget.productId, context: context);
      //     } else {
      //       await wishlistProvider.removeOneItem(
      //           wishlistId:
      //           wishlistProvider.getWishlistItems[getCurrProduct.id]!.id,
      //           productId: widget.productId);
      //     }
      //     await wishlistProvider.fetchWishlist();
      //     setState(() {
      //       loading = false;
      //     });
      //   } catch (error) {
      //     GlobalMethods.errorDialog(subtitle: '$error', context: context);
      //   } finally {
      //     setState(() {
      //       loading = false;
      //     });
      //   }
      //   // print('user id is ${user.uid}');
      //   // wishlistProvider.addRemoveProductToWishlist(productId: productId);
      // },
      child: loading
          ? const Padding(
        padding: EdgeInsets.all(8.0),
        child: SizedBox(
            height: 15, width: 15, child: CircularProgressIndicator()),
      )
          : Icon(
        widget.isInWishlist != null && widget.isInWishlist == true
            ? IconlyBold.heart
            : IconlyLight.heart,
        size: 22,
        color: widget.isInWishlist != null && widget.isInWishlist == true
            ? Colors.red
            : color,
      ),
    );
  }
}