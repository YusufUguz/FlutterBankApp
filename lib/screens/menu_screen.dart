import 'package:bank_app/auth.dart';
import 'package:bank_app/constants.dart';
import 'package:bank_app/screens/Menu%20Screens/my_accounts_screen.dart';
import 'package:bank_app/screens/Menu%20Screens/my_cards_screen.dart';
import 'package:bank_app/screens/Menu%20Screens/send_money_screen.dart';
import 'package:bank_app/screens/applications_screen.dart';
import 'package:bank_app/screens/investment_screen.dart';
import 'package:bank_app/screens/login_screen.dart';
import 'package:bank_app/screens/temp_screen.dart';
import 'package:bank_app/screens/transfers_pays_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class MenuScreen extends StatelessWidget {
  MenuScreen({super.key});
  Auth auth = Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'TÜM İŞLEMLER',
          style: TextStyle(
            fontFamily: 'Blogger_Sans',
          ),
        ),
        backgroundColor: appsMainColor,
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.chevronLeft),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
          child: ListView(
        addAutomaticKeepAlives: false,
        children: [
          MenuScreenItem(
              navigationScreen: const MyAccountsScreen(),
              leadingIcon: FontAwesomeIcons.wallet,
              titleText: 'Hesaplarım'),
          MenuScreenItem(
              navigationScreen: const MyCardsScreen(),
              leadingIcon: FontAwesomeIcons.creditCard,
              titleText: 'Kartlarım'),
          MenuScreenItem(
              leadingIcon: FontAwesomeIcons.paperPlane,
              navigationScreen: const SendMoneyScreen(),
              titleText: 'Para Gönder (Havale/EFT)'),
          MenuScreenItem(
              navigationScreen: const TransfersAndPaysScreen(),
              leadingIcon: FontAwesomeIcons.moneyBillWave,
              titleText: 'Ödemeler'),
          MenuScreenItem(
              navigationScreen: const ApplicationsScreen(),
              leadingIcon: FontAwesomeIcons.plus,
              titleText: 'Başvurular'),
          MenuScreenItem(
              navigationScreen: const TempScreen(),
              leadingIcon: FontAwesomeIcons.fileInvoice,
              titleText: 'Kredi İşlemleri'),
          MenuScreenItem(
              navigationScreen: const TempScreen(),
              leadingIcon: FontAwesomeIcons.handHoldingDollar,
              titleText: 'Sigorta ve Emeklilik İşlemleri'),
          MenuScreenItem(
              navigationScreen: const InvestmentScreen(),
              leadingIcon: FontAwesomeIcons.chartPie,
              titleText: 'Yatırım İşlemleri'),
          MenuScreenItem(
              navigationScreen: const TempScreen(),
              leadingIcon: FontAwesomeIcons.qrcode,
              titleText: 'QR İşlemleri'),
          MenuScreenItem(
              navigationScreen: const TempScreen(),
              leadingIcon: FontAwesomeIcons.gear,
              titleText: 'Ayarlar'),
          MenuScreenItem(
              navigationScreen: const TempScreen(),
              leadingIcon: FontAwesomeIcons.headset,
              titleText: 'Bize ulaşın'),
          ListTile(
            onTap: () {
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
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginScreen()));
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
            leading:
                const Icon(FontAwesomeIcons.arrowLeft, color: appsMainColor),
            title: const Text('Çıkış Yap',
                style: TextStyle(
                  color: appsMainColor,
                  fontSize: 20,
                )),
          ),
        ],
      )),
    );
  }
}

// ignore: must_be_immutable
class MenuScreenItem extends StatelessWidget {
  MenuScreenItem({
    super.key,
    required this.navigationScreen,
    required this.leadingIcon,
    required this.titleText,
  });

  Widget navigationScreen;
  IconData leadingIcon;
  String titleText;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => navigationScreen));
      },
      leading: Icon(
        leadingIcon,
        color: appsMainColor,
      ),
      title: Text(
        titleText,
        style: const TextStyle(
          color: appsMainColor,
          fontSize: 20,
        ),
      ),
      trailing: const Icon(FontAwesomeIcons.chevronRight),
    );
  }
}
