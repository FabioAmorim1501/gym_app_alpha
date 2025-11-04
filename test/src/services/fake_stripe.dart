import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:mockito/mockito.dart';

class FakeStripe extends Fake implements Stripe {
  bool initPaymentSheetCalled = false;
  bool presentPaymentSheetCalled = false;

  @override
  Future<PaymentSheetPaymentOption?> initPaymentSheet({
    required SetupPaymentSheetParameters paymentSheetParameters,
  }) async {
    initPaymentSheetCalled = true;
    return const PaymentSheetPaymentOption(label: 'test', image: 'test');
  }

  @override
  Future<PaymentSheetPaymentOption?> presentPaymentSheet(
      {PaymentSheetPresentOptions? options,
      bool? useDeprecatedOnCardPressed}) async {
    presentPaymentSheetCalled = true;
    return const PaymentSheetPaymentOption(label: 'test', image: 'test');
  }
}
