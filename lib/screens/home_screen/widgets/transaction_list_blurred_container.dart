import 'dart:ui';

import 'package:flutter/material.dart';

class TransactionListBlurredContainer extends StatelessWidget {
  final Widget columnWidget;

  const TransactionListBlurredContainer({
    Key? key,
    required this.columnWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      margin: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.05,
        right: MediaQuery.of(context).size.width * 0.05,
        bottom: MediaQuery.of(context).size.width * 0.05,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Card(
            child: columnWidget,
          ),
        ),
      ),
    );
  }
}
