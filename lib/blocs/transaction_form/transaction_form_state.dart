part of 'transaction_form_bloc.dart';

class TransactionFormState extends Equatable {
  final bool isNew;
  final String title;
  final bool newAccount;
  final List<String> accountList;
  final String account;
  final double price;

  const TransactionFormState({
    this.isNew = false,
    this.title = "",
    this.newAccount = false,
    this.accountList = const [],
    this.account = "",
    this.price = 0.0,
  });

  TransactionFormState copyWith({
    bool? isNew,
    String? title,
    bool? newAccount,
    List<String>? accountList,
    String? account,
    double? price,
  }) {
    return TransactionFormState(
      isNew: isNew ?? this.isNew,
      title: title ?? this.title,
      newAccount: newAccount ?? this.newAccount,
      accountList: accountList ?? this.accountList,
      account: account ?? this.account,
      price: price ?? this.price,
    );
  }

  @override
  List<Object?> get props => [
        isNew,
        title,
        newAccount,
        accountList,
        account,
        price,
      ];
}

class TransactionFormLoadInProgress extends TransactionFormState {
  const TransactionFormLoadInProgress() : super();

  @override
  List<Object?> get props => [];
}

class TransactionFormError extends TransactionFormState {
  final String? titleError;
  final String? accountError;
  final String? priceError;

  const TransactionFormError({
    this.titleError,
    this.accountError,
    this.priceError,
  });

  @override
  List<Object?> get props => [
        titleError,
        accountError,
        priceError,
      ];

  @override
  String toString() =>
      'TransactionFormError(titleError: $titleError, accountError: $accountError, priceError: $priceError)';
}
