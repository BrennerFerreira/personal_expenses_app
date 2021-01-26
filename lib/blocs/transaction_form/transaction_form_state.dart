part of 'transaction_form_bloc.dart';

class TransactionFormState extends Equatable {
  final bool isLoading;
  int? id;
  final bool isNew;
  final bool editAllInstallments;
  final String title;
  final bool newAccount;
  final List<String> accountList;
  final String account;
  final double price;
  final bool isIncome;
  DateTime? date;
  final bool isInstallments;
  final int numberOfInstallments;
  final String? installmentsId;
  final String? titleError;
  final String? accountError;
  final String? priceError;
  final String? numberOfInstallmentsError;

  TransactionFormState({
    this.isLoading = true,
    this.id,
    this.isNew = true,
    this.editAllInstallments = false,
    this.title = "",
    this.newAccount = false,
    this.accountList = const [],
    this.account = "",
    this.price = 0.0,
    this.isIncome = false,
    this.date,
    this.isInstallments = false,
    this.numberOfInstallments = 1,
    this.installmentsId,
    this.titleError,
    this.accountError,
    this.priceError,
    this.numberOfInstallmentsError,
  }) {
    date = date ?? DateTime.now();
  }

  TransactionFormState copyWith({
    bool? isLoading,
    int? id,
    bool? isNew,
    bool? editAllInstallments,
    String? title,
    bool? newAccount,
    List<String>? accountList,
    String? account,
    double? price,
    bool? isIncome,
    DateTime? date,
    bool? isInstallments,
    int? numberOfInstallments,
    String? installmentsId,
    String? titleError,
    String? accountError,
    String? priceError,
    String? numberOfInstallmentsError,
  }) {
    return TransactionFormState(
      isLoading: isLoading ?? this.isLoading,
      id: id ?? this.id,
      isNew: isNew ?? this.isNew,
      editAllInstallments: editAllInstallments ?? this.editAllInstallments,
      title: title ?? this.title,
      newAccount: newAccount ?? this.newAccount,
      accountList: accountList ?? this.accountList,
      account: account ?? this.account,
      price: price ?? this.price,
      isIncome: isIncome ?? this.isIncome,
      date: date ?? this.date,
      isInstallments: isInstallments ?? this.isInstallments,
      numberOfInstallments: numberOfInstallments ?? this.numberOfInstallments,
      installmentsId: installmentsId ?? this.installmentsId,
      titleError: titleError == "" ? null : titleError ?? this.titleError,
      accountError:
          accountError == "" ? null : accountError ?? this.accountError,
      priceError: priceError == "" ? null : priceError ?? this.priceError,
      numberOfInstallmentsError: numberOfInstallmentsError == ""
          ? null
          : numberOfInstallmentsError ?? this.numberOfInstallmentsError,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        id,
        isNew,
        editAllInstallments,
        title,
        newAccount,
        accountList,
        account,
        price,
        isIncome,
        date,
        isInstallments,
        numberOfInstallments,
        installmentsId,
        titleError,
        accountError,
        priceError,
        numberOfInstallmentsError,
      ];

  @override
  bool get stringify => true;
}

class TransactionFormSuccess extends TransactionFormState {
  TransactionFormSuccess() : super();

  @override
  List<Object?> get props => [];
}
