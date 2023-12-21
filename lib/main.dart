import 'package:esquare_batteries/screens/home/claim/claim_screen.dart';
import 'package:esquare_batteries/screens/home/feedback/feedback_screen.dart';
import 'package:esquare_batteries/screens/home/information/information_screen.dart';
import 'package:esquare_batteries/screens/home/offers/offers_screen.dart';
import 'package:esquare_batteries/screens/home/sales/sales_screen.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

import 'package:esquare_batteries/authentication/authentication.dart';

import 'screens/authentication/authentication_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Authentication()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E Square Batteries',
      home: const AuthenticationScreen(),
      routes: {
        SalesScreen.routeName: (context) => const SalesScreen(),
        ClaimScreen.routeName:(context) => const ClaimScreen(),
        FeedbackScreen.routeName: (context) => const FeedbackScreen(),
        InformationScreen.routeName: (context) => const InformationScreen(),
        OfferScreen.routeName: (context) => const OfferScreen(),
      },
    );
  }
}
