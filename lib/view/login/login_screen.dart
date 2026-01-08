import 'package:flutter/material.dart';
import 'package:map_exam/components/ui/buttons.dart';
import 'package:map_exam/viewmodel/login_viewmodel.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LoginViewModel>(context);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Please Sign In",
                  style: TextStyle(fontSize: 24, color: Colors.black)),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              if (viewModel.isLoading) CircularProgressIndicator(),
              if (viewModel.errorMessage != null)
                Text(viewModel.errorMessage!,
                    style: TextStyle(color: Colors.red)),
              CustomButton(
                label: 'Sign In',
                onPressed: () {
                  String email = _emailController.text,
                      password = _passwordController.text;
                  viewModel.signIn(context, email, password);
                },
                isRound: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
