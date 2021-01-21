import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_expenses/blocs/blocs.dart';
import 'package:personal_expenses/screens/home_screen/widgets/blurred_container.dart';
import 'package:personal_expenses/screens/monthly_analysis_screen/monthly_analysis_screen.dart';

class MonthlyStatsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) {
            return BlocProvider<DateRangeFilteredTransactionsBloc>(
              lazy: false,
              create: (_) => DateRangeFilteredTransactionsBloc()
                ..add(
                  DateRangeFilterUpdate(
                    dateRange: DateTimeRange(
                      start: DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                      ),
                      end: DateTime(
                        DateTime.now().year,
                        DateTime.now().month + 1,
                        0,
                      ),
                    ),
                  ),
                ),
              child: MonthlyAnalysisScreen(),
            );
          }),
        );
      },
      child: BlurredContainer(
        blocBuilder: BlocBuilder<DateRangeStatsBloc, DateRangeStatsState>(
          builder: (context, state) {
            if (state is DateRangeStatsLoadInProgress) {
              return Center(
                child: CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).accentColor,
                  ),
                ),
              );
            } else if (state is DateRangeStatsLoadSuccess) {
              final double totalBalance =
                  state.totalIncome - state.totalOutcome;
              return Card(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Este mês:",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              FontAwesomeIcons.wallet,
                              size: 18,
                              color:
                                  Theme.of(context).textTheme.bodyText2!.color,
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              "Saldo",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "R\$ ${totalBalance.toStringAsFixed(2).replaceAll(".", ",")}",
                          style: const TextStyle(
                            fontSize: 36,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_upward,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .color,
                                    ),
                                    const SizedBox(width: 4),
                                    const Text("Entradas"),
                                  ],
                                ),
                                Text(
                                  "R\$ ${state.totalIncome.toStringAsFixed(2).replaceAll(".", ",")}",
                                  style: const TextStyle(fontSize: 28),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.arrow_downward,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .color,
                                    ),
                                    const SizedBox(width: 4),
                                    const Text("Saídas"),
                                  ],
                                ),
                                Text(
                                  "R\$ ${state.totalOutcome.toStringAsFixed(2).replaceAll(".", ",")}",
                                  style: const TextStyle(fontSize: 28),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text(
                  "Erro ao calcular o balanço do mês. Por favor, reinicie o aplicativo.",
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
