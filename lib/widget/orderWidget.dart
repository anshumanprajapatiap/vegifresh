import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:vegifresh/utility/Utility.dart';
import 'package:vegifresh/widget/textWidget.dart';

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
    // final ordersModel = Provider.of<OrderModel>(context);
    // var orderDate = ordersModel.orderDate.toDate();
    //orderDateToShow = '${11}/${2}/${2023}';
    // super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final ordersModel = Provider.of<OrderModel>(context);
    final Color color = Utility(context).color;
    Size size = Utility(context).getScreenSize;
    // final productProvider = Provider.of<ProductsProvider>(context);
    // final getCurrProduct = productProvider.findProdById(ordersModel.productId);
    return ListTile(
      subtitle:
      Text('Paid: \$100'),
      onTap: () {
        GlobalMethods.navigateTo(
            ctx: context, routeName: ProductDetailScreen.routeName);
      },
      leading: FancyShimmerImage(
        width: size.width * 0.2,
        imageUrl: 'getCurrProduct.imageUrl',
        boxFit: BoxFit.fill,
      ),
      title: TextWidget(
          text: 'title  x quantity',
          color: color,
          textSize: 18),
      trailing: TextWidget(
          // text: orderDateToShow,
        text: '11/09/2023',
          color: color,
          textSize: 18)
      ,
    );
  }
}