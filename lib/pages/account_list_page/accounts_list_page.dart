import 'package:flutter/material.dart';
import 'package:personal_expenses/pages/account_list_page/widgets/account_list.dart';
import 'package:personal_expenses/pages/common/common_scaffold.dart';
import 'package:personal_expenses/pages/home_page/home_page.dart';

class AccountListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      leadingButton: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 35,
          ),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (_) => HomePage(),
              ),
              (route) => false,
            );
          }),
      title: "Contas cadastradas",
      children: [
        Expanded(child: AccountList()),
      ],
    );
  }
}
