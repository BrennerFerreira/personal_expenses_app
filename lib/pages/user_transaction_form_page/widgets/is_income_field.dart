import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expenses/blocs/transaction_form/transaction_form_bloc.dart';

class IsIncomeField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionFormBloc, TransactionFormState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Receita ou despesa?"),
            RadioListTile<bool>(
              title: const Text("Receita"),
              value: true,
              groupValue: state.isIncome,
              onChanged: (newOption) {
                BlocProvider.of<TransactionFormBloc>(context).add(
                  IsIncomeChanged(
                    newIsIncome: newOption!,
                  ),
                );
              },
            ),
            RadioListTile<bool>(
              title: const Text("Despesa"),
              value: false,
              groupValue: state.isIncome,
              onChanged: (newOption) {
                BlocProvider.of<TransactionFormBloc>(context).add(
                  IsIncomeChanged(
                    newIsIncome: newOption!,
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
