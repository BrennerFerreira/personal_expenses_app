import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/transaction_form/transaction_form_bloc.dart';

class AccountField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionFormBloc, TransactionFormState>(
      builder: (context, state) {
        final double _newAccountContainerHeight =
            state.accountList.isEmpty || state.newAccount ? 85.0 : 0.0;
        final double _existingAccountContainerHeight =
            state.accountList.isEmpty || state.newAccount ? 0.0 : 45.0;
        final double _existingAccountErrorContainerHeight =
            state.accountList.isNotEmpty &&
                    !state.newAccount &&
                    state.accountError != null
                ? 40.0
                : 0.0;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<bool>(
              contentPadding: EdgeInsets.zero,
              title: Text(
                "Usar conta existente",
                style: TextStyle(
                  color: state.accountList.isEmpty
                      ? Theme.of(context).disabledColor
                      : null,
                ),
              ),
              value: false,
              groupValue: state.accountList.isEmpty
                  ? state.accountList.isEmpty
                  : state.newAccount,
              onChanged: state.accountList.isEmpty
                  ? null
                  : (newOption) {
                      BlocProvider.of<TransactionFormBloc>(context).add(
                        NewAccountChanged(newOption: newOption!),
                      );
                    },
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              height: _existingAccountContainerHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Conta",
                    style: TextStyle(
                      color: state.accountList.isEmpty || state.newAccount
                          ? Theme.of(context).disabledColor
                          : null,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: DropdownButton<String>(
                          value: state.newAccount || state.account == ""
                              ? null
                              : state.account,
                          hint: const Text("Selecione uma conta"),
                          dropdownColor: Theme.of(context).primaryColor,
                          underline:
                              (!state.newAccount && state.accountError != null)
                                  ? Container(
                                      height: 1,
                                      color: Theme.of(context).errorColor,
                                    )
                                  : null,
                          onChanged: state.newAccount
                              ? null
                              : (String? selectedAccount) {
                                  BlocProvider.of<TransactionFormBloc>(
                                    context,
                                    listen: false,
                                  ).add(
                                    AccountChanged(
                                      newAccount: selectedAccount!,
                                    ),
                                  );
                                },
                          items: state.accountList
                              .map<DropdownMenuItem<String>>((account) {
                            return DropdownMenuItem<String>(
                              value: account,
                              child: Text(account),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: _existingAccountErrorContainerHeight,
              child: Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.485,
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.485,
                  child: state.accountError != null
                      ? Text(
                          state.accountError!,
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).errorColor,
                          ),
                        )
                      : Container(),
                ),
              ),
            ),
            RadioListTile<bool>(
              title: const Text("Adicionar nova conta"),
              contentPadding: EdgeInsets.zero,
              value: true,
              groupValue: state.accountList.isEmpty
                  ? state.accountList.isEmpty
                  : state.newAccount,
              onChanged: (newOption) {
                BlocProvider.of<TransactionFormBloc>(context).add(
                  NewAccountChanged(newOption: newOption!),
                );
              },
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              height: _newAccountContainerHeight,
              child: state.accountList.isEmpty || state.newAccount
                  ? TextFormField(
                      decoration: InputDecoration(
                        labelText: "Conta",
                        hintText: "Dê um nome para a nova conta.",
                        errorText: state.accountError,
                      ),
                      initialValue: state.newAccount ? state.account : null,
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: (newAccountName) =>
                          BlocProvider.of<TransactionFormBloc>(
                        context,
                        listen: false,
                      ).add(
                        AccountChanged(
                          newAccount: newAccountName,
                        ),
                      ),
                    )
                  : Container(),
            ),
          ],
        );
      },
    );
  }
}
