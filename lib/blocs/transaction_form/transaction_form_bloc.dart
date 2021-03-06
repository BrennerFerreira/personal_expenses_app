import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/repositories/account/account_repository.dart';
import 'package:personal_expenses/repositories/transactions/transactions_repository.dart';

part 'transaction_form_event.dart';
part 'transaction_form_state.dart';

class TransactionFormBloc
    extends Bloc<TransactionFormEvent, TransactionFormState> {
  TransactionFormBloc() : super(TransactionFormState());

  final accountRepository = AccountRepository();
  final transactionRepository = TransactionRepository();

  @override
  Stream<TransactionFormState> mapEventToState(
    TransactionFormEvent event,
  ) async* {
    if (event is FormCanceled) {
      yield TransactionFormState();
    } else if (event is AddTransaction) {
      yield TransactionFormState();
      final List<String> accountList = await accountRepository.getAllAccounts();
      yield TransactionFormState(
        isLoading: false,
        accountList: accountList,
      );
    } else if (event is EditTransaction) {
      yield TransactionFormState();
      final List<String> accountList = await accountRepository.getAllAccounts();
      if (event.transaction.isBetweenAccounts) {
        final Map<String, UserTransaction> transactions =
            await transactionRepository.getBetweenAccountsTransaction(
          event.transaction.betweenAccountsId!,
        );
        final UserTransaction income =
            transactions['income'] as UserTransaction;
        final UserTransaction outcome =
            transactions['outcome'] as UserTransaction;
        final List<String> destinationAccountList = [...accountList]
          ..remove(outcome.account);
        yield TransactionFormState(
          isLoading: false,
          accountList: accountList,
          isNew: false,
          account: outcome.account,
          title: outcome.title,
          date: outcome.date,
          isBetweenAccounts: outcome.isBetweenAccounts,
          betweenAccountsId: outcome.betweenAccountsId,
          destinationAccount: income.account,
          destinationAccountList: destinationAccountList,
          price: outcome.price,
        );
      } else if (event.transaction.isInstallment) {
        final List<UserTransaction> transactions = await transactionRepository
            .getTransactionByInstallmentId(event.transaction.installmentId!);
        yield TransactionFormState(
          isLoading: false,
          accountList: accountList,
          id: event.transaction.id,
          isNew: false,
          account: event.transaction.account,
          title: event.transaction.title.replaceAll(
            RegExp(r" - (\d+) de (\d+)$"),
            "",
          ),
          price: event.transaction.price,
          isIncome: event.transaction.isIncome,
          date: event.transaction.date,
          transactionDate: event.transaction.date,
          firstTransactionDate: transactions[0].date,
          isInstallments: event.transaction.isInstallment,
          numberOfInstallments: event.transaction.numberOfInstallments,
          installmentsId: event.transaction.installmentId,
        );
      } else {
        yield TransactionFormState(
          isLoading: false,
          accountList: accountList,
          id: event.transaction.id,
          isNew: false,
          account: event.transaction.account,
          title: event.transaction.title.replaceAll(
            RegExp(r" - (\d+) de (\d+)$"),
            "",
          ),
          price: event.transaction.price,
          isIncome: event.transaction.isIncome,
          date: event.transaction.date,
          isInstallments: event.transaction.isInstallment,
          numberOfInstallments: event.transaction.numberOfInstallments,
          installmentsId: event.transaction.installmentId,
        );
      }
    } else if (event is EditAllInstallmentsChanged) {
      if (event.newEditAllInstallments) {
        yield state.copyWith(
          editAllInstallments: event.newEditAllInstallments,
          date: state.firstTransactionDate,
        );
      } else {
        yield state.copyWith(
          editAllInstallments: event.newEditAllInstallments,
          date: state.transactionDate,
        );
      }
    } else if (event is IsBetweenAccountsChanged) {
      yield state.copyWith(
        isBetweenAccounts: event.newOption,
        titleError: "",
        accountError: "",
        destinationAccountError: "",
        priceError: "",
        numberOfInstallmentsError: "",
      );
    } else if (event is TitleChanged) {
      yield state.copyWith(
        title: event.newTitle,
        titleError: "",
      );
    } else if (event is NewAccountChanged) {
      yield state.copyWith(
        newAccount: event.newOption,
        account: "",
        accountError: "",
      );
    } else if (event is AccountChanged) {
      List<String> destinationAccountList = [];
      if (state.isBetweenAccounts && !state.newAccount) {
        destinationAccountList = [...state.accountList]
          ..removeWhere((element) => element == event.newAccount);
      } else {
        destinationAccountList = [...state.accountList];
      }
      yield state.copyWith(
        account: event.newAccount,
        destinationAccountList: destinationAccountList,
        accountError: "",
        destinationAccountError: "",
      );
    } else if (event is DestinationNewAccountChanged) {
      yield state.copyWith(
        destinationNewAccount: event.newOption,
        destinationAccount: "",
        destinationAccountError: "",
      );
    } else if (event is DestinationAccountChanged) {
      yield state.copyWith(
        destinationAccount: event.newDestinationAccount,
        destinationAccountError: "",
      );
    } else if (event is PriceChanged) {
      final String priceReplaced =
          event.newPrice.replaceAll(".", "").replaceAll(",", ".");
      final double price = double.parse(priceReplaced);
      yield state.copyWith(
        price: price,
        priceError: "",
      );
    } else if (event is IsIncomeChanged) {
      yield state.copyWith(
        isIncome: event.newIsIncome,
      );
    } else if (event is DateChanged) {
      yield state.copyWith(
        date: event.newDate,
      );
    } else if (event is IsInstallmentsChanged) {
      yield state.copyWith(
        isInstallments: event.newIsInstallments,
        numberOfInstallments: 1,
        numberOfInstallmentsError: "",
      );
    } else if (event is NumberOfInstallmentsChanged) {
      final int newNumberOfInstallments =
          int.tryParse(event.newNumberOfInstallments) ?? 1;
      yield state.copyWith(
        numberOfInstallments: newNumberOfInstallments,
        numberOfInstallmentsError: "",
      );
    } else if (event is FormSubmitted) {
      String? titleError;
      String? accountError;
      String? destinationAccountError;
      String? priceError;
      String? numberOfInstallmentsError;
      if (state.title.trim().isEmpty) {
        titleError = "Por favor, escreva um título válido para a transação.";
      }
      if (state.account.trim().isEmpty) {
        accountError = "Por favor, selecione uma conta para a transação.";
      }
      if (state.newAccount && state.accountList.contains(state.account)) {
        accountError = "Já existe uma conta com este nome";
      }
      if (state.isBetweenAccounts && state.destinationAccount.trim().isEmpty) {
        destinationAccountError =
            "Por favor, selecione uma conta destino para a transação.";
      }
      if (state.isBetweenAccounts &&
          state.destinationNewAccount &&
          state.accountList.contains(state.destinationAccount)) {
        destinationAccountError = "Já existe uma conta com este nome";
      }
      if (state.isBetweenAccounts &&
          state.destinationNewAccount &&
          state.destinationAccount == state.account) {
        destinationAccountError =
            "As contas de origem e destino não podem ser iguais.";
      }
      if (state.price <= 0.0) {
        priceError = "Por favor, selecione um valor para a transação.";
      }
      if (state.price > 9999999.99) {
        priceError = "Valor acima do máximo aceito.";
      }
      if (state.isInstallments && state.numberOfInstallments < 1) {
        numberOfInstallmentsError =
            "Por favor, selecione um número válido de parcelas.";
      }
      if (state.isInstallments && state.numberOfInstallments > 60) {
        numberOfInstallmentsError = "O número máximo de parcelas aceito é 60.";
      }
      if (titleError == null &&
          accountError == null &&
          destinationAccountError == null &&
          priceError == null &&
          numberOfInstallmentsError == null) {
        yield state.copyWith(
          isLoading: true,
        );

        if (state.isNew) {
          if (state.isBetweenAccounts) {
            final int id = DateTime.now().millisecondsSinceEpoch;
            await transactionRepository.saveTransaction(
              UserTransaction(
                title: state.title,
                account: state.account,
                date: state.date!,
                savedAt: DateTime.now(),
                price: state.price,
                isBetweenAccounts: true,
                betweenAccountsId: id.toString(),
              ),
            );
            await transactionRepository.saveTransaction(
              UserTransaction(
                title: state.title,
                account: state.destinationAccount,
                date: state.date!,
                savedAt: DateTime.now(),
                price: state.price,
                isIncome: true,
                isBetweenAccounts: true,
                betweenAccountsId: id.toString(),
              ),
            );
          } else if (state.isInstallments) {
            final int id = DateTime.now().millisecondsSinceEpoch;
            for (int i = 0; i < state.numberOfInstallments; i++) {
              if (DateTime(
                        state.date!.year,
                        state.date!.month + i,
                        state.date!.day,
                      ).month -
                      DateTime(
                        state.date!.year,
                        state.date!.month + i - 1,
                        state.date!.day,
                      ).month >
                  1) {
                await transactionRepository.saveTransaction(
                  UserTransaction(
                    title:
                        "${state.title} - ${i + 1} de ${state.numberOfInstallments}",
                    account: state.account,
                    date: DateTime(
                      state.date!.year,
                      state.date!.month + i + 1,
                      0,
                    ),
                    price: state.price / state.numberOfInstallments,
                    savedAt: DateTime.now(),
                    isIncome: state.isIncome,
                    isInstallment: true,
                    numberOfInstallments: state.numberOfInstallments,
                    installmentId: id.toString(),
                  ),
                );
              } else {
                await transactionRepository.saveTransaction(
                  UserTransaction(
                    title:
                        "${state.title} - ${i + 1} de ${state.numberOfInstallments}",
                    account: state.account,
                    date: DateTime(
                      state.date!.year,
                      state.date!.month + i,
                      state.date!.day,
                    ),
                    price: state.price / state.numberOfInstallments,
                    savedAt: DateTime.now(),
                    isIncome: state.isIncome,
                    isInstallment: true,
                    numberOfInstallments: state.numberOfInstallments,
                    installmentId: id.toString(),
                  ),
                );
              }
            }
          } else {
            await transactionRepository.saveTransaction(
              UserTransaction(
                title: state.title,
                account: state.account,
                date: state.date!,
                price: state.price,
                savedAt: DateTime.now(),
                isIncome: state.isIncome,
              ),
            );
          }
        } else {
          if (state.isBetweenAccounts) {
            await transactionRepository
                .deleteTransactionByBetweenAccounId(state.betweenAccountsId!);
            if (state.isBetweenAccounts) {
              final int id = DateTime.now().millisecondsSinceEpoch;
              await transactionRepository.saveTransaction(
                UserTransaction(
                  title: state.title,
                  account: state.account,
                  date: state.date!,
                  savedAt: DateTime.now(),
                  price: state.price,
                  isBetweenAccounts: true,
                  betweenAccountsId: id.toString(),
                ),
              );
              await transactionRepository.saveTransaction(
                UserTransaction(
                  title: state.title,
                  account: state.destinationAccount,
                  date: state.date!,
                  savedAt: DateTime.now(),
                  price: state.price,
                  isIncome: true,
                  isBetweenAccounts: true,
                  betweenAccountsId: id.toString(),
                ),
              );
            }
          } else if (state.editAllInstallments) {
            await transactionRepository.deleteTransactionByInstallmentId(
              state.installmentsId!,
            );
            if (state.isInstallments) {
              final int id = DateTime.now().millisecondsSinceEpoch;
              for (int i = 0; i < state.numberOfInstallments; i++) {
                if (DateTime(
                          state.date!.year,
                          state.date!.month + i,
                          state.date!.day,
                        ).month -
                        DateTime(
                          state.date!.year,
                          state.date!.month + i - 1,
                          state.date!.day,
                        ).month >
                    1) {
                  await transactionRepository.saveTransaction(
                    UserTransaction(
                      title:
                          "${state.title} - ${i + 1} de ${state.numberOfInstallments}",
                      account: state.account,
                      date: DateTime(
                        state.date!.year,
                        state.date!.month + i + 1,
                        0,
                      ),
                      price: state.price / state.numberOfInstallments,
                      savedAt: DateTime.now(),
                      isIncome: state.isIncome,
                      isInstallment: true,
                      numberOfInstallments: state.numberOfInstallments,
                      installmentId: id.toString(),
                    ),
                  );
                } else {
                  await transactionRepository.saveTransaction(
                    UserTransaction(
                      title:
                          "${state.title} - ${i + 1} de ${state.numberOfInstallments}",
                      account: state.account,
                      date: DateTime(
                        state.date!.year,
                        state.date!.month + i,
                        state.date!.day,
                      ),
                      price: state.price / state.numberOfInstallments,
                      savedAt: DateTime.now(),
                      isIncome: state.isIncome,
                      isInstallment: true,
                      numberOfInstallments: state.numberOfInstallments,
                      installmentId: id.toString(),
                    ),
                  );
                }
              }
            } else {
              await transactionRepository.saveTransaction(
                UserTransaction(
                  title: state.title,
                  account: state.account,
                  date: state.date!,
                  price: state.price,
                  savedAt: DateTime.now(),
                  isIncome: state.isIncome,
                ),
              );
            }
          } else {
            await transactionRepository.updateTransaction(
              UserTransaction(
                id: state.id,
                title: state.title,
                account: state.account,
                date: state.date!,
                price: state.price,
                savedAt: DateTime.now(),
                isIncome: state.isIncome,
                isInstallment: state.isInstallments,
                numberOfInstallments: state.numberOfInstallments,
                installmentId: state.installmentsId,
              ),
            );
          }
        }
        yield TransactionFormSuccess();
        yield TransactionFormState();
      } else {
        yield state.copyWith(
          titleError: titleError,
          accountError: accountError,
          destinationAccountError: destinationAccountError,
          priceError: priceError,
          numberOfInstallmentsError: numberOfInstallmentsError,
        );
      }
    }
  }
}
