import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../blocs/transaction_details_page/transaction_details_page_bloc.dart';
import '../../models/transaction.dart';
import '../common/blurred_card.dart';
import '../common/common_circular_indicator.dart';
import '../common/common_scaffold.dart';
import '../user_transaction_form_page/user_transaction_form_page.dart';
import 'widgets/delete_dialog.dart';

class TransactionDetailsPage extends StatefulWidget {
  final UserTransaction transaction;
  final MaterialPageRoute lastPage;
  final bool fromSearch;

  const TransactionDetailsPage({
    Key? key,
    required this.transaction,
    required this.lastPage,
    this.fromSearch = false,
  }) : super(key: key);

  @override
  _TransactionDetailsPageState createState() => _TransactionDetailsPageState();
}

class _TransactionDetailsPageState extends State<TransactionDetailsPage> {
  late TransactionDetailsBloc transactionDetailsBloc;

  @override
  void initState() {
    super.initState();
    transactionDetailsBloc = TransactionDetailsBloc()
      ..add(
        UpdateTransactionDetailsPage(
          transaction: widget.transaction,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return BlocProvider(
      create: (context) => transactionDetailsBloc,
      child: BlocListener<TransactionDetailsBloc, TransactionDetailsState>(
        bloc: transactionDetailsBloc,
        listener: (context, state) {
          if (state is TransactionDeleteSuccess) {
            Navigator.of(context).pushAndRemoveUntil(
              widget.lastPage,
              (route) => false,
            );
          }
        },
        child: WillPopScope(
          onWillPop: widget.fromSearch
              ? () async => true
              : () async {
                  Navigator.of(context).pushAndRemoveUntil(
                    widget.lastPage,
                    (route) => false,
                  );
                  return true;
                },
          child: BlocBuilder<TransactionDetailsBloc, TransactionDetailsState>(
            bloc: transactionDetailsBloc,
            builder: (context, state) {
              return CommonScaffold(
                leadingButton: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 35,
                    semanticLabel: "Retornar para a tela anterior.",
                  ),
                  onPressed: state.isLoading
                      ? null
                      : widget.fromSearch
                          ? Navigator.of(context).pop
                          : () {
                              Navigator.of(context).pushAndRemoveUntil(
                                widget.lastPage,
                                (route) => false,
                              );
                            },
                ),
                actionButtons: [
                  if (state.isLoading)
                    const IconButton(
                      icon: Icon(
                        Icons.edit,
                        size: 35,
                        semanticLabel: "Editar a transação.",
                      ),
                      onPressed: null,
                    )
                  else
                    IconButton(
                      icon: const Icon(
                        Icons.edit,
                        size: 35,
                        semanticLabel: "Editar a transação.",
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
                            transaction: state.originTransaction,
                          ),
                        );
                      },
                    ),
                  const SizedBox(width: 15),
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      size: 35,
                      semanticLabel: "Excluir a transação.",
                    ),
                    onPressed: state.isLoading
                        ? null
                        : () async {
                            final bool? deleteTransaction =
                                await showDialog<bool>(
                              context: context,
                              builder: (context) {
                                return DeleteDialog(
                                  transaction: state.originTransaction!,
                                  transactionDetailsBloc:
                                      transactionDetailsBloc,
                                );
                              },
                            );
                            if (deleteTransaction != null &&
                                deleteTransaction) {
                              transactionDetailsBloc.add(
                                DeleteTransaction(
                                  state.originTransaction!,
                                ),
                              );
                            }
                          },
                  ),
                ],
                title: state.isLoading ? "" : state.originTransaction!.title,
                children: state.isLoading
                    ? [
                        CommonCircularIndicator(),
                      ]
                    : [
                        Text(
                          "Criada em: ${DateFormat(DateFormat.YEAR_MONTH_DAY, 'pt-BR').format(state.originTransaction!.savedAt)}",
                        ),
                        const SizedBox(height: 30),
                        BlurredCard(
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              attributeRow(
                                context,
                                preffix: "Conta: ",
                                attribute: state.originTransaction!.account,
                              ),
                              attributeRow(
                                context,
                                preffix: "Data da transação: ",
                                attribute: DateFormat(
                                        DateFormat.YEAR_MONTH_DAY, 'pt-BR')
                                    .format(state.originTransaction!.date),
                              ),
                              if (!state.originTransaction!.isBetweenAccounts)
                                attributeRow(
                                  context,
                                  preffix: "Tipo de transação: ",
                                  attribute: state.originTransaction!.isIncome
                                      ? "Receita"
                                      : "Despesa",
                                ),
                              if (state.originTransaction!.isInstallment)
                                attributeRow(
                                  context,
                                  preffix: "Valor total: ",
                                  attribute: NumberFormat.currency(
                                          locale: 'pt-BR', symbol: "R\$")
                                      .format(state.originTransaction!.price *
                                          state.originTransaction!
                                              .numberOfInstallments),
                                ),
                              attributeRow(
                                context,
                                preffix: state.originTransaction!.isInstallment
                                    ? "Valor da parcela: "
                                    : "Valor: ",
                                attribute: NumberFormat.currency(
                                        locale: 'pt-BR', symbol: "R\$")
                                    .format(state.originTransaction!.price),
                              ),
                              if (state.originTransaction!.isInstallment)
                                attributeRow(
                                  context,
                                  preffix: "Parcelas: ",
                                  attribute: state
                                      .originTransaction!.numberOfInstallments
                                      .toString(),
                                ),
                              if (state.originTransaction!.isBetweenAccounts)
                                attributeRow(
                                  context,
                                  preffix: "Conta de origem: ",
                                  attribute: state.originTransaction!.account,
                                ),
                              if (state.originTransaction!.isBetweenAccounts)
                                attributeRow(
                                  context,
                                  preffix: "Conta de destino: ",
                                  attribute:
                                      state.destinationTransaction!.account,
                                ),
                            ],
                          ),
                        ),
                      ],
              );
            },
          ),
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
