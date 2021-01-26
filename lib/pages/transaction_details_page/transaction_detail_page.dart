import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/blocs/transaction_details/transaction_details_bloc.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/pages/common/blurred_card.dart';
import 'package:personal_expenses/pages/common/common_scaffold.dart';
import 'package:personal_expenses/pages/transaction_details_page/widgets/delete_dialog.dart';
import 'package:personal_expenses/pages/user_transaction_form_page/user_transaction_form_page.dart';

class TransactionDetailsPage extends StatelessWidget {
  final UserTransaction transaction;
  final MaterialPageRoute lastPage;

  final transactionDetailsBloc = TransactionDetailsBloc();

  TransactionDetailsPage({
    Key? key,
    required this.transaction,
    required this.lastPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return BlocProvider(
      create: (context) => transactionDetailsBloc,
      child: BlocListener<TransactionDetailsBloc, TransactionDetailsState>(
        listener: (context, state) {
          if (state is TransactionDeleteSuccess) {
            Navigator.of(context).pushAndRemoveUntil(
              lastPage,
              (route) => false,
            );
          }
        },
        child: CommonScaffold(
          leadingButton:
              BlocBuilder<TransactionDetailsBloc, TransactionDetailsState>(
            value: transactionDetailsBloc,
            builder: (context, state) {
              return IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  size: 35,
                ),
                onPressed: state.isLoading
                    ? null
                    : () {
                        Navigator.of(context).pushAndRemoveUntil(
                          lastPage,
                          (route) => false,
                        );
                      },
              );
            },
          ),
          actionButtons: [
            BlocBuilder<TransactionDetailsBloc, TransactionDetailsState>(
              value: transactionDetailsBloc,
              builder: (context, state) {
                if (state.isLoading) {
                  return const IconButton(
                    icon: Icon(
                      Icons.edit,
                      size: 35,
                    ),
                    onPressed: null,
                  );
                } else {
                  return IconButton(
                    icon: const Icon(
                      Icons.edit,
                      size: 35,
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(30),
                          ),
                        ),
                        builder: (context) => UserTransactionFormPage(
                          originTransaction: transaction,
                        ),
                      );
                    },
                  );
                }
              },
            ),
            const SizedBox(width: 15),
            BlocBuilder<TransactionDetailsBloc, TransactionDetailsState>(
              value: transactionDetailsBloc,
              builder: (context, state) {
                return IconButton(
                  icon: const Icon(
                    Icons.delete,
                    size: 35,
                  ),
                  onPressed: state.isLoading
                      ? null
                      : () async {
                          final bool? deleteTransaction =
                              await showDialog<bool>(
                            context: context,
                            builder: (context) {
                              return DeleteDialog(
                                transaction: transaction,
                                transactionDetailsBloc: transactionDetailsBloc,
                              );
                            },
                          );
                          if (deleteTransaction != null && deleteTransaction) {
                            transactionDetailsBloc.add(
                              DeleteTransaction(
                                transaction,
                              ),
                            );
                          }
                        },
                );
              },
            ),
          ],
          title: transaction.title,
          children: [
            Text(
              "Criada em: ${DateFormat(DateFormat.YEAR_MONTH_DAY, 'pt-BR').format(transaction.savedAt)}",
            ),
            const SizedBox(height: 30),
            BlurredCard(
              child: ListView(
                shrinkWrap: true,
                children: [
                  attributeRow(
                    context,
                    preffix: "Conta: ",
                    attribute: transaction.account,
                  ),
                  attributeRow(
                    context,
                    preffix: "Data da transação: ",
                    attribute: DateFormat(DateFormat.YEAR_MONTH_DAY, 'pt-BR')
                        .format(transaction.date),
                  ),
                  attributeRow(
                    context,
                    preffix: "Tipo de transação: ",
                    attribute: transaction.isIncome ? "Receita" : "Despesa",
                  ),
                  attributeRow(
                    context,
                    preffix: "Valor: ",
                    attribute:
                        "R\$ ${transaction.price.toStringAsFixed(2).replaceAll(".", ",")}",
                  ),
                  attributeRow(
                    context,
                    preffix: "Parcelas: ",
                    attribute: transaction.isInstallment
                        ? transaction.numberOfInstallments.toString()
                        : "Parcela Única",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget attributeRow(
    BuildContext context, {
    required String preffix,
    required String attribute,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.01,
      ),
      child: Wrap(
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: preffix,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: attribute,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
