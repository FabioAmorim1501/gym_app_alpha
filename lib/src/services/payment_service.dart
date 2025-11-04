import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:gym_app_alpha/src/services/firestore_service.dart';

class PaymentService {
  final Stripe _stripe;
  final FirestoreService _firestoreService;

  PaymentService({Stripe? stripe, FirestoreService? firestoreService})
      : _stripe = stripe ?? Stripe.instance,
        _firestoreService = firestoreService ?? FirestoreService();

  Future<void> makePayment() async {
    try {
      // 1. create payment intent on the server
      final clientSecret = await _firestoreService.createPaymentIntent(
        userId: 'hardcoded_user_id',
        amount: 1000,
      );
      // 2. initialize the payment sheet
      await _stripe.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Your Merchant Name',
        ),
      );
      // 3. display the payment sheet.
      await _stripe.presentPaymentSheet();
    } catch (e) {
      // Handle exceptions
      print(e);
    }
  }
}
