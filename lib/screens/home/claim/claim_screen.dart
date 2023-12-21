import 'package:esquare_batteries/models/claim.dart';
import 'package:esquare_batteries/screens/widgets/universal_widgets.dart';
import 'package:flutter/material.dart';

import '../../../database/database.dart';
import '../scan/scan_screen.dart';
import 'widgets/custom_widgets.dart';

class ClaimScreen extends StatefulWidget {
  const ClaimScreen({super.key});
  static const routeName = '/home/claim';

  @override
  State<ClaimScreen> createState() => _ClaimScreenState();
}

class _ClaimScreenState extends State<ClaimScreen> {
  final Database _db = Database();
  String? serialNo;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController vehicleController = TextEditingController();
  final TextEditingController customerController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController warrantyController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const TopImage(),
          const H2(text: 'CLAIM REGISTER'),
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
                  ClaimField(
                    title: 'VEHICLE NO',
                    controller: vehicleController,
                  ),
                  ClaimField(
                    title: 'CUTOMER NAME',
                    controller: customerController,
                  ),
                  ClaimField(
                    title: 'MOB NO',
                    controller: mobileController,
                  ),
                  ClaimField(
                    title: 'MODEL',
                    controller: modelController,
                  ),
                  ClaimField(
                    title: 'DATE OF SALE',
                    controller: dateController,
                  ),
                  ClaimField(
                    title: 'WARRANTY UPTO',
                    controller: warrantyController,
                  ),
                  ClaimField(
                    title: 'TYPE REASON',
                    controller: reasonController,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: Button(
              mainButtonText: 'CLAIM',
              onPressed: claim,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> claim() async {
    if (serialNo == null || serialNo!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please scan the QR to get the serial number'),
          duration: Duration(seconds: 1),
        ),
      );
    } else if (_formKey.currentState!.validate()) {
      await _db
          .addClaim(
        Claim(
          serial: serialNo ?? '',
          vehicle: vehicleController.text,
          customer: customerController.text,
          mobile: mobileController.text,
          model: modelController.text,
          date: dateController.text,
          warranty: warrantyController.text,
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
