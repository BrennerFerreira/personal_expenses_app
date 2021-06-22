import 'package:flutter/material.dart';

import 'account_field.dart';
import 'date_field.dart';
import 'edit_all_installments_field.dart';
import 'installments_field.dart';
import 'is_income_field.dart';
import 'price_field.dart';
import 'title_field.dart';

class NormalForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        EditAllInstallmentsField(),
        TitleField(),
        const SizedBox(height: 10),
        AccountField(),
        InstallmentsField(),
        const SizedBox(height: 20),
        PriceField(),
        const SizedBox(height: 20),
        IsIncomeField(),
        DateField(),
        const SizedBox(height: 20),
      ],
    );
  }
}
