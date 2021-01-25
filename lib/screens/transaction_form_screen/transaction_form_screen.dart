// import 'package:brasil_fields/brasil_fields.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/date_symbol_data_local.dart';
// import 'package:intl/intl.dart';
// import 'package:personal_expenses/blocs/old_blocs/blocs.dart';
// import 'package:personal_expenses/models/transaction.dart';
// import 'package:personal_expenses/screens/common/update_home_screen.dart';

// class UserTransactionForm extends StatefulWidget {
//   final UserTransaction? transaction;
//   final bool isNew;

//   const UserTransactionForm({
//     Key? key,
//     this.transaction,
//     this.isNew = true,
//   }) : super(key: key);

//   @override
//   _UserTransactionFormState createState() => _UserTransactionFormState();
// }

// class _UserTransactionFormState extends State<UserTransactionForm> {
//   final _formKey = GlobalKey<FormState>();
//   late String? _title;
//   String? _account;
//   late DateTime _date;
//   late bool _isIncome;
//   late double? _price;
//   bool newAccount = false;
//   bool showAccountError = false;
//   bool isSaving = false;

//   bool get isNew => widget.isNew;

//   @override
//   void initState() {
//     super.initState();
//     setState(() {
//       _account = widget.transaction?.account;
//       _date = widget.transaction?.date ?? DateTime.now();
//       _isIncome = widget.transaction?.isIncome ?? false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     initializeDateFormatting();
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<AccountBloc>(
//           create: (context) => AccountBloc()..add(AccountLoadAll()),
//         ),
//         BlocProvider<TransactionBloc>(
//           create: (_) => TransactionBloc()..add(TransactionLoad()),
//         ),
//       ],
//       child: Container(
//         height: MediaQuery.of(context).size.height * 0.9,
//         color: Colors.transparent,
//         child: ClipRRect(
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(30),
//             topRight: Radius.circular(30),
//           ),
//           child: Scaffold(
//             primary: false,
//             appBar: AppBar(
//               primary: false,
//               leading: IconButton(
//                 icon: const Icon(
//                   Icons.close,
//                   size: 35,
//                 ),
//                 onPressed: isSaving ? null : Navigator.of(context).pop,
//               ),
//               actions: [
//                 BlocBuilder<TransactionBloc, TransactionState>(
//                     builder: (context, state) {
//                   if (state is TransactionLoadInProgress) {
//                     return const IconButton(
//                       icon: Icon(Icons.check, size: 35),
//                       onPressed: null,
//                     );
//                   } else if (state is TransactionLoadSuccess) {
//                     return Padding(
//                       padding: EdgeInsets.only(
//                         right: MediaQuery.of(context).size.width * 0.025,
//                       ),
//                       child: IconButton(
//                           icon: const Icon(Icons.check, size: 35),
//                           onPressed: () {
//                             setState(() {
//                               isSaving = true;
//                             });
//                             if (_formKey.currentState!.validate()) {
//                               _formKey.currentState!.save();
//                               if (_account == null) {
//                                 setState(() {
//                                   showAccountError = true;
//                                   isSaving = false;
//                                 });
//                                 return;
//                               } else {
//                                 if (isNew) {
//                                   BlocProvider.of<TransactionBloc>(context).add(
//                                     TransactionAdded(
//                                       UserTransaction(
//                                         title: _title!,
//                                         account: _account!,
//                                         date: _date,
//                                         isIncome: _isIncome,
//                                         savedAt: DateTime.now(),
//                                         price: _price!,
//                                       ),
//                                     ),
//                                   );
//                                 } else {
//                                   BlocProvider.of<TransactionBloc>(context).add(
//                                     TransactionUpdated(
//                                       UserTransaction(
//                                         id: widget.transaction!.id,
//                                         title: _title!,
//                                         account: _account!,
//                                         date: _date,
//                                         isIncome: _isIncome,
//                                         savedAt: DateTime.now(),
//                                         price: _price!,
//                                       ),
//                                     ),
//                                   );
//                                 }
//                                 UpdateHomeScreen().updateHome(context);
//                                 setState(() {
//                                   isSaving = false;
//                                 });
//                                 if (isNew) {
//                                   Navigator.of(context).pop();
//                                 } else {
//                                   Navigator.of(context).pop();
//                                   Navigator.of(context).pop();
//                                 }
//                               }
//                             } else {
//                               if (_account == null) {
//                                 setState(() {
//                                   showAccountError = true;
//                                 });
//                               }
//                               setState(() {
//                                 isSaving = false;
//                               });
//                               return;
//                             }
//                           }),
//                     );
//                   } else {
//                     return Container();
//                   }
//                 }),
//               ],
//             ),
//             body: Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: MediaQuery.of(context).size.width * 0.025,
//               ),
//               child: Form(
//                 key: _formKey,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         isNew ? "Nova transação" : "Editar transação",
//                         style: const TextStyle(
//                           fontSize: 30,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           labelText: "Título",
//                           hintText: "Dê um título para a transação...",
//                         ),
//                         textCapitalization: TextCapitalization.sentences,
//                         initialValue: isNew ? "" : widget.transaction!.title,
//                         validator: (newTitle) {
//                           if (newTitle == null ||
//                               newTitle.isEmpty ||
//                               newTitle.trim().isEmpty) {
//                             return "Por favor, insira um título para a transação.";
//                           } else {
//                             return null;
//                           }
//                         },
//                         onSaved: (newTitle) => _title = newTitle!,
//                       ),
//                       const SizedBox(height: 20),
//                       BlocBuilder<AccountBloc, AccountState>(
//                         builder: (context, state) {
//                           if (state is AccountLoadInProgress) {
//                             return LinearProgressIndicator(
//                               valueColor: AlwaysStoppedAnimation(
//                                 Theme.of(context).primaryColor,
//                               ),
//                             );
//                           } else if (state is AccountLoadAllSuccess) {
//                             final double _newAccountContainerHeight =
//                                 state.accountList.isEmpty || newAccount
//                                     ? 86.0
//                                     : 0.0;
//                             final double _existingAccountContainerHeight =
//                                 state.accountList.isEmpty || newAccount
//                                     ? 0.0
//                                     : showAccountError
//                                         ? 90.0
//                                         : 50.0;
//                             return Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 RadioListTile<bool>(
//                                   title: Text(
//                                     "Usar conta existente",
//                                     style: TextStyle(
//                                       color: state.accountList.isEmpty
//                                           ? Theme.of(context).disabledColor
//                                           : null,
//                                     ),
//                                   ),
//                                   value: false,
//                                   groupValue: state.accountList.isEmpty
//                                       ? true
//                                       : newAccount,
//                                   onChanged: (newOption) {
//                                     setState(() {
//                                       newAccount = newOption!;
//                                     });
//                                   },
//                                 ),
//                                 AnimatedContainer(
//                                   duration: const Duration(milliseconds: 500),
//                                   height: _existingAccountContainerHeight,
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         "Conta",
//                                         style: TextStyle(
//                                           color: state.accountList.isEmpty ||
//                                                   newAccount
//                                               ? Theme.of(context).disabledColor
//                                               : null,
//                                         ),
//                                       ),
//                                       Column(
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           Expanded(
//                                             child: DropdownButton<String>(
//                                               value:
//                                                   newAccount ? null : _account,
//                                               hint: const Text(
//                                                   "Selecione uma conta"),
//                                               underline: (state.accountList
//                                                           .isNotEmpty &&
//                                                       showAccountError &&
//                                                       !newAccount)
//                                                   ? Container(
//                                                       height: 1,
//                                                       color: Theme.of(context)
//                                                           .errorColor,
//                                                     )
//                                                   : null,
//                                               onChanged: newAccount
//                                                   ? null
//                                                   : (String? selectedAccount) {
//                                                       setState(() {
//                                                         _account =
//                                                             selectedAccount!;
//                                                         showAccountError =
//                                                             false;
//                                                       });
//                                                     },
//                                               items: state.accountList.map<
//                                                       DropdownMenuItem<String>>(
//                                                   (account) {
//                                                 return DropdownMenuItem<String>(
//                                                   value: account,
//                                                   child: Text(account),
//                                                 );
//                                               }).toList(),
//                                             ),
//                                           ),
//                                           if (state.accountList.isNotEmpty &&
//                                               showAccountError &&
//                                               !newAccount)
//                                             Expanded(
//                                               child: Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 15),
//                                                 child: ConstrainedBox(
//                                                   constraints: BoxConstraints(
//                                                       maxWidth:
//                                                           MediaQuery.of(context)
//                                                                   .size
//                                                                   .width *
//                                                               0.5),
//                                                   child: Text(
//                                                     "Por favor, selecione uma conta.",
//                                                     style: TextStyle(
//                                                       color: Theme.of(context)
//                                                           .errorColor,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                                 RadioListTile<bool>(
//                                   title: const Text("Adicionar nova conta"),
//                                   value: true,
//                                   groupValue: state.accountList.isEmpty
//                                       ? true
//                                       : newAccount,
//                                   onChanged: (newOption) {
//                                     setState(() {
//                                       newAccount = newOption!;
//                                     });
//                                   },
//                                 ),
//                                 AnimatedContainer(
//                                   duration: const Duration(milliseconds: 500),
//                                   height: _newAccountContainerHeight,
//                                   child: TextFormField(
//                                     enabled:
//                                         state.accountList.isEmpty || newAccount,
//                                     decoration: InputDecoration(
//                                       labelText: "Conta",
//                                       hintText: "Dê um nome para a nova conta.",
//                                       border: _newAccountContainerHeight > 30
//                                           ? null
//                                           : InputBorder.none,
//                                     ),
//                                     textCapitalization:
//                                         TextCapitalization.sentences,
//                                     validator: (newAccountName) {
//                                       if (state.accountList.isEmpty ||
//                                           newAccount) {
//                                         if (newAccountName == null ||
//                                             newAccountName.isEmpty ||
//                                             newAccountName.trim().isEmpty) {
//                                           return "Por favor, insira um nome para a conta.";
//                                         } else if (state.accountList
//                                             .contains(newAccountName)) {
//                                           return "Já existe uma conta com este nome.";
//                                         } else {
//                                           return null;
//                                         }
//                                       } else {
//                                         return null;
//                                       }
//                                     },
//                                     onSaved:
//                                         state.accountList.isEmpty || newAccount
//                                             ? (newAccountName) {
//                                                 _account = newAccountName!;
//                                               }
//                                             : null,
//                                   ),
//                                 ),
//                               ],
//                             );
//                           } else {
//                             return const Text(
//                               "Falha ao carregr as contas salvas.",
//                             );
//                           }
//                         },
//                       ),
//                       const SizedBox(height: 20),
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width,
//                         child: Wrap(
//                           crossAxisAlignment: WrapCrossAlignment.center,
//                           alignment: WrapAlignment.spaceBetween,
//                           children: [
//                             const Expanded(
//                               child: Text(
//                                 "Data da transação: ",
//                               ),
//                             ),
//                             Text(
//                               DateFormat(DateFormat.YEAR_MONTH_DAY, "pt-Br")
//                                   .format(_date),
//                             ),
//                             IconButton(
//                               icon: Icon(
//                                 Icons.calendar_today,
//                                 color: Theme.of(context).accentColor,
//                                 size: 30,
//                               ),
//                               onPressed: () => _datePicker(
//                                 context: context,
//                                 initialDate: _date,
//                                 changeTransactionDate: (newDate) {
//                                   setState(() {
//                                     _date = newDate;
//                                   });
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       const Text("Receita ou despesa?"),
//                       RadioListTile<bool>(
//                         title: const Text("Receita"),
//                         value: true,
//                         groupValue: _isIncome,
//                         onChanged: (newOption) {
//                           setState(() {
//                             _isIncome = newOption!;
//                           });
//                         },
//                       ),
//                       RadioListTile<bool>(
//                         title: const Text("Despesa"),
//                         value: false,
//                         groupValue: _isIncome,
//                         onChanged: (newOption) {
//                           setState(() {
//                             _isIncome = newOption!;
//                           });
//                         },
//                       ),
//                       const SizedBox(height: 20),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Expanded(child: Text("Valor:")),
//                           Expanded(
//                             child: TextFormField(
//                               decoration: const InputDecoration(
//                                 hintText: "Valor da transação",
//                                 prefixText: "R\$ ",
//                                 prefixStyle: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                                 errorMaxLines: 2,
//                               ),
//                               initialValue: isNew
//                                   ? ""
//                                   : widget.transaction!.price
//                                       .toStringAsFixed(2)
//                                       .replaceAll(".", ","),
//                               keyboardType:
//                                   const TextInputType.numberWithOptions(
//                                 decimal: true,
//                               ),
//                               inputFormatters: [
//                                 FilteringTextInputFormatter.digitsOnly,
//                                 RealInputFormatter(centavos: true),
//                               ],
//                               validator: (newPrice) {
//                                 if (newPrice == null ||
//                                     newPrice.isEmpty ||
//                                     newPrice.trim().isEmpty) {
//                                   return "Por favor, insira um valor para a transação.";
//                                 } else {
//                                   return null;
//                                 }
//                               },
//                               onSaved: (newPrice) {
//                                 final String priceReplaced =
//                                     newPrice!.replaceAll(",", ".");
//                                 final double price =
//                                     double.parse(priceReplaced);
//                                 _price = price;
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _datePicker({
//     required BuildContext context,
//     required DateTime initialDate,
//     required void Function(DateTime) changeTransactionDate,
//   }) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: initialDate,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//       confirmText: "SALVAR",
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context),
//           child: child!,
//         );
//       },
//     );

//     if (pickedDate != null) {
//       changeTransactionDate(pickedDate);
//     }
//   }
// }
