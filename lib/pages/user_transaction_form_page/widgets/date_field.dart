import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/blocs/transaction_form/transaction_form_bloc.dart';

class DateField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return BlocBuilder<TransactionFormBloc, TransactionFormState>(
      builder: (context, state) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.spaceBetween,
            children: [
              Text(
                (state.isInstallments && state.isNew) ||
                        state.editAllInstallments
                    ? "Primeira parcela: "
                    : "Data da transação: ",
              ),
              Text(
                DateFormat(DateFormat.YEAR_MONTH_DAY, "pt-Br")
                    .format(state.date!),
              ),
              IconButton(
                icon: Icon(
                  Icons.calendar_today,
                  color: Theme.of(context).accentColor,
                  size: 30,
                ),
                onPressed: () => _datePicker(
                  context: context,
                  initialDate: state.date!,
                  changeTransactionDate: (newDate) {
                    BlocProvider.of<TransactionFormBloc>(context).add(
                      DateChanged(newDate: newDate),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _datePicker({
    required BuildContext context,
    required DateTime initialDate,
    required void Function(DateTime) changeTransactionDate,
  }) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      confirmText: "SALVAR",
      builder: (context, child) {
        return Theme(
          data: Theme.of(context),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      changeTransactionDate(pickedDate);
    }
  }
}
