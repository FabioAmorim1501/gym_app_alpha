import 'package:flutter/material.dart';
import 'package:gym_app_alpha/src/features/auth/login_screen.dart';
import 'package:gym_app_alpha/src/features/payments/payment_screen.dart';
import 'package:gym_app_alpha/src/features/training_plans/create_training_plan_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gym App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/create-training-plan': (context) => const CreateTrainingPlanScreen(),
        '/payment': (context) => const PaymentScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/create-training-plan');
              },
              child: const Text('Create Training Plan'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/payment');
              },
              child: const Text('Make Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
