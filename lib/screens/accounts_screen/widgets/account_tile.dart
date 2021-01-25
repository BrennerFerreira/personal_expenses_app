// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:personal_expenses/blocs/old_blocs/blocs.dart';
// import 'package:personal_expenses/screens/account_details_screen/account_details_screen.dart';
// import 'package:personal_expenses/screens/common/balance_card.dart';

// class AccountTile extends StatelessWidget {
//   final String account;

//   const AccountTile({
//     Key? key,
//     required this.account,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.symmetric(
//         horizontal: MediaQuery.of(context).size.width * 0.025,
//         vertical: MediaQuery.of(context).size.height * 0.0025,
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(15),
//         child: ExpansionTile(
//           title: Text(
//             account,
//             style: TextStyle(
//               color: Theme.of(context).brightness == Brightness.light
//                   ? Theme.of(context).primaryColor
//                   : null,
//             ),
//           ),
//           onExpansionChanged: (expanded) {
//             if (expanded) {
//               BlocProvider.of<AccountStatsBloc>(context).add(
//                 AccountStatsUpdated(account),
//               );
//             }
//           },
//           children: [
//             Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 BlocBuilder<AccountStatsBloc, AccountStatsState>(
//                   buildWhen: (previousState, currentState) {
//                     return (currentState is AccountStatsLoadSuccess) &&
//                         currentState.account == account;
//                   },
//                   builder: (context, state) {
//                     if (state is AccountStatsLoadInProgress) {
//                       return Center(
//                         child: CircularProgressIndicator(
//                           valueColor: AlwaysStoppedAnimation<Color>(
//                             Theme.of(context).primaryColor,
//                           ),
//                         ),
//                       );
//                     } else if (state is AccountStatsLoadSuccess) {
//                       return InkWell(
//                         borderRadius: const BorderRadius.only(
//                           bottomLeft: Radius.circular(15),
//                           bottomRight: Radius.circular(15),
//                         ),
//                         onTap: () {
//                           Navigator.of(context).push(
//                             MaterialPageRoute(
//                               builder: (_) =>
//                                   AccountDetailsScreen(account: account),
//                             ),
//                           );
//                         },
//                         child: ListView(
//                           primary: false,
//                           shrinkWrap: true,
//                           children: [
//                             Hero(
//                               tag: account,
//                               child: BalanceCard(
//                                 isHomePage: false,
//                                 totalBalance: state.totalBalance,
//                                 totalIncome: state.lastThirtyDaysIncome,
//                                 totalOutcome: state.lastThirtyDaysOutcome,
//                               ),
//                             ),
//                             const SizedBox(height: 10),
//                             const Text(
//                               "Mais detalhes",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                             const SizedBox(height: 10),
//                           ],
//                         ),
//                       );
//                     } else {
//                       return const Text(
//                         "Erro aos calcular os dados. Por favor, reinicie o aplicativo",
//                         textAlign: TextAlign.center,
//                       );
//                     }
//                   },
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
