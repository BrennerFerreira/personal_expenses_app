import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:personal_expenses/blocs/transaction_form/transaction_form_bloc.dart';

class TitleField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionFormBloc, TransactionFormState>(
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: "Título",
            hintText: "Dê um título para a sua transação...",
            errorText: state.titleError,
          ),
          textCapitalization: TextCapitalization.sentences,
          initialValue: state.title,
          onChanged: (newTitle) => BlocProvider.of<TransactionFormBloc>(
            context,
            listen: false,
          ).add(
            TitleChanged(newTitle: newTitle),
          ),
        );
      },
    );
  }
}
