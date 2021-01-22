import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expenses/blocs/old_blocs/blocs.dart';
import 'package:personal_expenses/models/visibility_filter.dart';

class CustomDropDownMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.05,
        bottom: MediaQuery.of(context).size.height * 0.01,
      ),
      child: BlocBuilder<FilteredTransactionsBloc, FilteredTransactionsState>(
        builder: (context, state) {
          if (state is FilteredTransactionsLoadInProgress) {
            return DropdownButton(items: const []);
          } else if (state is FilteredTransactionsLoadSuccess) {
            return DropdownButton(
              dropdownColor: Theme.of(context).primaryColor,
              underline: Container(
                height: 1,
                color: Theme.of(context).accentColor,
              ),
              iconEnabledColor: Theme.of(context).accentColor,
              items: const [
                DropdownMenuItem<VisibilityFilter>(
                  value: VisibilityFilter.all,
                  child: Text("Todas"),
                ),
                DropdownMenuItem<VisibilityFilter>(
                  value: VisibilityFilter.lastThirtyDays,
                  child: Text("Últimos 30 dias"),
                ),
                DropdownMenuItem<VisibilityFilter>(
                  value: VisibilityFilter.lastSevenDays,
                  child: Text("Últimos 7 dias"),
                ),
                DropdownMenuItem<VisibilityFilter>(
                  value: VisibilityFilter.future,
                  child: Text("Transações Futuras"),
                ),
              ],
              value: state.activeFilter,
              onChanged: (VisibilityFilter? filterOption) {
                BlocProvider.of<FilteredTransactionsBloc>(context)
                    .add(FilterUpdated(filterOption!));
              },
            );
          } else {
            return DropdownButton(items: const []);
          }
        },
      ),
    );
  }
}
