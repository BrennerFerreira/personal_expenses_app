import 'package:flutter/material.dart';
import 'package:personal_expenses/screens/accounts_screen/widgets/account_list.dart';

class AccountsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor,
                  Theme.of(context).accentColor,
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.025,
                  bottom: MediaQuery.of(context).size.height * 0.01,
                ),
                width: MediaQuery.of(context).size.width * 0.7,
                child: const Text(
                  "Contas cadastradas",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(child: AccountList()),
            ],
          ),
        ],
      ),
    );
  }
}
