import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:vegifresh/utility/Utility.dart';

import '../../model/productsModel.dart';
import '../../provider/productProvider.dart';
import '../../widget/emptyProductWidget.dart';
import '../../widget/onSaleWidget.dart';
import '../../widget/textWidget.dart';

class OnSaleScreen extends StatelessWidget {
  static const routeName = "/OnSaleScreen";
  const OnSaleScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> productsOnSale = productProviders.getOnSaleProducts;
    bool _isEmpty = productsOnSale.isEmpty;
    final Color color = Utility(context).color;
    Size size = Utility(context).getScreenSize;
    return Scaffold(
      appBar: AppBar(
       // leading: const BackWidget(),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          text: 'Products on sale',
          color: color,
          textSize: 24.0,
          isTitle: true,
        ),
      ),
      body: _isEmpty
          ? EmptyProductWidget(displayText:'NO Product on Sale yet \ Stay Tuned')
          : GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.zero,
              // crossAxisSpacing: 10,
              childAspectRatio: size.width / (size.height * 0.45),
              children: List.generate(productsOnSale.length, (index) {
                return ChangeNotifierProvider.value(
                  value: productsOnSale[index],
                  child: const OnSaleWidget(),
                );
              }),
          ),
    );
  }
}