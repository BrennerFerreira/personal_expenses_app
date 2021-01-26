part of 'transaction_details_bloc.dart';

class TransactionDetailsState extends Equatable {
  final bool deleteAllInstallments;
  final bool isLoading;

  const TransactionDetailsState({
    this.deleteAllInstallments = false,
    this.isLoading = false,
  });

  TransactionDetailsState copyWith({
    bool? deleteAllInstallments,
    bool? isLoading,
  }) {
    return TransactionDetailsState(
      deleteAllInstallments:
          deleteAllInstallments ?? this.deleteAllInstallments,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [deleteAllInstallments, isLoading];

  @override
  String toString() =>
      'TransactionDetailsInitial(deleteAllInstallments: $deleteAllInstallments)';
}

class TransactionDeleteSuccess extends TransactionDetailsState {}
