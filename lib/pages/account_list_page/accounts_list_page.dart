import 'package:flutter/material.dart';

import '../common/common_scaffold.dart';
import '../home_page/home_page.dart';
import 'widgets/account_list.dart';

class AccountListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => HomePage(),
          ),
          (route) => false,
        );
        return true;
      },
      child: CommonScaffold(
        leadingButton: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 35,
              semanticLabel: "Retornar para a tela anterior.",
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
      ),
    );
  }
}
