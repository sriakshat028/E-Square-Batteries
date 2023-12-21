import 'package:flutter/material.dart';

import '../widgets/universal_widgets.dart';
import './widgets/custom_widgets.dart';
import '../../authentication/authentication.dart';

enum AuthenticationStatus {
  login,
  forgetpassword,
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.authentication});
  final Authentication authentication;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthenticationStatus status = AuthenticationStatus.login;
  String mainButtonText = 'LOGIN';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authInstance = widget.authentication;

    switchStatus(AuthenticationStatus newStatus) {
      setState(() {
        status = newStatus;
        if (newStatus == AuthenticationStatus.login) {
          mainButtonText = 'LOGIN';
        } else if (newStatus == AuthenticationStatus.forgetpassword) {
          mainButtonText = 'RESET PASSWORD';
        }
      });
    }

    login() {
      if (status == AuthenticationStatus.login) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Loading...')),
        );
        authInstance
            .login(emailController.text, passwordController.text)
            .then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(value),
              duration: const Duration(seconds: 1),
            ),
          );
        });
      } else {
        switchStatus(AuthenticationStatus.login);
      }
    }

    fogetPassword() {
      if (status == AuthenticationStatus.forgetpassword) {
        authInstance.sendPasswordResetEmail(emailController.text);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'An email has been sent to you, (make sure to check spam)',
            ),
          ),
        );
      } else {
        switchStatus(AuthenticationStatus.forgetpassword);
      }
    }

    mainButtonPressed() {
      if (_formKey.currentState!.validate()) {
        if (status == AuthenticationStatus.login) {
          login();
        } else if (status == AuthenticationStatus.forgetpassword) {
          fogetPassword();
        }
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 50, right: 50),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const TopImage(),
              const SizedBox(
                height: 50,
              ),
              AuthField(
                emailController: emailController,
                obscureText: false,
              ),
              const SizedBox(
                height: 20,
              ),
              status == AuthenticationStatus.login
                  ? AuthField(
                      emailController: passwordController,
                      obscureText: true,
                    )
                  : const SizedBox(),
              // Buttons
              const SizedBox(
                height: 20,
              ),
              Button(
                mainButtonText: mainButtonText,
                onPressed: mainButtonPressed,
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () {
                  if (status != AuthenticationStatus.forgetpassword) {
                    fogetPassword();
                  } else {
                    login();
                  }
                },
                child: Text(
                  status == AuthenticationStatus.forgetpassword
                      ? 'Sign Up'
                      : 'FORGOT PASSWORD',
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
