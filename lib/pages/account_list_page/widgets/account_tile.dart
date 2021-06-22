import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/account_list_page/account_tile/account_tile_bloc.dart';
import '../../account_details_page/account_details_page.dart';
import '../../common/balance_card.dart';
import '../../common/blurred_card.dart';
import '../../common/common_circular_indicator.dart';
import '../../common/common_error_text.dart';

class AccountTile extends StatefulWidget {
  final String account;

  const AccountTile({
    Key? key,
    required this.account,
  }) : super(key: key);

  @override
  _AccountTileState createState() => _AccountTileState();
}

class _AccountTileState extends State<AccountTile> {
  late AccountTileBloc accountTileBloc;

  @override
  void initState() {
    super.initState();
    accountTileBloc = AccountTileBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccountTileBloc>(
      create: (context) => accountTileBloc,
      child: BlurredCard(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: ExpansionTile(
            title: Text(
              widget.account,
            ),
            onExpansionChanged: (expanded) {
              if (expanded) {
                accountTileBloc.add(UpdateAccountTile(widget.account));
              }
            },
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BlocBuilder<AccountTileBloc, AccountTileState>(
                    bloc: accountTileBloc,
                    buildWhen: (previousState, currentState) {
                      return (currentState is AccountTileLoadSuccess) &&
                          currentState.account == widget.account;
                    },
                    builder: (context, state) {
                      if (state is AccountTileLoadInProgress) {
                        return CommonCircularIndicator();
                      } else if (state is AccountTileLoadSuccess) {
                        return InkWell(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) =>
                                    AccountDetailsPage(account: widget.account),
                              ),
                            );
                          },
                          child: ListView(
                            primary: false,
                            shrinkWrap: true,
                            children: [
                              Hero(
                                tag: widget.account,
                                child: BalanceCard(
                                  totalBalance: state.balance,
                                  totalIncome: state.income,
                                  totalOutcome: state.outcome,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "Mais detalhes",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        );
                      } else {
                        return CommonErrorText();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
