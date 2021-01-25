import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expenses/blocs/transaction_form/transaction_form_bloc.dart';

class PriceField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionFormBloc, TransactionFormState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(child: Text("Valor:")),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Valor da transação",
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
                    : state.price.toStringAsFixed(2).replaceAll(".", ","),
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
