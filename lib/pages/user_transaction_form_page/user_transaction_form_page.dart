import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/transaction_form/transaction_form_bloc.dart';
import '../../models/transaction.dart';
import '../common/common_circular_indicator.dart';
import '../home_page/home_page.dart';
import 'widgets/between_accounts_form.dart';
import 'widgets/normal_form.dart';

class UserTransactionFormPage extends StatefulWidget {
  final UserTransaction? transaction;

  const UserTransactionFormPage({
    Key? key,
    this.transaction,
  }) : super(key: key);

  static final _formKey = GlobalKey<FormState>();

  @override
  _UserTransactionFormPageState createState() =>
      _UserTransactionFormPageState();
}

class _UserTransactionFormPageState extends State<UserTransactionFormPage> {
  final _controller = PageController();
  @override
  void initState() {
    super.initState();
    if (widget.transaction == null) {
      BlocProvider.of<TransactionFormBloc>(context).add(AddTransaction());
    } else {
      BlocProvider.of<TransactionFormBloc>(context).add(
        EditTransaction(
          transaction: widget.transaction!,
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
      child: WillPopScope(
        onWillPop: () async {
          BlocProvider.of<TransactionFormBloc>(context).add(
            const FormCanceled(),
          );
          return true;
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
                            semanticLabel: "Retornar para a página anterior.",
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
                    child:
                        BlocBuilder<TransactionFormBloc, TransactionFormState>(
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
                            icon: Icon(
                              Icons.check,
                              size: 35,
                              semanticLabel: state.isNew
                                  ? "Adicionar transação"
                                  : "Confirmar edição da transação.",
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
                            Text(
                              state.isNew
                                  ? "Nova transação"
                                  : "Editar transação",
                              style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (state.isNew)
                              CheckboxListTile(
                                title:
                                    const Text("Transaferência entre contas"),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                contentPadding: EdgeInsets.zero,
                                value: state.isBetweenAccounts,
                                onChanged: (newOption) {
                                  BlocProvider.of<TransactionFormBloc>(context)
                                      .add(
                                    IsBetweenAccountsChanged(
                                      newOption: newOption!,
                                    ),
                                  );
                                  if (newOption) {
                                    _controller.animateToPage(
                                      1,
                                      curve: Curves.linear,
                                      duration: const Duration(
                                        milliseconds: 500,
                                      ),
                                    );
                                  } else {
                                    _controller.animateToPage(
                                      0,
                                      curve: Curves.linear,
                                      duration: const Duration(
                                        milliseconds: 500,
                                      ),
                                    );
                                  }
                                },
                              ),
                            Expanded(
                              child: PageView(
                                controller: _controller,
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  if (state.isNew || !state.isBetweenAccounts)
                                    NormalForm(),
                                  if (state.isNew || state.isBetweenAccounts)
                                    BetweenAccountsForm(),
                                ],
                              ),
                            ),
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
      ),
    );
  }
}
