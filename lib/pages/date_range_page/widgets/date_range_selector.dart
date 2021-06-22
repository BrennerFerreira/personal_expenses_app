import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../../blocs/date_range_page/date_range_page_bloc.dart';

class DateRangeSelector extends StatelessWidget {
  final DateRangePageBloc dateRangePageBloc;

  const DateRangeSelector({
    Key? key,
    required this.dateRangePageBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return BlocBuilder<DateRangePageBloc, DateRangePageState>(
      value: dateRangePageBloc,
      builder: (context, state) {
        if (state is DateRangePageLoadSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Data de início:"),
                  Text(
                    DateFormat(DateFormat.YEAR_MONTH_DAY, "pt-BR")
                        .format(state.startDate),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Data final:"),
                  Text(
                    DateFormat(DateFormat.YEAR_MONTH_DAY, "pt-BR")
                        .format(state.endDate),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  onPressed: () async {
                    final DateTimeRange? dateRange = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      confirmText: "SALVAR",
                    );
                    if (dateRange != null) {
                      dateRangePageBloc.add(
                        UpdateDateRangePage(
                          startDate: dateRange.start,
                          endDate: dateRange.end,
                        ),
                      );
                    }
                  },
                  child: const Text("Selecione um período"),
                ),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
