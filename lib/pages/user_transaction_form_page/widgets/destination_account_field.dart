import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/transaction_form/transaction_form_bloc.dart';

class DestinationAccountField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionFormBloc, TransactionFormState>(
      builder: (context, state) {
        final double _destinationNewAccountContainerHeight =
            (state.destinationAccountList.isEmpty ||
                        state.destinationNewAccount) &&
                    state.account.isNotEmpty
                ? 85.0
                : 0.0;
        final double _existingDestinationAccountContainerHeight =
            state.account == "" ||
                    state.destinationAccountList.isEmpty ||
                    state.destinationNewAccount
                ? 0.0
                : 45.0;
        final double _existingDestinationAccountErrorContainerHeight =
            state.destinationAccountList.isNotEmpty &&
                    !state.destinationNewAccount &&
                    state.destinationAccountError != null
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
                  color: state.destinationAccountList.isEmpty
                      ? Theme.of(context).disabledColor
                      : null,
                ),
              ),
              value: false,
              groupValue: state.account == ""
                  ? null
                  : state.destinationAccountList.isEmpty
                      ? state.destinationAccountList.isEmpty
                      : state.destinationNewAccount,
              onChanged:
                  state.destinationAccountList.isEmpty || state.account == ""
                      ? null
                      : (newOption) {
                          BlocProvider.of<TransactionFormBloc>(context).add(
                            DestinationNewAccountChanged(newOption: newOption!),
                          );
                        },
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              height: _existingDestinationAccountContainerHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Conta:",
                    style: TextStyle(
                      color: state.destinationAccountList.isEmpty ||
                              state.destinationNewAccount
                          ? Theme.of(context).disabledColor
                          : null,
                    ),
                  ),
                  DropdownButton<String>(
                    value: state.destinationNewAccount ||
                            state.destinationAccount == "" ||
                            state.account == "" ||
                            state.destinationAccount == state.account
                        ? null
                        : state.destinationAccount,
                    hint: const Text("Selecione uma conta"),
                    dropdownColor: Theme.of(context).primaryColor,
                    underline: (!state.destinationNewAccount &&
                            state.destinationAccountError != null)
                        ? Container(
                            height: 1,
                            color: Theme.of(context).errorColor,
                          )
                        : null,
                    onChanged: state.destinationNewAccount
                        ? null
                        : (String? selectedAccount) {
                            BlocProvider.of<TransactionFormBloc>(
                              context,
                              listen: false,
                            ).add(
                              DestinationAccountChanged(
                                newDestinationAccount: selectedAccount!,
                              ),
                            );
                          },
                    items: state.destinationAccountList
                        .map<DropdownMenuItem<String>>((account) {
                      return DropdownMenuItem<String>(
                        value: account,
                        child: Text(account),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: _existingDestinationAccountErrorContainerHeight,
              child: Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.485,
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.485,
                  child: state.destinationAccountError != null
                      ? Text(
                          state.destinationAccountError!,
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
              groupValue: state.account.isEmpty
                  ? null
                  : state.destinationAccountList.isEmpty
                      ? state.destinationAccountList.isEmpty
                      : state.destinationNewAccount,
              onChanged: state.account.isEmpty
                  ? null
                  : (newOption) {
                      BlocProvider.of<TransactionFormBloc>(context).add(
                        DestinationNewAccountChanged(newOption: newOption!),
                      );
                    },
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              height: _destinationNewAccountContainerHeight,
              child: (state.destinationAccountList.isEmpty ||
                          state.destinationNewAccount) &&
                      state.account.isNotEmpty
                  ? TextFormField(
                      decoration: InputDecoration(
                        labelText: "Conta",
                        hintText: "Dê um nome para a nova conta.",
                        errorText: state.destinationAccountError,
                      ),
                      initialValue: state.destinationNewAccount
                          ? state.destinationAccount
                          : null,
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: (newAccountName) =>
                          BlocProvider.of<TransactionFormBloc>(
                        context,
                        listen: false,
                      ).add(
                        DestinationAccountChanged(
                          newDestinationAccount: newAccountName,
                        ),
                      ),
                    )
                  : Container(),
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }
}
