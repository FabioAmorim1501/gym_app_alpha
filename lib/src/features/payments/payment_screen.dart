import 'package:flutter/material.dart';
import 'package:gym_app_alpha/src/services/payment_service.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payments'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final paymentService = PaymentService();
            paymentService.makePayment();
          },
          child: const Text('Make Payment'),
        ),
      ),
    );
  }
}
