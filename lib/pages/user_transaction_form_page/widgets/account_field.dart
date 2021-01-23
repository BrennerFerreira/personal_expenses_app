import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expenses/blocs/transaction_form/transaction_form_bloc.dart';

class AccountField extends StatelessWidget {
  final TransactionFormBloc formBloc;

  const AccountField({
    Key? key,
    required this.formBloc,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionFormBloc, TransactionFormState>(
      value: formBloc,
      builder: (context, state) {
        final double _newAccountContainerHeight =
            state.accountList.isEmpty || state.newAccount ? 86.0 : 0.0;
        final double _existingAccountContainerHeight =
            state.accountList.isEmpty || state.newAccount
                ? 0.0
                : state is TransactionFormError
                    ? state.accountError != null
                        ? 90.0
                        : 50.0
                    : 50.0;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<bool>(
              title: Text(
                "Usar conta existente",
                style: TextStyle(
                  color: state.accountList.isEmpty
                      ? Theme.of(context).disabledColor
                      : null,
                ),
              ),
              value: false,
              groupValue: state.accountList.isEmpty ? true : state.newAccount,
              onChanged: (newOption) {
                formBloc.add(
                  InvertNewAccountValue(newOption: newOption!),
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
                          value: state.newAccount ? null : state.account,
                          hint: const Text("Selecione uma conta"),
                          underline: (state.accountList.isNotEmpty &&
                                  (state as TransactionFormError)
                                          .accountError !=
                                      null &&
                                  !state.newAccount)
                              ? Container(
                                  height: 1,
                                  color: Theme.of(context).errorColor,
                                )
                              : null,
                          onChanged: state.newAccount
                              ? null
                              : (String? selectedAccount) {
                                  formBloc.add(
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
                      if (state.accountList.isNotEmpty &&
                          !state.newAccount &&
                          state is TransactionFormError &&
                          state.accountError != null)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.5,
                              ),
                              child: Text(
                                "Por favor, selecione uma conta.",
                                style: TextStyle(
                                  color: Theme.of(context).errorColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  )
                ],
              ),
            ),
            RadioListTile<bool>(
              title: const Text("Adicionar nova conta"),
              value: true,
              groupValue: state.accountList.isEmpty ? true : state.newAccount,
              onChanged: (newOption) {
                formBloc.add(
                  InvertNewAccountValue(newOption: newOption!),
                );
              },
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              height: _newAccountContainerHeight,
              child: TextFormField(
                enabled: state.accountList.isEmpty || state.newAccount,
                decoration: InputDecoration(
                  labelText: "Conta",
                  hintText: "Dê um nome para a nova conta.",
                  border:
                      _newAccountContainerHeight > 30 ? null : InputBorder.none,
                  errorText: state.accountList.contains(state.account)
                      ? "Já existe uma conta com este nome."
                      : state is TransactionFormError
                          ? state.accountError
                          : null,
                ),
                textCapitalization: TextCapitalization.sentences,
                onChanged: (newAccountName) => formBloc.add(
                  AccountChanged(
                    newAccount: newAccountName,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
