import 'package:bank_app/auth.dart';
import 'package:bank_app/constants.dart';
import 'package:bank_app/screens/login_screen.dart';
import 'package:bank_app/widgets/my_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  bool isChecked = false;
  bool isChecked2 = false;

  final _nameController = TextEditingController();
  final _tcNoController = TextEditingController();
  final _telNoController = TextEditingController();
  final _emailController = TextEditingController();
  final _dogumTarihiController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.chevronLeft),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: appsMainColor,
      ),
      body: Form(
        key: formKey,
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Müşterimiz Olun',
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: appsMainColor),
                      ),
                      MyTextFormField(
                          validatorCondition: (value) {
                            const pattern = r'^[A-Z][a-z]+\s[A-Z][a-z]+$';
                            final regExp = RegExp(pattern);

                            if (value!.isEmpty) {
                              return 'Ad ve Soyadınızı Giriniz.';
                            } else if (!regExp.hasMatch(value)) {
                              return 'Ad ve soyadı boşluk bırakarak ve ilk harflerini büyük olarak giriniz.';
                            }
                            return null;
                          },
                          controller: _nameController,
                          keyboardType: TextInputType.name,
                          obSecure: false,
                          labelText: 'Ad Soyad',
                          icon: FontAwesomeIcons.user,
                          hintText: 'Adınızı ve Soyadınızı Giriniz..'),
                      MyTextFormField(
                          obSecure: false,
                          controller: _tcNoController,
                          hintText: 'TC Kimlik Numaranızı Giriniz..',
                          icon: FontAwesomeIcons.idCard,
                          keyboardType: TextInputType.number,
                          labelText: 'TC Kimlik Numarası',
                          maxLength: 11,
                          validatorCondition: (value) {
                            if (value!.length < 11) {
                              return 'Kimlik numaranız 11 haneli sayılardan oluşmalıdır.';
                            }
                            return null;
                          }),
                      MyTextFormField(
                          controller: _telNoController,
                          validatorCondition: (value) {
                            if (value!.length < 10) {
                              return 'Tel No başında 0 olmadan,10 haneli sayılardan oluşmalıdır.';
                            }
                            return null;
                          },
                          obSecure: false,
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                          labelText: 'Telefon numarası',
                          icon: FontAwesomeIcons.phone,
                          hintText: 'Telefon Numaranızı Giriniz..'),
                      MyTextFormField(
                          controller: _emailController,
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
                          obSecure: false,
                          keyboardType: TextInputType.emailAddress,
                          labelText: 'E-Posta',
                          icon: FontAwesomeIcons.envelope,
                          hintText: 'E-Posta Adresinizi Giriniz..'),
                      MyTextFormField(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2030));

                            if (pickedDate != null) {
                              setState(() {
                                _dogumTarihiController.text =
                                    DateFormat('dd.MM.yyyy').format(pickedDate);
                              });
                            }
                          },
                          obSecure: false,
                          controller: _dogumTarihiController,
                          keyboardType: TextInputType.datetime,
                          labelText: 'Doğum Tarihi',
                          icon: FontAwesomeIcons.cakeCandles,
                          hintText: 'Doğum Tarihinizi Giriniz..'),
                      MyTextFormField(
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
                      ListTileTheme(
                        horizontalTitleGap: 0,
                        child: CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            title: const Text(
                              textAlign: TextAlign.left,
                              'Üyelik Sözleşmesini okudum,onaylıyorum.',
                              style: TextStyle(
                                  fontSize: 18, fontFamily: 'Blogger_Sans'),
                            ),
                            controlAffinity: ListTileControlAffinity.leading,
                            activeColor: appsMainColor,
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value!;
                              });
                            }),
                      ),
                      ListTileTheme(
                        horizontalTitleGap: 0,
                        child: CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            title: const Text(
                              textAlign: TextAlign.left,
                              'Aydınlatma metnini okudum,onaylıyorum.',
                              style: TextStyle(
                                  fontSize: 18, fontFamily: 'Blogger_Sans'),
                            ),
                            controlAffinity: ListTileControlAffinity.leading,
                            activeColor: appsMainColor,
                            value: isChecked2,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked2 = value!;
                              });
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, right: 25, bottom: 20),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor: appsMainColor),
                          onPressed: () {
                            final isValid = formKey.currentState?.validate();
                            if (isValid!) {
                              formKey.currentState?.save();
                            }
                            if (isValid == false ||
                                isChecked == false ||
                                isChecked2 == false) {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text(
                                    "Bilgileriniz Yanlış!",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  content: const Text(
                                    "Bilgileri doğru girdiğinizden ve anlaşmaları kabul ettiğinizden emin olunuz.",
                                    style: TextStyle(
                                        fontFamily: 'Blogger_Sans',
                                        fontSize: 18),
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
                                          "Tamam",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            if (isValid == true &&
                                isChecked == true &&
                                isChecked2 == true) {
                              Auth().signUpWithEmailAndPassword(
                                  context: context,
                                  adSoyad: _nameController.text,
                                  tcNo: _tcNoController.text,
                                  telNo: _telNoController.text,
                                  email: _emailController.text,
                                  dogumTarihi: _dogumTarihiController.text,
                                  password: _passwordController.text);
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text(
                                    "Kayıt Başarılı.",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  content: const Text(
                                    "Kaydınız başarıyla tamamlandı.Giriş Sayfasına yönelendiriliyorsunuz.",
                                    style: TextStyle(
                                        fontFamily: 'Blogger_Sans',
                                        fontSize: 18),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return LoginScreen();
                                        }));
                                      },
                                      child: Container(
                                        color: appsMainColor,
                                        padding: const EdgeInsets.all(14),
                                        child: const Text(
                                          "Tamam",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                          child: const SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: Center(
                              child: Text(
                                'Kayıt Ol',
                                style: TextStyle(
                                    fontSize: 20, fontFamily: 'Blogger_Sans'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
