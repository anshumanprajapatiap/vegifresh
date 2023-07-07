import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vegifresh/constant/themeData.dart';
import 'package:vegifresh/provider/cartProvider.dart';
import 'package:vegifresh/provider/darkThemeProvider.dart';
import 'package:vegifresh/provider/productProvider.dart';
import 'package:vegifresh/provider/viewedProductProvider.dart';
import 'package:vegifresh/provider/wishlistProvider.dart';
import 'package:vegifresh/screen/innerScreen/RecentlyViewedScreen.dart';
import 'package:vegifresh/screen/authScreen/forgetPasswordScreen.dart';
import 'package:vegifresh/screen/authScreen/registerNewUserScreen.dart';
import 'package:vegifresh/screen/authScreen/singInScreen.dart';
import 'package:vegifresh/screen/bottomBarScreen.dart';
import 'package:vegifresh/screen/innerScreen/categoryScreen.dart';
import 'package:vegifresh/screen/innerScreen/feedsScreen.dart';
import 'package:vegifresh/screen/innerScreen/onSaleScreeen.dart';
import 'package:vegifresh/screen/innerScreen/orderScreen.dart';
import 'package:vegifresh/screen/innerScreen/productDetailScreen.dart';
import 'package:vegifresh/screen/innerScreen/wishlistScreen.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //requestPermissions();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async{
    themeChangeProvider.setDarkTheme = await themeChangeProvider.darkThemePref.getTheme();
  }

  @override
  void initState() {
    // TODO: implement initState
    getCurrentAppTheme();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool _useMaterial3 = true;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return themeChangeProvider;
        }),
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
        ChangeNotifierProvider(create: (_) => ViewedProdProvider())
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (context, themeProvider, child){

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: CustomStyles.themeData(themeChangeProvider.getDarkTheme, _useMaterial3, context),
            // theme: ThemeData(
            //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
            //   useMaterial3: _useMaterial3,
            // ),
            home: BottomBarScreen(),
            routes: {
              OnSaleScreen.routeName: (ctx) => const OnSaleScreen(),
              FeedsScreen.routeName: (ctx) => const FeedsScreen(),
              ProductDetailScreen.routeName: (ctx) => const ProductDetailScreen(),
              WishlistScreen.routeName: (ctx) => const WishlistScreen(),
              OrdersScreen.routeName: (ctx) => const OrdersScreen(),
              RecentlyViewedScreen.routeName: (ctx) => const RecentlyViewedScreen(),
              RegisterScreen.routeName: (ctx) => const RegisterScreen(),
              LoginScreen.routeName: (ctx) => const LoginScreen(),
              ForgetPasswordScreen.routeName: (ctx) => const ForgetPasswordScreen(),
              CategoryScreen.routeName: (ctx) => const CategoryScreen(),
            },
          );
        },
      ),
    );
  }
}
