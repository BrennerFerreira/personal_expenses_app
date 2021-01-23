import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expenses/blocs/transaction_form/transaction_form_bloc.dart';
import 'package:personal_expenses/pages/common/common_circular_indicator.dart';
import 'package:personal_expenses/pages/common/common_error_text.dart';
import 'package:personal_expenses/pages/user_transaction_form_page/widgets/account_field.dart';
import 'package:personal_expenses/pages/user_transaction_form_page/widgets/title_field.dart';

class UserTransactionFormPage extends StatefulWidget {
  @override
  _UserTransactionFormPageState createState() =>
      _UserTransactionFormPageState();
}

class _UserTransactionFormPageState extends State<UserTransactionFormPage> {
  @override
  Widget build(BuildContext context) {
    final formBloc = BlocProvider.of<TransactionFormBloc>(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
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
                if (state is TransactionFormLoadInProgress) {
                  return CommonCircularIndicator();
                } else if (state is TransactionFormState) {
                  return ListView(
                    children: [
                      const Text(
                        "Nova transação",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TitleField(formBloc: formBloc),
                      const SizedBox(height: 20),
                      AccountField(formBloc: formBloc),
                    ],
                  );
                } else {
                  return CommonErrorText();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
