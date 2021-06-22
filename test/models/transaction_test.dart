import 'package:flutter_test/flutter_test.dart';

import 'package:personal_expenses/models/transaction.dart';

import 'transaction_mocks.dart';

void main() {
  group('UserTransaction', () {
    group('fromMap', () {
      test('should return a complete UserTransaction', () {
        // arrange
        final expectedTransaction = completeTransactionMock;
        final testTransactionMap = transactionMapMock;

        // act
        final result = UserTransaction.fromMap(testTransactionMap);

        // assert
        expect(result, isA<UserTransaction>());
        expect(result, expectedTransaction);
      });

      test(
          'should return a complete UserTransaction when installmentsId and betweenAccountsId fields are null',
          () {
        // arrange
        final expectedTransaction = completeTransactionWithNullFieldsMock;
        final testTransactionMap = transactionWithNullFieldsMapMock;

        // act
        final result = UserTransaction.fromMap(testTransactionMap);

        // assert
        expect(result, isA<UserTransaction>());
        expect(result, expectedTransaction);
      });
    });

    group('toMap', () {
      test('should return a valid map from a UserTransaction instance', () {
        // arrange
        final expectedMap = transactionMapMock;
        final testTransaction = completeTransactionMock;

        // act
        final result = testTransaction.toMap();

        // assert
        expect(result, isA<Map<String, dynamic>>());
        expect(result, expectedMap);
      });

      test(
          'should return a valid map with installmentsId and betweenAccountsId null',
          () {
        // arrange
        final expectedMap = transactionWithNullFieldsMapMock;
        final testTransaction = completeTransactionWithNullFieldsMock;

        // act
        final result = testTransaction.toMap();

        // assert
        expect(result, isA<Map<String, dynamic>>());
        expect(result, expectedMap);
      });
    });
  });
}
