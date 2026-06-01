import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        brightness: Brightness.dark,
        primaryColor: Colors.deepOrange,
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1F1F1F),
          foregroundColor: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
          elevation: 0,
        ),
        colorScheme: const ColorScheme.dark(
          primary: Colors.deepOrange,
          secondary: Colors.tealAccent,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepOrange,
            foregroundColor: Colors.white,
          ),
        ),
      ),
      home: const LoginScreen(),
      onGenerateRoute: (settings) {
        if (settings.name == '/home') {
          return MaterialPageRoute(builder: (context) => const HomeScreen());
        }
        if (settings.name == '/create-training-plan') {
          final args = settings.arguments as Map<String, dynamic>?;
          final athleteId = args?['athleteId'] ?? 'unknown_athlete_id';
          return MaterialPageRoute(
            builder: (context) =>
                CreateTrainingPlanScreen(athleteId: athleteId),
          );
        }
        if (settings.name == '/payment') {
          return MaterialPageRoute(builder: (context) => const PaymentScreen());
        }
        return null;
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/create-training-plan',
                  arguments: {'athleteId': 'sample_athlete_123'},
                );
              },
              child: const Text('Create Training Plan'),
            ),
            const SizedBox(height: 16),
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
