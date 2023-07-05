import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../provider/darkThemeProvider.dart';
import '../utility/globalMethod.dart';
import 'RecentlyViewedScreen.dart';
import 'innerScreen/orderScreen.dart';
import 'innerScreen/wishlistScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _name;
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.primary,
      //   title: Text(widget.title),
      // ),
      body: SingleChildScrollView(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            const SizedBox(
              height: 15,
            ),
            Center(

              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Hi,  ',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: _name == null ? 'User' : _name,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
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
                  Text('email@gmail.com'),
                ],
              ),
            ),



            const SizedBox(
              height: 20,
            ),
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
                await "_showAddressDialog";
              },
              color: Theme.of(context).cardColor,
            ),
            _listTiles(
              title: 'Orders',
              icon: Icons.shopping_bag,
              onPressed: () {
                GlobalMethods.navigateTo(
                    ctx: context, routeName: OrdersScreen.routeName);
              },
              color: Theme.of(context).cardColor,
            ),
            _listTiles(
              title: 'Wishlist',
              icon: Icons.rate_review,
              onPressed: () {
                GlobalMethods.navigateTo(
                    ctx: context, routeName: WishlistScreen.routeName);
              },
              color: Theme.of(context).cardColor,
            ),
            _listTiles(
              title: 'Viewed',
              icon: Icons.view_agenda,
              onPressed: () {
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
                // GlobalMethods.navigateTo(
                //     ctx: context,
                //     routeName: ViewedRecentlyScreen.routeName);
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
                      //await authInstance.signOut();
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => const LoginScreen(),
                      //   ),
                      // );
                    },
                    context: context);
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
