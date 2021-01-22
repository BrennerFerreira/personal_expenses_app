import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expenses/blocs/transaction_form/transaction_form_bloc.dart';

class UserTransactionFormPage extends StatefulWidget {
  @override
  _UserTransactionFormPageState createState() =>
      _UserTransactionFormPageState();
}

class _UserTransactionFormPageState extends State<UserTransactionFormPage> {
  @override
  Widget build(BuildContext context) {
    final formBloc = TransactionFormBloc();
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
        child: BlocProvider<TransactionFormBloc>(
          create: (context) => formBloc,
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.015,
                  ),
                  child: const Icon(
                    Icons.close,
                    size: 35,
                  ),
                ),
                onPressed: Navigator.of(context).pop,
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.025,
                  ),
                  child: BlocBuilder<TransactionFormBloc, TransactionFormState>(
                    value: formBloc,
                    builder: (context, state) {
                      return IconButton(
                        icon: const Icon(
                          Icons.check,
                          size: 35,
                        ),
                        onPressed: () {
                          formBloc.add(const FormSubmitted());
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.025,
                vertical: MediaQuery.of(context).size.height * 0.01,
              ),
              child: BlocBuilder<TransactionFormBloc, TransactionFormState>(
                value: formBloc,
                builder: (context, state) {
                  return ListView(
                    children: [
                      const Text(
                        "Nova transação",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "Título",
                            hintText: "Dê um título para a sua transação...",
                            errorText: state is TransactionFormError
                                ? state.titleError
                                : null),
                        onChanged: (newTitle) => formBloc.add(
                          TitleChanged(newTitle: newTitle),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
