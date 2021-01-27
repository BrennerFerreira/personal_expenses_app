part of 'account_details_page_bloc.dart';

abstract class AccountDetailsPageEvent extends Equatable {
  const AccountDetailsPageEvent();

  @override
  List<Object?> get props => [];
}

class UpdateAccountDetailsPage extends AccountDetailsPageEvent {
  final String account;
  const UpdateAccountDetailsPage(this.account);

  @override
  List<Object?> get props => [account];

  @override
  String toString() => 'UpdateAccountDetailsPage(account: $account)';
}
