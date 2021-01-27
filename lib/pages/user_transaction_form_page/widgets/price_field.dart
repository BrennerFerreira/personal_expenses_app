import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/blocs/transaction_form/transaction_form_bloc.dart';

class PriceField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionFormBloc, TransactionFormState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                state.isInstallments ? "Valor total: " : "Valor: ",
              ),
            ),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  prefixText: "R\$ ",
                  prefixStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  errorMaxLines: 2,
                  errorText: state.priceError,
                ),
                initialValue: state.price == 0.0
                    ? null
                    : NumberFormat.decimalPattern('pt-BR').format(state.price),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onChanged: (newPrice) =>
                    BlocProvider.of<TransactionFormBloc>(context).add(
                  PriceChanged(
                    newPrice: newPrice,
                  ),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  RealInputFormatter(centavos: true),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
