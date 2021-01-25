// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/date_symbol_data_local.dart';
// import 'package:intl/intl.dart';
// import 'package:personal_expenses/blocs/old_blocs/blocs.dart';

// import 'package:personal_expenses/models/transaction.dart';
// import 'package:personal_expenses/screens/common/update_home_screen.dart';
// import 'package:personal_expenses/screens/transaction_form_screen/transaction_form_screen.dart';

// class UserTransactionDetail extends StatelessWidget {
//   final UserTransaction transaction;
//   final Future<bool> Function() onWillPop;

//   const UserTransactionDetail({
//     Key? key,
//     required this.transaction,
//     required this.onWillPop,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     initializeDateFormatting();
//     return WillPopScope(
//       onWillPop: onWillPop,
//       child: AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         backgroundColor: Theme.of(context).primaryColor,
//         title: Text(transaction.title),
//         content: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               UserTransactionDetailInfo(
//                 boldText: "Conta:",
//                 normalText: transaction.account,
//               ),
//               UserTransactionDetailInfo(
//                 boldText: "Tipo da transação:",
//                 normalText: transaction.isIncome ? "Receita" : "Despesa",
//               ),
//               UserTransactionDetailInfo(
//                 boldText: "Data da transação:",
//                 normalText: DateFormat(
//                   DateFormat.YEAR_MONTH_DAY,
//                   "pt-BR",
//                 ).format(transaction.date),
//               ),
//               UserTransactionDetailInfo(
//                 boldText: "Criada em:",
//                 normalText: DateFormat(
//                   DateFormat.YEAR_MONTH_DAY,
//                   "pt-BR",
//                 ).format(transaction.savedAt),
//               ),
//               UserTransactionDetailInfo(
//                 boldText: "Valor:",
//                 normalText:
//                     "R\$ ${transaction.price.toStringAsFixed(2).replaceAll(".", ",")}",
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           FlatButton(
//             onPressed: Navigator.of(context).pop,
//             child: Text(
//               "Voltar",
//               style: TextStyle(
//                 color: Theme.of(context).accentColor,
//               ),
//             ),
//           ),
//           FlatButton(
//             onPressed: () {
//               showModalBottomSheet(
//                 context: context,
//                 isScrollControlled: true,
//                 builder: (context) => UserTransactionForm(
//                   transaction: transaction,
//                   isNew: false,
//                 ),
//               );
//             },
//             child: Text(
//               "Editar",
//               style: TextStyle(
//                 color: Theme.of(context).accentColor,
//               ),
//             ),
//           ),
//           FlatButton(
//             onPressed: () {
//               showDialog(
//                 context: context,
//                 builder: (context) {
//                   return AlertDialog(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     backgroundColor: Theme.of(context).primaryColor,
//                     title: Text(
//                       "Excluir transação",
//                       style: TextStyle(
//                         color: Theme.of(context).errorColor,
//                       ),
//                     ),
//                     content: const Text(
//                         "Tem certeza que deseja excluir esta transação? Esta ação não pode ser desfeita."),
//                     actions: [
//                       FlatButton(
//                         onPressed: Navigator.of(context).pop,
//                         child: Text(
//                           "Cancelar",
//                           style: TextStyle(
//                             color: Theme.of(context).accentColor,
//                           ),
//                         ),
//                       ),
//                       BlocProvider(
//                         create: (context) => TransactionBloc(),
//                         child: FlatButton(
//                           onPressed: () {
//                             TransactionBloc()
//                                 .add(TransactionDeleted(transaction));
//                             UpdateHomeScreen().updateHome(context);
//                             Navigator.of(context).pop();
//                             Navigator.of(context).pop();
//                           },
//                           child: Text(
//                             "Excluir",
//                             style: TextStyle(
//                               color: Theme.of(context).errorColor,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               );
//             },
//             child: Text(
//               "Excluir",
//               style: TextStyle(
//                 color: Theme.of(context).errorColor,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class UserTransactionDetailInfo extends StatelessWidget {
//   final String boldText;
//   final String normalText;
//   const UserTransactionDetailInfo({
//     Key? key,
//     required this.boldText,
//     required this.normalText,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text(
//           boldText,
//           style: const TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         Text(normalText),
//         const SizedBox(height: 10),
//       ],
//     );
//   }
// }
