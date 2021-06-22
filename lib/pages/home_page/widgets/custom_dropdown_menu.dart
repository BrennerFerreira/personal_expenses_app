import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/home_page/home_page_blocs.dart';
import '../../../models/visibility_filter.dart';

class CustomDropDownMenu extends StatelessWidget {
  final FilteredTransactionsListBloc bloc;

  const CustomDropDownMenu({
    Key? key,
    required this.bloc,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.05,
        bottom: MediaQuery.of(context).size.height * 0.01,
      ),
      child: BlocBuilder<FilteredTransactionsListBloc,
          FilteredTransactionsListState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is FilteredTransactionsListLoadInProgress) {
            return DropdownButton(items: const []);
          } else if (state is FilteredTransactionsListLoadSuccess) {
            return DropdownButton<VisibilityFilter>(
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
                bloc.add(FilterUpdated(filterOption!));
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
