import 'package:esquare_batteries/authentication/authentication.dart';
import 'package:esquare_batteries/screens/authentication/login_screen.dart';
import 'package:esquare_batteries/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    final authInstance = Provider.of<Authentication>(context);
    if (authInstance.loggedin) {
      return HomeScreen(
        authInstance: authInstance,
      );
    } else {
      return LoginScreen(
        authentication: authInstance,
      );
    }
  }
}
