import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expenses/blocs/home_page/home_page_blocs.dart';
import 'package:personal_expenses/pages/account_list_page/accounts_list_page.dart';
import 'package:personal_expenses/pages/common/blurred_card.dart';
import 'package:personal_expenses/pages/common/common_circular_indicator.dart';
import 'package:personal_expenses/pages/common/common_error_text.dart';

class AccountsCard extends StatefulWidget {
  @override
  _AccountsCardState createState() => _AccountsCardState();
}

class _AccountsCardState extends State<AccountsCard> {
  late AccountsCardBloc accountsCardBloc;

  @override
  void initState() {
    super.initState();
    accountsCardBloc = AccountsCardBloc()
      ..add(
        const UpdateAccountsCard(),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.01,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => AccountListPage(),
            ),
          );
        },
        child: BlurredCard(
          child: BlocProvider<AccountsCardBloc>(
            create: (context) => accountsCardBloc,
            child: Center(
              child: BlocBuilder<AccountsCardBloc, AccountsCardState>(
                  value: accountsCardBloc,
                  builder: (context, state) {
                    if (state is AccountsCardLoadInProgress) {
                      return CommonCircularIndicator();
                    } else if (state is AccountsCardLoadSuccess) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 10),
                          if (state.accountsBalanceMap.isNotEmpty)
                            const Text("Saldo das contas cadastradas:"),
                          Expanded(
                            child: state.accountsBalanceMap.isEmpty
                                ? const Center(
                                    child: Text("Nenhuma conta cadastrada."),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: state.accountsBalanceMap.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(
                                          state.accountsBalanceMap[index].keys
                                              .first,
                                        ),
                                        trailing: Text(
                                            "R\$ ${state.accountsBalanceMap[index].values.first.toStringAsFixed(2).replaceAll(".", ",")}"),
                                      );
                                    },
                                  ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      );
                    } else {
                      return CommonErrorText();
                    }
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
