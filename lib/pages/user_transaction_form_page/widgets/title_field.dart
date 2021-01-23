import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:personal_expenses/blocs/transaction_form/transaction_form_bloc.dart';

class TitleField extends StatelessWidget {
  final TransactionFormBloc formBloc;
  const TitleField({
    Key? key,
    required this.formBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionFormBloc, TransactionFormState>(
      value: formBloc,
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: "Título",
            hintText: "Dê um título para a sua transação...",
            errorText: state is TransactionFormError ? state.titleError : null,
          ),
          onChanged: (newTitle) => formBloc.add(
            TitleChanged(newTitle: newTitle),
          ),
        );
      },
    );
  }
}
