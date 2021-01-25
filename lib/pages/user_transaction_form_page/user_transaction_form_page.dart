import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expenses/blocs/transaction_form/transaction_form_bloc.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/pages/common/common_circular_indicator.dart';
import 'package:personal_expenses/pages/home_page/home_page.dart';
import 'package:personal_expenses/pages/user_transaction_form_page/widgets/normal_form.dart';

class UserTransactionFormPage extends StatefulWidget {
  final UserTransaction? originTransaction;

  const UserTransactionFormPage({
    Key? key,
    this.originTransaction,
  }) : super(key: key);

  static final _formKey = GlobalKey<FormState>();

  @override
  _UserTransactionFormPageState createState() =>
      _UserTransactionFormPageState();
}

class _UserTransactionFormPageState extends State<UserTransactionFormPage> {
  @override
  void initState() {
    super.initState();
    if (widget.originTransaction == null) {
      BlocProvider.of<TransactionFormBloc>(context).add(AddTransaction());
    } else {
      BlocProvider.of<TransactionFormBloc>(context).add(
        EditTransaction(
          originTransaction: widget.originTransaction!,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionFormBloc, TransactionFormState>(
      listener: (context, state) {
        if (state is TransactionFormSuccess) {
          FocusScope.of(context).unfocus();
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (_) => HomePage(),
            ),
            (_) => false,
          );
        }
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(30),
          ),
          child: Scaffold(
            appBar: AppBar(
              leading: Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.015,
                ),
                child: BlocBuilder<TransactionFormBloc, TransactionFormState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const IconButton(
                        icon: Icon(
                          Icons.close,
                          size: 35,
                        ),
                        onPressed: null,
                      );
                    } else {
                      return IconButton(
                        icon: const Icon(
                          Icons.close,
                          size: 35,
                        ),
                        onPressed: () {
                          BlocProvider.of<TransactionFormBloc>(context).add(
                            const FormCanceled(),
                          );
                          Navigator.of(context).pop();
                        },
                      );
                    }
                  },
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.025,
                  ),
                  child: BlocBuilder<TransactionFormBloc, TransactionFormState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const IconButton(
                          icon: Icon(
                            Icons.check,
                            size: 35,
                          ),
                          onPressed: null,
                        );
                      } else if (state is TransactionFormState) {
                        return IconButton(
                          icon: const Icon(
                            Icons.check,
                            size: 35,
                          ),
                          onPressed: () {
                            BlocProvider.of<TransactionFormBloc>(context)
                                .add(const FormSubmitted());
                          },
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.025,
                vertical: MediaQuery.of(context).size.height * 0.01,
              ),
              child: BlocBuilder<TransactionFormBloc, TransactionFormState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return CommonCircularIndicator();
                  } else {
                    return Form(
                      key: UserTransactionFormPage._formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Nova transação",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          NormalForm(),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
