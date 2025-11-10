import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_app_alpha/src/services/firestore_service.dart';
import 'package:gym_app_alpha/src/services/payment_service.dart';
import 'package:mocktail/mocktail.dart';

import '../../test_helper.dart';

class MockStripe extends Mock implements Stripe {}

class MockFirestoreService extends Mock implements FirestoreService {}

void main() {
  setUpAll(() {
    registerFallbackValue(const SetupPaymentSheetParameters(
      paymentIntentClientSecret: 'test',
    ));
  });

  group('PaymentService', () {
    late PaymentService paymentService;
    late MockStripe mockStripe;
    late MockFirestoreService mockFirestoreService;

    setUp(() async {
      await setupTest();
      mockStripe = MockStripe();
      mockFirestoreService = MockFirestoreService();
      paymentService = PaymentService(
        stripe: mockStripe,
        firestoreService: mockFirestoreService,
      );
    });

    test('makePayment calls FirestoreService and Stripe', () async {
      // Arrange
      const clientSecret = 'test_client_secret';
      const userId = 'test_user_id';
      when(() => mockFirestoreService.createPaymentIntent(
            userId: any(named: 'userId'),
            amount: any(named: 'amount'),
          )).thenAnswer((_) async => clientSecret);

      when(() => mockStripe.initPaymentSheet(
            paymentSheetParameters: any(named: 'paymentSheetParameters'),
          )).thenAnswer((_) async {});

      when(() => mockStripe.presentPaymentSheet())
          .thenAnswer((_) async => const PaymentSheetPaymentOption(label: 'test', image: 'test'));

      // Act
      await paymentService.makePayment(userId);

      // Assert
      verify(() => mockFirestoreService.createPaymentIntent(
            userId: userId,
            amount: 1000,
          )).called(1);

      verify(() => mockStripe.initPaymentSheet(
            paymentSheetParameters: const SetupPaymentSheetParameters(
              paymentIntentClientSecret: clientSecret,
              merchantDisplayName: 'Your Merchant Name',
            ),
          )).called(1);

      verify(() => mockStripe.presentPaymentSheet()).called(1);
    });
  });
}
