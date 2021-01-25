import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expenses/blocs/transaction_form/transaction_form_bloc.dart';

class InstallmentsField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionFormBloc, TransactionFormState>(
      builder: (context, state) {
        return Row(
          children: [
            Checkbox(
              value: state.isInstallments,
              onChanged: (newIsInstallments) {
                BlocProvider.of<TransactionFormBloc>(context).add(
                  IsInstallmentsChanged(
                    newIsInstallments: newIsInstallments!,
                  ),
                );
              },
            ),
            const SizedBox(width: 5),
            const Expanded(
              child: Text("Parcelas"),
            ),
            Expanded(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: state.isInstallments ? 1.0 : 0.0,
                child: TextFormField(
                  enabled: state.isInstallments,
                  decoration: InputDecoration(
                    labelText: "Número de parcelas",
                    isDense: true,
                    errorText: state.numberOfInstallmentsError,
                    errorMaxLines: 3,
                  ),
                  initialValue: "1",
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (newNumberOfInstallments) {
                    BlocProvider.of<TransactionFormBloc>(context).add(
                      NumberOfInstallmentsChanged(
                        newNumberOfInstallments: newNumberOfInstallments,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
