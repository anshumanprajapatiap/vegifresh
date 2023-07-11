import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegifresh/utility/Utility.dart';
import 'package:vegifresh/widget/textWidget.dart';

import '../model/ordersModel.dart';
import '../provider/productProvider.dart';
import '../screen/innerScreen/productDetailScreen.dart';
import '../utility/globalMethod.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({Key? key}) : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  late String orderDateToShow;

  @override
  void didChangeDependencies() {
    final ordersModel = Provider.of<OrderModel>(context);
    var orderDate = ordersModel.orderDate.toDate();
    orderDateToShow = '${orderDate.day}/${orderDate.month}/${orderDate.year}';
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final ordersModel = Provider.of<OrderModel>(context);
    final Color color = Utility(context).color;
    Size size = Utility(context).getScreenSize;
    final productProvider = Provider.of<ProductsProvider>(context);
    // final getCurrProduct = productProvider.findProdById(ordersModel.productId);
    return ListTile(
      subtitle:
        Text('Paid: \$${double.parse(ordersModel.price).toStringAsFixed(2)}'),
      onTap: () {
        // Navigator.pushNamed(context, ProductDetailScreen.routeName,
        //     arguments: getCurrProduct.id);
      },
      leading: FancyShimmerImage(
        width: size.width * 0.2,
        imageUrl: '${ordersModel.imageUrl}',
        boxFit: BoxFit.fill,
      ),
      title: TextWidget(
          text: 'Total No. of Products ${ordersModel.quantity}',
          color: color,
          textSize: 18),
      trailing: TextWidget(
          // text: orderDateToShow,
        text: orderDateToShow,
          color: color,
          textSize: 18)
      ,
    );
  }
}