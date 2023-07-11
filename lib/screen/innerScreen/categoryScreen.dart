import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:vegifresh/constant/constsS.dart';
import 'package:vegifresh/utility/Utility.dart';
import 'package:vegifresh/widget/emptyProductWidget.dart';
import 'package:vegifresh/widget/feedsWidget.dart';

import '../../model/productsModel.dart';
import '../../provider/productProvider.dart';
import '../../widget/textWidget.dart';

class CategoryScreen extends StatefulWidget {
  static const routeName = "/CategoryScreenState";
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final TextEditingController? _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();
  List<ProductModel> listProductSearch = [];
  @override
  void dispose() {
    _searchTextController!.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    //final productsProvider = Provider.of<ProductsProvider>(context, listen: false);
    // productsProvider.fetchProducts();
    super.initState();
  }
  //List<ProductModel> allProducts= [];
  @override
  Widget build(BuildContext context) {
    final Color color = Utility(context).color;
    Size size = Utility(context).getScreenSize;
    final productsProvider = Provider.of<ProductsProvider>(context);
    final categoryName = ModalRoute.of(context)!.settings.arguments as String;
    List<ProductModel> productByCategory= productsProvider.findByCategory(categoryName);
    return Scaffold(
      appBar: AppBar(
        // leading: const BackWidget(),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: TextWidget(
          text: '$categoryName',
          color: color,
          textSize: 20.0,
          isTitle: true,
        ),
      ),
      body: productByCategory.isEmpty
          ? const EmptyProductWidget(displayText: 'No Product on this category')
          : SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: kBottomNavigationBarHeight,
                  child: TextField(
                    focusNode: _searchTextFocusNode,
                    controller: _searchTextController,
                    onChanged: (valuee) {
                      setState(() {
                        listProductSearch = productsProvider.searchQuery(valuee);
                      });
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                        const BorderSide(color: Colors.greenAccent, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                        const BorderSide(color: Colors.greenAccent, width: 1),
                      ),
                      hintText: "What's in your mind",
                      prefixIcon: const Icon(Icons.search),
                      suffix: IconButton(
                        onPressed: () {
                          _searchTextController!.clear();
                          _searchTextFocusNode.unfocus();
                        },
                        icon: Icon(
                          Icons.close,
                          color: _searchTextFocusNode.hasFocus ? Colors.red : color,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              _searchTextController!.text.isNotEmpty && listProductSearch.isEmpty
                  ? EmptyProductWidget(displayText: 'No products found, please try another keyword')
                  :
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                padding: EdgeInsets.zero,
                // crossAxisSpacing: 10,
                childAspectRatio: size.width / (size.height * 0.61),
                children: List.generate(
                    _searchTextController!.text.isNotEmpty
                        ? listProductSearch.length
                        : productByCategory.length, (index) {
                  return ChangeNotifierProvider.value(
                    value: _searchTextController!.text.isNotEmpty
                        ? listProductSearch[index]
                        : productByCategory[index],
                    child: const FeedsWidget(),
                  );
                }),
                // children: List.generate(productByCategory.length, (index) {
                //   return ChangeNotifierProvider.value(
                //     value: productByCategory[index],
                //     child: FeedsWidget(),
                //   );
                // }),
              ),
            ]),
          ),
    );
  }
}