import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:personal_expenses/screens/home_screen/widgets/accounts_card.dart';
import 'package:personal_expenses/screens/home_screen/widgets/carousel_dot.dart';
import 'package:personal_expenses/screens/home_screen/widgets/custom_dropdown_menu.dart';
import 'package:personal_expenses/screens/home_screen/widgets/future_stats_card.dart';
import 'package:personal_expenses/screens/home_screen/widgets/home_card.dart';
import 'package:personal_expenses/screens/home_screen/widgets/monthly_stats_card.dart';
import 'package:personal_expenses/screens/home_screen/widgets/transaction_list_blurred_container.dart';
import 'package:personal_expenses/screens/transaction_form_screen/transaction_form_screen.dart';
import 'package:personal_expenses/screens/home_screen/widgets/user_transaction_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = PageController(viewportFraction: 0.925);

  double currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.page != currentIndex) {
        setState(() {
          currentIndex = _controller.page!;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4C1AC4),
        actions: [
          Padding(
            padding: EdgeInsets.only(
              right: MediaQuery.of(context).size.width * 0.025,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.add,
                size: 35,
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  builder: (context) => const UserTransactionForm(),
                );
              },
            ),
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/background.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
              ),
              width: MediaQuery.of(context).size.width * 0.6,
              child: const Text(
                "Início",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.025,
              ),
              height: MediaQuery.of(context).size.height * 0.3,
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: PageView(
                      controller: _controller,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        HomeCard(),
                        AccountsCard(),
                        MonthlyStatsCard(),
                        FutureStatsCard(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CarouselDot(currentIndex: currentIndex, page: 0),
                      CarouselDot(currentIndex: currentIndex, page: 1),
                      CarouselDot(currentIndex: currentIndex, page: 2),
                      CarouselDot(currentIndex: currentIndex, page: 3),
                    ],
                  ),
                ],
              ),
            ),
            TransactionListBlurredContainer(
              columnWidget: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomDropDownMenu(),
                  UserTransactionList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
