part of 'account_tile_bloc.dart';

abstract class AccountTileEvent extends Equatable {
  const AccountTileEvent();

  @override
  List<Object?> get props => [];
}

class UpdateAccountTile extends AccountTileEvent {
  final String account;

  const UpdateAccountTile(this.account);

  @override
  List<Object?> get props => [account];

  @override
  String toString() => 'UpdateAccountTile(account: $account)';
}
