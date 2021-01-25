import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Excluir transação",
        style: TextStyle(
          color: Theme.of(context).errorColor,
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      content: const Text(
        "Tem certeza que deseja excluir esta transação? Esta ação não pode ser desfeita.",
      ),
      actions: [
        FlatButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text("Cancelar"),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text(
            "Excluir",
            style: TextStyle(
              color: Theme.of(context).errorColor,
            ),
          ),
        ),
      ],
    );
  }
}
