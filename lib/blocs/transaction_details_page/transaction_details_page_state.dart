part of 'transaction_details_page_bloc.dart';

class TransactionDetailsState extends Equatable {
  final bool deleteAllInstallments;
  final bool isLoading;
  final UserTransaction? originTransaction;
  final UserTransaction? destinationTransaction;

  const TransactionDetailsState({
    this.deleteAllInstallments = false,
    this.isLoading = true,
    this.originTransaction,
    this.destinationTransaction,
  });

  TransactionDetailsState copyWith({
    bool? deleteAllInstallments,
    bool? isLoading,
    UserTransaction? originTransaction,
    UserTransaction? destinationTransaction,
  }) {
    return TransactionDetailsState(
      deleteAllInstallments:
          deleteAllInstallments ?? this.deleteAllInstallments,
      isLoading: isLoading ?? this.isLoading,
      originTransaction: originTransaction ?? this.originTransaction,
      destinationTransaction:
          destinationTransaction ?? this.destinationTransaction,
    );
  }

  @override
  List<Object?> get props => [
        deleteAllInstallments,
        isLoading,
        originTransaction,
        destinationTransaction,
      ];

  @override
  bool get stringify => true;
}

class TransactionDeleteSuccess extends TransactionDetailsState {}
