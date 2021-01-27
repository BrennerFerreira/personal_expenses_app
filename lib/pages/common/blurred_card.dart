import 'dart:ui';

import 'package:flutter/material.dart';

class BlurredCard extends StatelessWidget {
  final Widget child;
  final bool isHomePage;

  const BlurredCard({
    Key? key,
    required this.child,
    this.isHomePage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10.0,
          sigmaY: 10.0,
        ),
        child: Card(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.015,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
