import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expenses/blocs/account_list_page/account_list_page/account_list_page_bloc.dart';
import 'package:personal_expenses/pages/account_list_page/widgets/account_tile.dart';
import 'package:personal_expenses/pages/common/common_circular_indicator.dart';
import 'package:personal_expenses/pages/common/common_error_text.dart';

class AccountList extends StatefulWidget {
  @override
  _AccountListState createState() => _AccountListState();
}

class _AccountListState extends State<AccountList> {
  late AccountListPageBloc accountListPageBloc;

  @override
  void initState() {
    super.initState();
    accountListPageBloc = AccountListPageBloc()
      ..add(
        const UpdateAccountList(),
      );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccountListPageBloc>(
      create: (context) => accountListPageBloc,
      child: BlocBuilder<AccountListPageBloc, AccountListPageState>(
        builder: (context, state) {
          if (state is AccountListPageLoadInProgress) {
            return CommonCircularIndicator();
          } else if (state is AccountListPageLoadSuccess) {
            final List<String> accountList = state.accountList;
            return accountList.isEmpty
                ? const Center(
                    child: Text("Nenhuma conta cadastrada."),
                  )
                : ListView.separated(
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 10);
                    },
                    itemCount: accountList.length,
                    itemBuilder: (_, index) {
                      return AccountTile(
                        account: accountList[index],
                      );
                    },
                  );
          } else {
            return CommonErrorText();
          }
        },
      ),
    );
  }
}
