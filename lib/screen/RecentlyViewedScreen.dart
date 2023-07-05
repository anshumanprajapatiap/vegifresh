import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:vegifresh/utility/Utility.dart';

import '../utility/globalMethod.dart';
import '../widget/backWidget.dart';
import '../widget/recentlyViewedWidget.dart';
import '../widget/textWidget.dart';

class RecentlyViewedScreen extends StatefulWidget {
  static const routeName = '/ViewedRecentlyScreen';

  const RecentlyViewedScreen({Key? key}) : super(key: key);

  @override
  _RecentlyViewedScreenState createState() => _RecentlyViewedScreenState();
}

class _RecentlyViewedScreenState extends State<RecentlyViewedScreen> {
  bool check = true;
  @override
  Widget build(BuildContext context) {
    Color color = Utility(context).color;

    // Size size = Utils(context).getScreenSize;
    // final viewedProdProvider = Provider.of<ViewedProdProvider>(context);
    // final viewedProdItemsList = viewedProdProvider.getViewedProdlistItems.values
    //     .toList()
    //     .reversed
    //     .toList();
    if (false) {
      // return const EmptyScreen(
      //   title: 'Your history is empty',
      //   subtitle: 'No products has been viewed yet!',
      //   buttonText: 'Shop now',
      //   imagePath: 'assets/images/history.png',
      // );
    } else {
      return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                GlobalMethods.warningDialog(
                    title: 'Empty your history?',
                    subtitle: 'Are you sure?',
                    fct: () {},
                    context: context);
              },
              icon: Icon(
                IconlyBroken.delete,
                color: color,
              ),
            )
          ],
          leading: const BackWidget(),
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          title: TextWidget(
            text: 'History',
            color: color,
            textSize: 24.0,
          ),
          backgroundColor:
          Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
        ),
        body: ListView.builder(
            itemCount: 4,
            itemBuilder: (ctx, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                child: RecentlyViewedWidget(),
              );
            }),
      );
    }
  }
}