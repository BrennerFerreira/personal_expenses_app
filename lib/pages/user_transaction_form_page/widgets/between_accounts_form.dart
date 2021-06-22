import 'package:flutter/material.dart';

import 'account_field.dart';
import 'date_field.dart';
import 'destination_account_field.dart';
import 'price_field.dart';
import 'title_field.dart';

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
