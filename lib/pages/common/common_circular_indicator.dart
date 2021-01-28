import 'package:flutter/material.dart';

class CommonCircularIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator.adaptive(
        semanticsLabel: "Carregando.",
        valueColor: AlwaysStoppedAnimation(
          Theme.of(context).accentColor,
        ),
      ),
    );
  }
}
