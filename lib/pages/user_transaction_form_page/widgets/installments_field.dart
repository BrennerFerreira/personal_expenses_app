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
            Expanded(
              child: CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(
                  "Parcelas",
                  style: TextStyle(
                    color: state.isNew ? null : Theme.of(context).disabledColor,
                  ),
                ),
                contentPadding: EdgeInsets.zero,
                value: state.isInstallments,
                onChanged: state.isNew
                    ? (newIsInstallments) {
                        BlocProvider.of<TransactionFormBloc>(context).add(
                          IsInstallmentsChanged(
                            newIsInstallments: newIsInstallments!,
                          ),
                        );
                      }
                    : null,
              ),
            ),
            Expanded(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: state.isInstallments ? 1.0 : 0.0,
                child: state.isInstallments
                    ? TextFormField(
                        enabled: state.isNew || state.isInstallments,
                        style: TextStyle(
                          color: state.isNew
                              ? null
                              : Theme.of(context).disabledColor,
                        ),
                        decoration: InputDecoration(
                          labelText: "Número de parcelas",
                          isDense: true,
                          errorText: state.numberOfInstallmentsError,
                          errorMaxLines: 3,
                        ),
                        initialValue: state.numberOfInstallments.toString(),
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
                      )
                    : Container(),
              ),
            ),
          ],
        );
      },
    );
  }
}
