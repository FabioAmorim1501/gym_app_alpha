import 'package:flutter_test/flutter_test.dart';
import 'package:gym_app_alpha/src/services/payment_service.dart';

import 'fake_stripe.dart';

void main() {
  group('PaymentService', () {
    late PaymentService paymentService;
    late FakeStripe fakeStripe;

    setUp(() {
      fakeStripe = FakeStripe();
      paymentService = PaymentService(stripe: fakeStripe);
    });

    test('makePayment calls Stripe', () async {
      await paymentService.makePayment();
      expect(fakeStripe.initPaymentSheetCalled, isTrue);
      expect(fakeStripe.presentPaymentSheetCalled, isTrue);
    });
  });
}
