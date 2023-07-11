import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:vegifresh/screen/authScreen/forgetPasswordScreen.dart';

import '../constant/firebaseConstant.dart';
import '../provider/darkThemeProvider.dart';
import '../utility/globalMethod.dart';
import 'authScreen/singInScreen.dart';
import 'innerScreen/RecentlyViewedScreen.dart';
import 'innerScreen/orderScreen.dart';
import 'innerScreen/wishlistScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _name = "";
  String? _email = "";
  @override
  Widget build(BuildContext context) {
    final User? user = authInstance.currentUser;
    final themeState = Provider.of<DarkThemeProvider>(context);
    if(user!=null){
      _name = user.displayName;
      _email = user.email;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: user!=null ? Center(

          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              RichText(
                text: TextSpan(
                  text: 'Hi,  ',
                  style: TextStyle(
                    color: Theme.of(context).canvasColor,
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: _name ?? 'User',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.background,
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print('My name is pressed');
                          }),

                  ],
                ),
              ),
              Text(
                _email ?? '',
                style: TextStyle(
                  // color: Theme.of(context).colorScheme.background,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        )
        :Container(),

      ),
      body: SingleChildScrollView(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Divider(
              thickness: 2,
            ),
            const SizedBox(
              height: 20,
            ),

            _listTiles(
              title: 'Address 2',
              subtitle: "address",
              icon: Icons.add_road_outlined,
              onPressed: () async {
                if (user == null) {
                  GlobalMethods.errorDialog(
                      subtitle: 'No user found, Please login first',
                      context: context);
                  return;
                }
                await "_showAddressDialog";
              },
              color: Theme.of(context).cardColor,
            ),
            _listTiles(
              title: 'Orders',
              icon: Icons.shopping_bag,
              onPressed: () {
                if (user == null) {
                  GlobalMethods.errorDialog(
                      subtitle: 'No user found, Please login first',
                      context: context);
                  return;
                }
                GlobalMethods.navigateTo(
                    ctx: context, routeName: OrdersScreen.routeName);
              },
              color: Theme.of(context).cardColor,
            ),
            _listTiles(
              title: 'Wishlist',
              icon: Icons.rate_review,
              onPressed: () {
                if (user == null) {
                  GlobalMethods.errorDialog(
                      subtitle: 'No user found, Please login first',
                      context: context);
                  return;
                }
                GlobalMethods.navigateTo(
                    ctx: context, routeName: WishlistScreen.routeName);
              },
              color: Theme.of(context).cardColor,
            ),
            _listTiles(
              title: 'Viewed',
              icon: Icons.view_agenda,
              onPressed: () {
                if (user == null) {
                  GlobalMethods.errorDialog(
                      subtitle: 'No user found, Please login first',
                      context: context);
                  return;
                }
                GlobalMethods.navigateTo(
                    ctx: context,
                    routeName: RecentlyViewedScreen.routeName);
              },
              color: Theme.of(context).cardColor,
            ),
            _listTiles(
              title: 'Forget Password',
              icon: Icons.password,
              onPressed: () {
                // if (user == null) {
                //   GlobalMethods.errorDialog(
                //       subtitle: 'No user found, Please login first',
                //       context: context);
                //   return;
                // }
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ForgetPasswordScreen(),
                  ),
                );
              },
              color: Theme.of(context).cardColor,
            ),


            SwitchListTile(
              title: Text('Dark/Light Theme'),
              secondary: themeState.getDarkTheme ? Icon(Icons.dark_mode_outlined) : Icon(Icons.light_mode_outlined),
              onChanged: (bool val) {
                setState(() {
                  themeState.setDarkTheme = val;
                });
              },
              value: themeState.getDarkTheme ,
            ),
            user!=null ?
            _listTiles(
              title: 'Logout',
              icon: Icons.password,
              onPressed: () {
                // GlobalMethods.navigateTo(
                //     ctx: context,
                //     routeName: ViewedRecentlyScreen.routeName);
                GlobalMethods.warningDialog(
                    title: 'Sign out',
                    subtitle: 'Do you wanna sign out?',
                    fct: () async {
                      await authInstance.signOut();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    context: context);
              },
              color: Theme.of(context).cardColor,
            ) :_listTiles(
              title: 'Login',
              icon: Icons.password,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              color: Theme.of(context).cardColor,
            ),
          ],
        ),
      ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _listTiles({
    required String title,
    String? subtitle,
    required IconData icon,
    required Function onPressed,
    required Color color,
  }) {
    return ListTile(
      title: Text(title,
      ),
      subtitle: Text(
        subtitle == null ? "" : subtitle,
      ),
      leading: Icon(icon),
      trailing: const Icon(Icons.swipe_right_alt_rounded),
      onTap: () {
        onPressed();
      },
    );
  }
}
