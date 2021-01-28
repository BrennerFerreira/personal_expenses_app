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
                (state.isInstallments && state.isNew) ||
                        state.editAllInstallments
                    ? "Valor total: "
                    : "Valor: ",
              ),
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: state.editAllInstallments ? 0 : 1,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: state.editAllInstallments
                    ? 0
                    : MediaQuery.of(context).size.width * 0.485,
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixText: state.editAllInstallments ? "" : "R\$ ",
                    prefixStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    errorMaxLines: 2,
                    errorText: state.priceError,
                  ),
                  initialValue: state.price == 0.0
                      ? null
                      : NumberFormat.decimalPattern('pt-BR')
                          .format(state.price),
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
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: state.editAllInstallments ? 1 : 0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: state.editAllInstallments
                    ? MediaQuery.of(context).size.width * 0.485
                    : 0,
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixText: state.editAllInstallments ? "R\$ " : "",
                    prefixStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    errorMaxLines: 2,
                    errorText: state.priceError,
                  ),
                  initialValue: state.price == 0.0
                      ? null
                      : NumberFormat.decimalPattern('pt-BR')
                          .format(state.price * state.numberOfInstallments),
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
            ),
          ],
        );
      },
    );
  }
}
