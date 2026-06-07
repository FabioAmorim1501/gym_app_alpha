import 'package:flutter/material.dart';
import 'package:gym_app_alpha/src/services/auth_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final AuthService _auth = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ValueNotifier<bool> _isLoadingNotifier = ValueNotifier(false);

  @override
  void dispose() {
    // ⚡ Bolt: Disposing TextEditingControllers prevents memory leaks when widget is destroyed.
    // Impact: Reduces memory consumption by cleaning up native resources.
    _emailController.dispose();
    _passwordController.dispose();
    _isLoadingNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Signup')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autocorrect: false,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            TextField(
              controller: _passwordController,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            // ⚡ Bolt: Use ValueListenableBuilder instead of setState to avoid rebuilding the entire form
            // Impact: Improves performance by localizing rebuilds to just the button when loading state changes
            ValueListenableBuilder<bool>(
              valueListenable: _isLoadingNotifier,
              builder: (context, isLoading, child) {
                return ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          final email = _emailController.text.trim();
                          final password = _passwordController.text;

                          if (email.isEmpty || !email.contains('@')) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Please enter a valid email address.')),
                            );
                            return;
                          }

                          if (password.length < 8) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Password must be at least 8 characters long.')),
                            );
                            return;
                          }

                          _isLoadingNotifier.value = true;

                          final user = await _auth.signUp(
                            email,
                            password,
                          );

                          if (mounted) {
                            _isLoadingNotifier.value = false;
                            if (user != null) {
                              Navigator.pushReplacementNamed(context, '/home');
                            }
                          }
                        },
                  child: isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Signup'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
