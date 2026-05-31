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
  bool _isLoading = false;

  @override
  void dispose() {
    // ⚡ Bolt: Disposing TextEditingControllers prevents memory leaks when widget is destroyed.
    // Impact: Reduces memory consumption by cleaning up native resources.
    _emailController.dispose();
    _passwordController.dispose();
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
              maxLength: 100, // 🛡️ Sentinel: Added length limit to prevent DoS
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              textInputAction: TextInputAction.done,
              maxLength: 100, // 🛡️ Sentinel: Added length limit to prevent DoS
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: _isLoading
                  ? null
                  : () async {
                      final email = _emailController.text.trim();
                      final password = _passwordController.text;

                      if (email.isEmpty || !email.contains('@')) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please enter a valid email address.')),
                        );
                        return;
                      }

                      if (password.length < 8) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Password must be at least 8 characters long.')),
                        );
                        return;
                      }

                      setState(() {
                        _isLoading = true;
                      });
                      final user = await _auth.signUp(
                        email,
                        password,
                      );
                      if (mounted) {
                        setState(() {
                          _isLoading = false;
                        });
                        if (user != null) {
                          Navigator.pushReplacementNamed(context, '/home');
                        } else {
                           // 🛡️ Sentinel: Generic error message to prevent leaking user existence
                           ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Signup failed. Please try again.')),
                          );
                        }
                      }
                    },
              child: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Signup'),
            ),
          ],
        ),
      ),
    );
  }
}
