import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DateRangeSelector extends StatefulWidget {
  final Function(DateTimeRange newRange) changeDateRange;

  const DateRangeSelector({
    Key? key,
    required this.changeDateRange,
  }) : super(key: key);
  @override
  _DateRangeSelectorState createState() => _DateRangeSelectorState();
}

class _DateRangeSelectorState extends State<DateRangeSelector> {
  DateTime startDate = DateTime(DateTime.now().year, DateTime.now().month);
  DateTime endDate = DateTime(DateTime.now().year, DateTime.now().month + 1, 0);
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Data de início:"),
            Text(
              DateFormat(DateFormat.YEAR_MONTH_DAY, "pt-BR").format(startDate),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Data final:"),
            Text(
              DateFormat(DateFormat.YEAR_MONTH_DAY, "pt-BR").format(endDate),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          alignment: Alignment.center,
          child: RaisedButton(
            onPressed: () async {
              final DateTimeRange? dateRange = await showDateRangePicker(
                context: context,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                confirmText: "SALVAR",
              );
              if (dateRange != null) {
                setState(() {
                  startDate = dateRange.start;
                  endDate = dateRange.end;
                });
                widget.changeDateRange(dateRange);
              }
            },
            textColor: Theme.of(context).primaryColor,
            child: const Text("Selecione uma data"),
          ),
        ),
      ],
    );
  }
}
