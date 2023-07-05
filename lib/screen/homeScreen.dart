import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:vegifresh/screen/innerScreen/onSaleScreeen.dart';
import 'package:vegifresh/utility/Utility.dart';

import '../constant/constsS.dart';
import '../model/productsModel.dart';
import '../provider/darkThemeProvider.dart';
import '../provider/productProvider.dart';
import '../utility/globalMethod.dart';
import '../widget/feedsWidget.dart';
import '../widget/onSaleWidget.dart';
import '../widget/textWidget.dart';
import 'innerScreen/feedsScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final Utility utility = Utility(context);
    final themeState = utility.getTheme;
    final Color color = Utility(context).color;
    Size size = utility.getScreenSize;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.33,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Image.asset(
                    Constss.offerImages[index],
                    fit: BoxFit.fill,
                  );
                },
                autoplay: true,
                itemCount: Constss.offerImages.length,
                pagination: const SwiperPagination(
                    alignment: Alignment.bottomCenter,
                    builder: DotSwiperPaginationBuilder(
                        color: Colors.white, activeColor: Colors.greenAccent)),
                // control: const SwiperControl(color: Colors.black),
              ),
            ),
            TextButton(
                onPressed: (){
                  GlobalMethods.navigateTo(ctx: context, routeName: OnSaleScreen.routeName);
                },
                child: TextWidget(
                  text: 'View All',
                  maxLines: 1,
                  color: Colors.green,
                  textSize: 20,
                ),
            ),
            Row(
              children: [
                RotatedBox(
                  quarterTurns: -1,
                  child: Row(
                    children: [
                      TextWidget(
                          text: 'OnSale'.toUpperCase(),
                          color: Colors.blueGrey,
                          textSize: 20,
                        isTitle: true,
                        ),
                      const SizedBox(width: 5,),
                      const Icon(
                        IconlyLight.discount,
                        color: Colors.blueGrey,
                      )
                    ],

                  ),
                ),
                SizedBox(width: 8,),
                Flexible(
                  child: SizedBox(
                    height: size.height*0.24,
                    child: ListView.builder(
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, index){
                          return const OnSaleWidget();
                      }
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: 'Our products',
                    color: color,
                    textSize: 22,
                    isTitle: true,
                  ),
                  // const Spacer(),
                  TextButton(
                    onPressed: () {
                      GlobalMethods.navigateTo(ctx: context, routeName: FeedsScreen.routeName);
                    },
                    child: TextWidget(
                      text: 'Browse all',
                      maxLines: 1,
                      color: Colors.green,
                      textSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: size.width/ (size.height*0.55),
              children: List.generate(4, (index) {
                  return FeedsWidget();
              }),
            )
          ],
        ),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   final Utility utils = Utility(context);
  //   final themeState = utils.getTheme;
  //   final Color color = Utility(context).color;
  //   Size size = utils.getScreenSize;
  //   final productProviders = Provider.of<ProductsProvider>(context);
  //   List<ProductModel> allProducts = productProviders.getProducts;
  //   List<ProductModel> productsOnSale = productProviders.getOnSaleProducts;
  //   return Scaffold(
  //     body: SingleChildScrollView(
  //       child: Column(
  //         children: [
  //           SizedBox(
  //             height: size.height * 0.33,
  //             child: Swiper(
  //               itemBuilder: (BuildContext context, int index) {
  //                 return Image.asset(
  //                   Constss.offerImages[index],
  //                   fit: BoxFit.fill,
  //                 );
  //               },
  //               autoplay: true,
  //               itemCount: Constss.offerImages.length,
  //               pagination: const SwiperPagination(
  //                   alignment: Alignment.bottomCenter,
  //                   builder: DotSwiperPaginationBuilder(
  //                       color: Colors.white, activeColor: Colors.red)),
  //               // control: const SwiperControl(color: Colors.black),
  //             ),
  //           ),
  //           const SizedBox(
  //             height: 6,
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               // GlobalMethods.navigateTo(
  //               //     ctx: context, routeName: OnSaleScreen.routeName);
  //             },
  //             child: TextWidget(
  //               text: 'View all',
  //               maxLines: 1,
  //               color: Colors.blue,
  //               textSize: 20,
  //             ),
  //           ),
  //           const SizedBox(
  //             height: 6,
  //           ),
  //           Row(
  //             children: [
  //               RotatedBox(
  //                 quarterTurns: -1,
  //                 child: Row(
  //                   children: [
  //                     TextWidget(
  //                       text: 'On sale'.toUpperCase(),
  //                       color: Colors.red,
  //                       textSize: 22,
  //                       isTitle: true,
  //                     ),
  //                     const SizedBox(
  //                       width: 5,
  //                     ),
  //                     const Icon(
  //                       IconlyLight.discount,
  //                       color: Colors.red,
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               const SizedBox(
  //                 width: 8,
  //               ),
  //               Flexible(
  //                 child: SizedBox(
  //                   height: size.height * 0.24,
  //                   child: ListView.builder(
  //                       itemCount: productsOnSale.length < 10
  //                           ? productsOnSale.length
  //                           : 10,
  //                       scrollDirection: Axis.horizontal,
  //                       itemBuilder: (ctx, index) {
  //                         return ChangeNotifierProvider.value(
  //                             value: productsOnSale[index],
  //                             child: const OnSaleWidget());
  //                       }),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           const SizedBox(
  //             height: 10,
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 TextWidget(
  //                   text: 'Our products',
  //                   color: color,
  //                   textSize: 22,
  //                   isTitle: true,
  //                 ),
  //                 // const Spacer(),
  //                 TextButton(
  //                   onPressed: () {
  //                     // GlobalMethods.navigateTo(
  //                     //     ctx: context, routeName: FeedsScreen.routeName);
  //                   },
  //                   child: TextWidget(
  //                     text: 'Browse all',
  //                     maxLines: 1,
  //                     color: Colors.blue,
  //                     textSize: 20,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           GridView.count(
  //             shrinkWrap: true,
  //             physics: const NeverScrollableScrollPhysics(),
  //             crossAxisCount: 2,
  //             padding: EdgeInsets.zero,
  //             // crossAxisSpacing: 10,
  //             childAspectRatio: size.width / (size.height * 0.61),
  //             children: List.generate(
  //                 allProducts.length < 4
  //                     ? allProducts.length // length 3
  //                     : 4, (index) {
  //               return ChangeNotifierProvider.value(
  //                 value: allProducts[index],
  //                 child: const FeedsWidget(),
  //               );
  //             }),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
