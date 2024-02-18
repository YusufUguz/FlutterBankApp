import 'package:bank_app/auth.dart';
import 'package:bank_app/constants.dart';
import 'package:bank_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class HomeScreenAppbarLeading extends StatelessWidget {
  HomeScreenAppbarLeading({
    super.key,
  });

  Auth auth = Auth();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(FontAwesomeIcons.xmark),
      onPressed: () {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text(
              "Çıkış Yapıyorsunuz..",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: const Text(
              "Çıkış Yapmak istediğinizden emin misiniz?",
              style: TextStyle(fontFamily: 'Blogger_Sans', fontSize: 18),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Container(
                  color: appsMainColor,
                  padding: const EdgeInsets.all(14),
                  child: const Text(
                    "Hayır",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Blogger_Sans',
                        fontSize: 17),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  auth.signOut();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Container(
                  color: appsMainColor,
                  padding: const EdgeInsets.all(14),
                  child: const Text(
                    "Evet",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Blogger_Sans',
                        fontSize: 17),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
