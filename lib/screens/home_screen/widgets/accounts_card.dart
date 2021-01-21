import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expenses/blocs/blocs.dart';
import 'package:personal_expenses/screens/accounts_screen/accounts_screen.dart';
import 'package:personal_expenses/screens/home_screen/widgets/blurred_container.dart';

class AccountsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AccountsScreen(),
          ),
        );
      },
      child: BlurredContainer(
        blocBuilder: BlocBuilder<AccountStatsBloc, AccountStatsState>(
          builder: (context, state) {
            if (state is AccountStatsLoadInProgress) {
              return Center(
                child: CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).accentColor,
                  ),
                ),
              );
            } else if (state is AccountStatsLoadAllSuccess) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          top: 10.0,
                          bottom: 10.0,
                        ),
                        child: Text(
                          "Saldo das contas cadastradas:",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      if (state.accountsBalanceMap.isEmpty)
                        const Expanded(
                          child: Center(
                            child: Text("Nehuma conta cadastrada."),
                          ),
                        )
                      else
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.accountsBalanceMap.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                dense: true,
                                title: Text(
                                    state.accountsBalanceMap[index].keys.first),
                                trailing: Text(
                                  "R\$ " +
                                      state.accountsBalanceMap[index].values
                                          .first
                                          .toStringAsFixed(2)
                                          .replaceAll(".", ","),
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
          buildWhen: (previousState, currentState) {
            return previousState is AccountStatsLoadInProgress &&
                currentState is AccountStatsLoadAllSuccess;
          },
        ),
      ),
    );
  }
}
