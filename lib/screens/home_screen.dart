import 'package:bank_app/constants.dart';
import 'package:bank_app/screens/applications_screen.dart';
import 'package:bank_app/screens/investment_screen.dart';
import 'package:bank_app/screens/menu_screen.dart';
import 'package:bank_app/screens/offers_screen.dart';
import 'package:bank_app/screens/profile_screen.dart';
import 'package:bank_app/screens/transfers_pays_screen.dart';
import 'package:bank_app/widgets/circle_buttons.dart';
import 'package:bank_app/widgets/home_screen_appbar_leading.dart';
import 'package:bank_app/widgets/righttoleft_page_animation.dart';
import 'package:bank_app/widgets/scale_animation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int userHour = DateTime.now().hour;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? usersName;
  String? usersAccountIBAN;
  String? usersAccountMoney;
  String? usersAccountName;
  String? usersAccountType;
  String? usersCardName;
  String? usersCardNumber;
  String? usersCardSKT;
  int? usersCard3DSecure;
  String? usersCardsMoney;
  String? usersCardType;
  DateTime? usersTransactionDate;
  String? usersTransactionDetails;
  int? usersTransactionAmount;
  String? formattedUsersTransactionDate;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    final User? user = _auth.currentUser;

    if (user != null) {
      final QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where(
            'email',
            isEqualTo: user.email,
          )
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final userData =
            querySnapshot.docs.first.data() as Map<String, dynamic>;
        setState(() {
          usersName = userData['adSoyad'];
          usersAccountIBAN = userData['account']['account1']['accountIBAN'];
          usersAccountName = userData['account']['account1']['accountName'];
          usersAccountMoney = userData['account']['account1']['accountMoney'];
          usersAccountType = userData['account']['account1']['accountType'];
          usersCardName = userData['cards']['card1']['cardName'];
          usersCardNumber = userData['cards']['card1']['cardNumber'];
          usersCardSKT = userData['cards']['card1']['cardSKT'];
          usersCard3DSecure = userData['cards']['card1']['card3DSecure'];
          usersCardsMoney = userData['cards']['card1']['cardMoney'];
          usersCardType = userData['cards']['card1']['cardType'];
          usersTransactionDate =
              userData['Transactions']['Transaction1']['TDateAndTime'].toDate();
          usersTransactionDetails =
              userData['Transactions']['Transaction1']['TDetails'];
          usersTransactionAmount =
              userData['Transactions']['Transaction1']['TAmount'];
          formattedUsersTransactionDate =
              DateFormat('dd/MM/yy\nhh.mm').format(usersTransactionDate!);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                rightToLeftPageAnimation(const ProfileScreen()),
              );
            },
            icon: const Icon(FontAwesomeIcons.user),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                rightToLeftPageAnimation(MenuScreen()),
              );
            },
            icon: const Icon(FontAwesomeIcons.bars),
          ),
        ],
        backgroundColor: appsMainColor,
        leading: HomeScreenAppbarLeading(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      getLoginScreenMessage(),
                      style: const TextStyle(
                        fontFamily: 'RobotoSlab',
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    (usersName == null)
                        ? const SizedBox(
                            width: 15,
                            height: 15,
                            child: CircularProgressIndicator(
                              color: appsMainColor,
                            ),
                          )
                        : Text(
                            '$usersName',
                            style: const TextStyle(
                                color: appsMainColor,
                                fontSize: 20,
                                fontFamily: 'RobotoSlab',
                                fontWeight: FontWeight.bold),
                          ),
                  ],
                ),
                SizedBox(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                        indicatorWeight: 3,
                        indicatorColor: appsMainColor,
                        isScrollable: true,
                        labelStyle: const TextStyle(
                            fontFamily: 'RobotoSlab', fontSize: 17),
                        labelPadding:
                            const EdgeInsets.only(left: 10, right: 10),
                        labelColor: appsMainColor,
                        unselectedLabelColor: Colors.grey,
                        controller: tabController,
                        tabs: const [
                          Tab(
                            text: 'Hesaplarım',
                          ),
                          Tab(
                            text: 'Kartlarım',
                          ),
                        ]),
                  ),
                ),
                SizedBox(
                  width: double.maxFinite,
                  height: MediaQuery.of(context).size.height * 0.27,
                  child: TabBarView(controller: tabController, children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: appsMainColor),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  (usersAccountName == null)
                                      ? const MyCircularIndicator()
                                      : HomeScreenContainerTexts(
                                          text: '$usersAccountName',
                                        ),
                                  (usersAccountIBAN == null)
                                      ? const MyCircularIndicator()
                                      : HomeScreenContainerTexts(
                                          text: '$usersAccountIBAN')
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Bakiye',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontFamily: 'Blogger_Sans'),
                                      ),
                                      (usersAccountMoney == null)
                                          ? const MyCircularIndicator()
                                          : HomeScreenContainerTexts(
                                              text: '$usersAccountMoney TL')
                                    ],
                                  ),
                                  (usersAccountType == null)
                                      ? const MyCircularIndicator()
                                      : HomeScreenContainerTexts(
                                          text: '$usersAccountType')
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: appsMainColor),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      (usersAccountName == null)
                                          ? const MyCircularIndicator()
                                          : HomeScreenContainerTexts(
                                              text: '$usersCardName',
                                            ),
                                      (usersAccountIBAN == null)
                                          ? const MyCircularIndicator()
                                          : HomeScreenContainerTexts(
                                              text: '$usersCardNumber')
                                    ],
                                  ),
                                  Image.asset(
                                    'images/BankLogo.png',
                                    width: 70,
                                    height: 70,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Bakiye',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontFamily: 'Blogger_Sans'),
                                      ),
                                      (usersAccountMoney == null)
                                          ? const MyCircularIndicator()
                                          : HomeScreenContainerTexts(
                                              text: '$usersCardsMoney TL')
                                    ],
                                  ),
                                  (usersAccountType == null)
                                      ? const MyCircularIndicator()
                                      : HomeScreenContainerTexts(
                                          text: '$usersCardType'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.13,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: appsMainColor),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleButtons(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(scaleAnimation(const OffersScreen()));
                              },
                              icon: FontAwesomeIcons.tags,
                              text: 'Kampanyalar'),
                          CircleButtons(
                              onPressed: () {
                                Navigator.of(context).push(scaleAnimation(
                                    const TransfersAndPaysScreen()));
                              },
                              icon: FontAwesomeIcons.moneyBillTransfer,
                              text: 'Transfer&Ödeme'),
                          CircleButtons(
                              onPressed: () {
                                Navigator.of(context).push(
                                    scaleAnimation(const InvestmentScreen()));
                              },
                              icon: FontAwesomeIcons.chartPie,
                              text: 'Yatırımlarım'),
                          CircleButtons(
                              onPressed: () {
                                Navigator.of(context).push(
                                    scaleAnimation(const ApplicationsScreen()));
                              },
                              icon: FontAwesomeIcons.plus,
                              text: 'Başvurular'),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.35,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 227, 225, 225),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          const Text(
                            'Hesap ve Kart Hareketleri',
                            style: TextStyle(
                                color: appsMainColor,
                                fontSize: 23,
                                fontFamily: 'RobotoSlab',
                                fontWeight: FontWeight.bold),
                          ),
                          const Divider(
                              color: appsMainColor,
                              endIndent: 20,
                              indent: 20,
                              thickness: 2),
                          Container(
                            height: 70,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '$formattedUsersTransactionDate',
                                    style: const TextStyle(
                                        fontSize: 16, color: appsMainColor),
                                  ),
                                  Text(
                                    textAlign: TextAlign.center,
                                    '$usersTransactionDetails',
                                    style: const TextStyle(
                                        fontSize: 16, color: appsMainColor),
                                  ),
                                  (usersTransactionDetails == 'Para Gönderme' ||
                                          usersTransactionDetails ==
                                              'Para Çekme')
                                      ? Text(
                                          '- $usersTransactionAmount TL',
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: (usersTransactionDetails ==
                                                          'Para Gönderme' ||
                                                      usersTransactionDetails ==
                                                          'Para Çekme')
                                                  ? Colors.red
                                                  : Colors.green),
                                        )
                                      : Text(
                                          '+ $usersTransactionAmount TL',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: (usersTransactionDetails ==
                                                      'Para Gönderme')
                                                  ? Colors.red
                                                  : Colors.green),
                                        )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 5,
                    top: 20.0,
                  ),
                  child: Text(
                    'Size Özel',
                    style: TextStyle(
                        fontFamily: 'RobotoSlab',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: appsMainColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('specialOffers')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      }
                      final documents = snapshot.data?.docs;
                      return SizedBox(
                        height: 340,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: documents?.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final document = documents?[index];

                            final data = document?.data();
                            return SizedBox(
                              width: MediaQuery.of(context).size.width * 0.85,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: const Color.fromARGB(255, 227, 225, 225),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      child: Image.asset(
                                        data?['offer']['offerImagePath'],
                                        fit: BoxFit.cover,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.85,
                                        height: 170,
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 15.0, bottom: 10),
                                          child: Text(
                                            data?['offer']['offerTitle'],
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: appsMainColor,
                                              fontSize: 18,
                                              fontFamily: 'RobotoSlab',
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            const Icon(
                                              FontAwesomeIcons.calendarDay,
                                              color: appsMainColor,
                                            ),
                                            const SizedBox(
                                              width: 7,
                                            ),
                                            const Text(
                                              'Son Tarih : ',
                                              style: TextStyle(
                                                color: appsMainColor,
                                                fontSize: 17,
                                                fontFamily: 'Blogger_Sans',
                                              ),
                                            ),
                                            Text(
                                              data?['offer']['offerLastDate'],
                                              style: const TextStyle(
                                                color: appsMainColor,
                                                fontSize: 17,
                                                fontFamily: 'Blogger_Sans',
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            right: 10.0,
                                            top: 10,
                                          ),
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      appsMainColor),
                                              onPressed: () {},
                                              child: const Text(
                                                'Katıl',
                                              )),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getLoginScreenMessage() {
    if (userHour >= 6 && userHour <= 10) {
      return 'Günaydın,';
    } else if (userHour >= 17 && userHour <= 20) {
      return 'İyi Akşamlar,';
    } else if (userHour >= 21 && userHour <= 5) {
      return 'İyi Geceler,';
    }
    return 'İyi Günler,';
  }
}

class MyCircularIndicator extends StatelessWidget {
  const MyCircularIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
        width: 15,
        height: 15,
        child: CircularProgressIndicator(
          color: Colors.white,
        ));
  }
}

class HomeScreenContainerTexts extends StatelessWidget {
  const HomeScreenContainerTexts({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          color: Colors.white, fontSize: 20, fontFamily: 'RobotoSlab'),
    );
  }
}

/*

Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              color: appsMainColor),
                                          child: const Text(
                                            'Hesabınız Bulunmamaktadır.',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'RobotoSlab',
                                                color: Colors.white),
                                          ),
                                        ) */