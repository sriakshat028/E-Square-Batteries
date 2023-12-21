import 'package:esquare_batteries/authentication/authentication.dart';
import 'package:esquare_batteries/screens/home/claim/claim_screen.dart';
import 'package:esquare_batteries/screens/home/feedback/feedback_screen.dart';
import 'package:esquare_batteries/screens/home/information/information_screen.dart';
import 'package:esquare_batteries/screens/home/offers/offers_screen.dart';
import 'package:esquare_batteries/screens/home/sales/sales_screen.dart';
import 'package:flutter/material.dart';

import '../../screens/widgets/universal_widgets.dart';
import 'widgets/custome_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.authInstance});

  final Authentication authInstance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          const TopImage(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomButton(
                text: 'Sales Register',
                onPressed: () => Navigator.pushNamed(
                  context,
                  SalesScreen.routeName,
                ),
              ),
              CustomButton(
                text: 'Customer Feedback',
                onPressed: () => Navigator.pushNamed(
                  context,
                  FeedbackScreen.routeName,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomButton(
                text: 'Claim Register',
                onPressed: () => Navigator.pushNamed(
                  context,
                  ClaimScreen.routeName,
                ),
              ),
              CustomButton(
                text: 'Stock Status',
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomButton(
                text: 'Battery Information',
                onPressed: () => Navigator.pushNamed(
                  context,
                  InformationScreen.routeName,
                ),
              ),
              CustomButton(
                text: 'Offers',
                onPressed: () => Navigator.pushNamed(
                  context,
                  OfferScreen.routeName,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          CustomButton(
            text: 'Log Out',
            onPressed: () {
              authInstance.signout();
            },
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border(
            top: BorderSide(
              //                    <--- top side
              color: Colors.black,
              width: 2,
            ),
          ),
          color: Color.fromARGB(255, 124, 183, 232),
        ),
        child: const Text(
          'CONTACT US:-7744942610',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
