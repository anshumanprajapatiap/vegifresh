import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:vegifresh/utility/Utility.dart';
import 'package:vegifresh/widget/emptyScreenWidget.dart';

import '../../provider/viewedProductProvider.dart';
import '../../utility/globalMethod.dart';
import '../../widget/backWidget.dart';
import '../../widget/recentlyViewedWidget.dart';
import '../../widget/textWidget.dart';

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

    Size size = Utility(context).getScreenSize;
    final viewedProdProvider = Provider.of<ViewedProdProvider>(context);
    final viewedProdItemsList = viewedProdProvider.getViewedProdlistItems.values
        .toList()
        .reversed
        .toList();

    return Scaffold(
        appBar: AppBar(

          actions: [
            viewedProdItemsList.isNotEmpty?
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
            : Text('')
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

        body: viewedProdItemsList.isEmpty
            ? const EmptyScreenWidget(
                title: 'Your history is empty',
                subtitle: 'No products has been viewed yet!',
                buttonText: 'Shop now',
                imagePath: 'assets/images/history.png',
              )
            : ListView.builder(
              itemCount: viewedProdItemsList.length,
              itemBuilder: (ctx, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                  child: ChangeNotifierProvider.value(
                    value: viewedProdItemsList[index],
                      child: RecentlyViewedWidget()
                  ),
                );
              }),
      );
  }
}