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
  final ValueNotifier<bool> _isLoadingNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _paymentService = widget._paymentService ?? PaymentService();
    _user = FirebaseAuth.instance.currentUser;
  }

  @override
  void dispose() {
    _isLoadingNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payments')),
      body: Center(
        child: ValueListenableBuilder<bool>(
          valueListenable: _isLoadingNotifier,
          builder: (context, isLoading, child) {
            return ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () async {
                      if (_user != null) {
                        _isLoadingNotifier.value = true;
                        try {
                          await _paymentService.makePayment(_user!.uid);
                        } finally {
                          if (mounted) {
                            _isLoadingNotifier.value = false;
                          }
                        }
                      } else {
                        // Handle user not logged in
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('You must be logged in to make a payment.'),
                          ),
                        );
                      }
                    },
              child: isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Make Payment'),
            );
          },
        ),
      ),
    );
  }
}
