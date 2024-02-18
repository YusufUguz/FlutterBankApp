// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bank_app/auth.dart';
import 'package:bank_app/screens/forgot_password_screen.dart';
import 'package:bank_app/screens/register_screen.dart';
import 'package:bank_app/widgets/circle_buttons.dart';
import 'package:bank_app/widgets/my_textformfield.dart';
import 'package:bank_app/widgets/righttoleft_page_animation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bank_app/constants.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  int userHour = DateTime.now().hour;

  final _epostaController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Column(
                      children: [
                        Center(
                          child: Image.asset(
                            'images/BankLogo.png',
                            width: 180,
                            height: 180,
                          ),
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          getLoginScreenMessage(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      MyTextFormField(
                          validatorCondition: (value) {
                            const pattern =
                                r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
                            final regExp = RegExp(pattern);

                            if (value!.isEmpty) {
                              return 'E-Posta Giriniz';
                            } else if (!regExp.hasMatch(value)) {
                              return '@ ve .com bulunduran E-Posta Giriniz.';
                            }
                            return null;
                          },
                          controller: _epostaController,
                          keyboardType: TextInputType.emailAddress,
                          obSecure: false,
                          labelText: 'E-Posta',
                          icon: FontAwesomeIcons.envelope,
                          hintText: 'E-Posta Adresinizi Giriniz..'),
                      MyTextFormField(
                          onChanged: (value) {
                            if (value.length >= 6) {
                              // Maksimum uzunluğa ulaşıldığında klavyeyi kapat
                              FocusScope.of(context).unfocus();
                            }
                          },
                          maxLength: 6,
                          validatorCondition: (value) {
                            if (value!.length < 6) {
                              return 'Şifreniz 6 haneli sayılardan oluşmalıdır.';
                            }
                            return null;
                          },
                          controller: _passwordController,
                          keyboardType: TextInputType.number,
                          obSecure: true,
                          labelText: 'Şifre',
                          icon: FontAwesomeIcons.lock,
                          hintText: 'Şifrenizi Giriniz..'),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor: appsMainColor),
                          onPressed: () {
                            Auth()
                                .signInWithEmailAndPassword(
                                    context: context,
                                    email: _epostaController.text,
                                    password: _passwordController.text)
                                .catchError((dynamic error) {
                              if (error.code
                                  .contains('INVALID_LOGIN_CREDENTIALS')) {
                                errorMessage('Giriş bilgileriniz yanlış.');
                              } else {
                                errorMessage(
                                    'Giriş bilgilerinizi girdiğinizden ve doğru olduğundan emin olunuz.');
                              }
                            });
                          },
                          child: const SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: Center(
                              child: Text(
                                'Giriş Yap',
                                style: TextStyle(
                                    fontSize: 20, fontFamily: 'Blogger_Sans'),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 13.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Hesabınız yok mu? ',
                              style: TextStyle(
                                  fontSize: 16, fontFamily: 'Raleway'),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  rightToLeftPageAnimation(
                                      const RegisterScreen()),
                                );
                              },
                              child: const Text(
                                'Hesap Oluşturun',
                                style: underlineTextStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                rightToLeftPageAnimation(
                                    const ForgotPasswordScreen()));
                          },
                          child: const Text(
                            'Şifremi Unuttum',
                            style: underlineTextStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 90,
                    decoration: const BoxDecoration(
                        color: appsMainColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleButtons(
                            icon: FontAwesomeIcons.moneyBillTrendUp,
                            text: 'Piyasa Kurları',
                            onPressed: () {}),
                        CircleButtons(
                            icon: FontAwesomeIcons.buildingColumns,
                            text: 'Şube & ATM\'ler',
                            onPressed: () {}),
                        CircleButtons(
                            icon: FontAwesomeIcons.calculator,
                            text: 'Hesapla',
                            onPressed: () {}),
                        CircleButtons(
                            icon: FontAwesomeIcons.headset,
                            text: 'Çözüm Merkezi',
                            onPressed: () {}),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getLoginScreenMessage() {
    if (userHour >= 6 && userHour <= 10) {
      return 'Günaydın,Bankamıza Hoşgeldiniz.';
    } else if (userHour >= 17 && userHour <= 20) {
      return 'İyi Akşamlar,Bankamıza Hoşgeldiniz.';
    } else if (userHour >= 21 && userHour <= 5) {
      return 'İyi Geceler,Bankamıza Hoşgeldiniz.';
    }
    return 'İyi Günler,Bankamıza Hoşgeldiniz.';
  }
}

void errorMessage(String text) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
      fontSize: 14);
}
