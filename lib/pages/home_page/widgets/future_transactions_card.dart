import 'package:flutter/material.dart';
import 'package:personal_expenses/pages/common/blurred_card.dart';

class FutureTransactionsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.01,
      ),
      child: const BlurredCard(
        child: Text("Future Transactions"),
      ),
    );
  }
}
