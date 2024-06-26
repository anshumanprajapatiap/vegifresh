import 'package:flutter/material.dart';
import 'package:vegifresh/utility/Utility.dart';
import 'package:vegifresh/widget/textWidget.dart';

import '../screen/innerScreen/feedsScreen.dart';
import '../utility/globalMethod.dart';

class EmptyScreenWidget extends StatelessWidget {
  const EmptyScreenWidget(
      {Key? key,
        required this.imagePath,
        required this.title,
        required this.subtitle,
        required this.buttonText})
      : super(key: key);
  final String imagePath, title, subtitle, buttonText;
  @override
  Widget build(BuildContext context) {
    final Color color = Utility(context).color;
    final themeState = Utility(context).getTheme;
    Size size = Utility(context).getScreenSize;
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Image.asset(
                    imagePath,
                    width: double.infinity,
                    height: size.height * 0.4,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Whoops!',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 40,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextWidget(text: title, color: Colors.cyan, textSize: 20),
                  const SizedBox(
                    height: 20,
                  ),
                  TextWidget(text: subtitle, color: Colors.cyan, textSize: 20),
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(
                          color: color,
                        ),
                      ),
                      primary: Theme.of(context).colorScheme.secondary,
                      // onPrimary: color,
                      padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    ),
                    onPressed: () {
                      GlobalMethods.navigateTo(
                          ctx: context, routeName: FeedsScreen.routeName);
                    },
                    child: TextWidget(
                      text: buttonText,
                      textSize: 20,
                      color:
                      themeState ? Colors.grey.shade300 : Colors.grey.shade800,
                      isTitle: true,
                    ),
                  ),
                ]),
          )),
    );
  }
}