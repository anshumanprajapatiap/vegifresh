import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:vegifresh/utility/Utility.dart';
import 'package:vegifresh/widget/emptyScreenWidget.dart';

import '../../utility/globalMethod.dart';
import '../../widget/backWidget.dart';
import '../../widget/textWidget.dart';
import '../../widget/wishlistWidget.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = "/WishlistScreen";
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utility(context).color;
    Size size = Utility(context).getScreenSize;
    // final wishlistProvider = Provider.of<WishlistProvider>(context);
    // final wishlistItemsList =
    // wishlistProvider.getWishlistItems.values.toList().reversed.toList();
    return false
        ? const EmptyScreenWidget(
      title: 'Your Wishlist Is Empty',
      subtitle: 'Explore more and shortlist some items',
      imagePath: 'assets/images/wishlist.png',
      buttonText: 'Add a wish',
    )
        : Scaffold(
        appBar: AppBar(
            centerTitle: true,
            leading: const BackWidget(),
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: TextWidget(
              text: 'Wishlist ({wishlistItemsList.length})',
              color: color,
              isTitle: true,
              textSize: 22,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  GlobalMethods.warningDialog(
                      title: 'Empty your wishlist?',
                      subtitle: 'Are you sure?',
                      fct: () async {
                        // await wishlistProvider.clearOnlineWishlist();
                        // wishlistProvider.clearLocalWishlist();
                      },
                      context: context);
                },
                icon: Icon(
                  IconlyBroken.delete,
                  color: color,
                ),
              ),
            ]),
        body: MasonryGridView.count(
          itemCount: 4,
          crossAxisCount: 2,
          // mainAxisSpacing: 16,
          // crossAxisSpacing: 20,
          itemBuilder: (context, index) {
            return WishlistWidget();
          },
        ));
  }
}