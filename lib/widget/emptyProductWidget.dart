
import 'package:flutter/material.dart';

import '../utility/Utility.dart';

class EmptyProductWidget extends StatelessWidget {
  const EmptyProductWidget({super.key,required this.displayText});
  final String displayText;

  @override
  Widget build(BuildContext context) {
    Color color = Utility(context).color;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('assets/images/box.png')
            ),
            Text(
              displayText ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                  // color: color,
                  fontSize: 30,
                  fontWeight: FontWeight.w700
              ),
            ),
          ],
        ),
      ),
    );
  }
}
