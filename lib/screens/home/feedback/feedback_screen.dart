import 'package:esquare_batteries/models/feedback.dart' as customer;
import 'package:esquare_batteries/screens/home/feedback/widgets/custom_widgets.dart';
import 'package:esquare_batteries/screens/widgets/universal_widgets.dart';
import 'package:flutter/material.dart';

import '../../../database/database.dart';
import '../scan/scan_screen.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});
  static const routeName = '/home/feedback';

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final Database _db = Database();
  String? serialNo;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController dealerController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController warrantyController = TextEditingController();
  final TextEditingController saledateController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const TopImage(),
          const H2(text: 'CUSTOMER FEEDBACK'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                height: 90,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.white,
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    _navigateAndDisplaySelection(context);
                  },
                  child: const Text(
                    'SCAN QR',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('SERIAL NO:'),
                        SizedBox(
                          height: 30,
                          width: MediaQuery.of(context).size.width / 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(serialNo ?? ''),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  FeedbackField(
                    title: 'DEALER NAME',
                    controller: dealerController,
                  ),
                  FeedbackField(
                    title: 'LOCATION',
                    controller: locationController,
                  ),
                  FeedbackField(
                    title: 'WARRENTY UPTO',
                    controller: warrantyController,
                  ),
                  FeedbackField(
                    title: 'DATE OF SALE',
                    controller: saledateController,
                  ),
                  FeedbackField(
                    title: 'TYPE REASON',
                    controller: reasonController,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: Button(
                      mainButtonText: 'CLAIM',
                      onPressed: feedback,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> feedback() async {
    if (serialNo == null || serialNo!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please scan the QR to get the serial number'),
          duration: Duration(seconds: 1),
        ),
      );
    } else if (_formKey.currentState!.validate()) {
      await _db
          .addFeedback(
        customer.Feedback(
          serial: serialNo ?? '',
          dealer: dealerController.text,
          location: locationController.text,
          warranty: warrantyController.text,
          saledate: saledateController.text,
          reason: reasonController.text,
        ),
      )
          .then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(value.toString()),
            duration: const Duration(seconds: 1),
          ),
        );
      });
    }
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    serialNo = Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => const SalesScan()),
    ).then((value) {
      setState(() {
        serialNo = value;
      });
    }) as String?;
  }
}
