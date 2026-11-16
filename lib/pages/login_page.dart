import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> _login() async {
    print('Login button pressed'); // Debug where the function starts
    print('Email: ${_emailController.text}, Password: ${_passwordController.text}');

    setState(() {
      isLoading = true;
    });

    try {
      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      print('UserCredential received: $userCredential'); // Check if login was successful

      final User? user = userCredential.user;

      if (user != null) {
        print('Login successful. User email: ${user.email}');
        Navigator.pushReplacementNamed(context, '/home', arguments: {'email': user.email});
      } else {
        print('User is null after login');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to retrieve user details.')),
        );
      }
    } catch (e) {
      print('Error during login: ${e.toString()}'); // Log any error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: ${e.toString()}')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Rendering LoginPage'); // Debugging UI rendering
    return Scaffold(
      backgroundColor: Color(0xFFFFFAEC),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'VRoute',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF578E7E),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
              SizedBox(height: 20),
              isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF5ECD5),
                ),
                child: Text('Login'),
              ),
              TextButton(
                onPressed: () {
                  print('Navigating to RegisterPage'); // Debug navigation
                  Navigator.pushReplacementNamed(context, '/register');
                },
                child: Text('No account? Register here'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
