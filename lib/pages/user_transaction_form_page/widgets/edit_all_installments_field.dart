import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/transaction_form/transaction_form_bloc.dart';

class EditAllInstallmentsField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionFormBloc, TransactionFormState>(
      builder: (context, state) {
        if (!state.isNew &&
            state.isInstallments &&
            state.installmentsId != null) {
          return CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
            title: const Text("Editar todas as parcelas desta transação"),
            value: state.editAllInstallments,
            onChanged: (newEditAllInstallments) {
              BlocProvider.of<TransactionFormBloc>(context).add(
                EditAllInstallmentsChanged(
                  newEditAllInstallments: newEditAllInstallments!,
                ),
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
