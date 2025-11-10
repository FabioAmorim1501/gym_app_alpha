import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_app_alpha/src/services/payment_service.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key, PaymentService? paymentService})
      : _paymentService = paymentService;

  final PaymentService? _paymentService;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late final PaymentService _paymentService;
  User? _user;

  @override
  void initState() {
    super.initState();
    _paymentService = widget._paymentService ?? PaymentService();
    _user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payments'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            if (_user != null) {
              _paymentService.makePayment(_user!.uid);
            } else {
              // Handle user not logged in
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('You must be logged in to make a payment.'),
                ),
              );
            }
          },
          child: const Text('Make Payment'),
        ),
      ),
    );
  }
}
