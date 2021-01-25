import 'package:flutter/material.dart';
import 'package:personal_expenses/pages/user_transaction_form_page/widgets/account_field.dart';
import 'package:personal_expenses/pages/user_transaction_form_page/widgets/date_field.dart';
import 'package:personal_expenses/pages/user_transaction_form_page/widgets/installments_field.dart';
import 'package:personal_expenses/pages/user_transaction_form_page/widgets/is_income_field.dart';
import 'package:personal_expenses/pages/user_transaction_form_page/widgets/price_field.dart';
import 'package:personal_expenses/pages/user_transaction_form_page/widgets/title_field.dart';

class NormalForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          TitleField(),
          const SizedBox(height: 10),
          AccountField(),
          PriceField(),
          const SizedBox(height: 20),
          IsIncomeField(),
          DateField(),
          InstallmentsField(),
        ],
      ),
    );
  }
}
