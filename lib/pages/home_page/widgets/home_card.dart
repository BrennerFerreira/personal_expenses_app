import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expenses/blocs/home_page/home_page_blocs.dart';
import 'package:personal_expenses/pages/common/blurred_card.dart';
import 'package:personal_expenses/pages/common/common_circular_indicator.dart';
import 'package:personal_expenses/pages/common/common_error_text.dart';
import 'package:personal_expenses/pages/common/user_transaction_tile.dart';

class HomeCard extends StatefulWidget {
  @override
  _HomeCardState createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  late HomeCardBloc homeCardBloc;

  @override
  void initState() {
    super.initState();
    homeCardBloc = HomeCardBloc()..add(const UpdateHomeCard());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.01,
      ),
      child: BlocProvider<HomeCardBloc>(
        create: (context) => homeCardBloc,
        child: BlurredCard(
          child: BlocBuilder<HomeCardBloc, HomeCardState>(
            builder: (context, state) {
              if (state is HomeCardLoadInProgress) {
                return CommonCircularIndicator();
              } else if (state is HomeCardLoadSuccess) {
                return Center(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      const Text(
                        "Saldo atual:",
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "R\$ ${state.pastBalance.toStringAsFixed(2).replaceAll(".", ",")}",
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Saldo com as transações agendadas:",
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "R\$ ${state.totalBalance.toStringAsFixed(2).replaceAll(".", ",")}",
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      if (state.lastTransaction != null)
                        const Text(
                          "Última transação realizada:",
                          textAlign: TextAlign.center,
                        ),
                      if (state.lastTransaction != null)
                        UserTransactionTile(transaction: state.lastTransaction!)
                      else
                        const Text(
                          "Não há nenhuma transação realizada até o momento.",
                          textAlign: TextAlign.center,
                        )
                    ],
                  ),
                );
              } else {
                return CommonErrorText();
              }
            },
          ),
        ),
      ),
    );
  }
}
