import 'package:flutter/material.dart';

class CommonErrorText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Erro ao recuperar os dados. Por favor, reinicie o aplicativo.",
      ),
    );
  }
}
