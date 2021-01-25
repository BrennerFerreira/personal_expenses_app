// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:personal_expenses/blocs/old_blocs/blocs.dart';
// import 'package:personal_expenses/screens/accounts_screen/widgets/account_tile.dart';

// class AccountList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<AccountBloc>(
//       create: (context) => AccountBloc()..add(AccountLoadAll()),
//       child: BlocBuilder<AccountBloc, AccountState>(
//         builder: (context, state) {
//           if (state is AccountLoadInProgress) {
//             return Center(
//               child: CircularProgressIndicator(
//                 valueColor: AlwaysStoppedAnimation<Color>(
//                   Theme.of(context).primaryColor,
//                 ),
//               ),
//             );
//           } else if (state is AccountLoadAllSuccess) {
//             final List<String> accountList = state.accountList;
//             return accountList.isEmpty
//                 ? const Center(
//                     child: Text("Nenhuma conta cadastrada."),
//                   )
//                 : ListView.builder(
//                     itemCount: accountList.length,
//                     itemBuilder: (_, index) {
//                       return AccountTile(
//                         account: accountList[index],
//                       );
//                     },
//                   );
//           } else {
//             return const Text(
//               "Erro aos calcular os dados. Por favor, reinicie o aplicativo",
//               textAlign: TextAlign.center,
//             );
//           }
//         },
//       ),
//     );
//   }
// }
