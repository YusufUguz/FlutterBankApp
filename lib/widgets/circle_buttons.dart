import 'package:bank_app/constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CircleButtons extends StatelessWidget {
  CircleButtons({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  IconData icon;
  String text;
  Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(0),
              backgroundColor: Colors.white,
              shape: const CircleBorder()),
          child: SizedBox(
            width: 45,
            height: 45,
            child: Icon(
              icon,
              color: appsMainColor,
              size: 25,
            ),
          ),
        ),
        Text(
          maxLines: 1,
          textAlign: TextAlign.center,
          text,
          style: const TextStyle(
              fontFamily: 'Blogger_Sans', fontSize: 13, color: Colors.white),
        ),
      ],
    );
  }
}
