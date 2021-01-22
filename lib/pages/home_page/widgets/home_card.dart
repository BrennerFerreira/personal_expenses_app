import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expenses/blocs/home_page/home_page_blocs.dart';
import 'package:personal_expenses/pages/common/blurred_card.dart';
import 'package:personal_expenses/pages/common/common_circular_indicator.dart';
import 'package:personal_expenses/pages/common/common_error_text.dart';
import 'package:personal_expenses/pages/common/user_transaction_tile.dart';

class HomeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homeCardBloc = HomeCardBloc()..add(const UpdateHomeCard());
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
                      "R\$ ${state.balance.toStringAsFixed(2).replaceAll(".", ",")}",
                      style: const TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
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
          }),
        ),
      ),
    );
  }
}
