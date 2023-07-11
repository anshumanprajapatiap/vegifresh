import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:vegifresh/utility/Utility.dart';

import '../../provider/orderProvider.dart';
import '../../widget/backWidget.dart';
import '../../widget/orderWidget.dart';
import '../../widget/textWidget.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/OrderScreen';

  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utility(context).color;
    Size size = Utility(context).getScreenSize;
    final ordersProvider = Provider.of<OrdersProvider>(context);
    final ordersList = ordersProvider.getOrders;
    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        elevation: 0,
        centerTitle: false,
        title: TextWidget(
          text: 'Your orders (${ordersList.length})',
          color: color,
          textSize: 24.0,
          isTitle: true,
        ),
        backgroundColor: Theme.of(context)
            .scaffoldBackgroundColor
            .withOpacity(0.9),
      ),
      body: ListView.separated(
        itemCount: ordersList.length,
        itemBuilder: (ctx, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 2,
                vertical: 6,),
              child: ChangeNotifierProvider.value(
                  value: ordersList[index],
                  child: OrderWidget()
              ),
            );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: color,
            thickness: 1,
          );
        },
      ));
  }
}