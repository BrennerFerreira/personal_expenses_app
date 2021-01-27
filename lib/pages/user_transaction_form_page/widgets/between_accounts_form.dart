import 'package:flutter/material.dart';
import 'package:personal_expenses/pages/user_transaction_form_page/widgets/account_field.dart';
import 'package:personal_expenses/pages/user_transaction_form_page/widgets/date_field.dart';
import 'package:personal_expenses/pages/user_transaction_form_page/widgets/destination_account_field.dart';
import 'package:personal_expenses/pages/user_transaction_form_page/widgets/price_field.dart';
import 'package:personal_expenses/pages/user_transaction_form_page/widgets/title_field.dart';

class BetweenAccountsForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TitleField(),
        const SizedBox(height: 20),
        const Text("Origem:"),
        AccountField(),
        const Text("Destino:"),
        DestinationAccountField(),
        PriceField(),
        const SizedBox(height: 20),
        DateField(),
        const SizedBox(height: 20),
      ],
    );
  }
}
