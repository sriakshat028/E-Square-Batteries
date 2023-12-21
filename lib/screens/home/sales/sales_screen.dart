import 'package:esquare_batteries/database/database.dart';
import 'package:esquare_batteries/models/sale.dart';
import 'package:esquare_batteries/screens/home/scan/scan_screen.dart';
import 'package:esquare_batteries/screens/home/sales/widgets/custom_widget.dart';
import 'package:esquare_batteries/screens/widgets/universal_widgets.dart';
import 'package:flutter/material.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});
  static const routeName = '/home/sales';

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  final Database _db = Database();

  String? serialNo = '';
  final TextEditingController modelController = TextEditingController();
  final TextEditingController healthController = TextEditingController();
  final TextEditingController vehicleController = TextEditingController();
  final TextEditingController customerController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController optController = TextEditingController();
  final TextEditingController kmController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const TopImage(),
          const H2(text: 'Sales Register'),
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
                  SalesField(
                    title: 'MODEL NO',
                    controller: modelController,
                  ),
                  SalesField(
                    title: 'BATTERY HEALTH',
                    controller: healthController,
                  ),
                  SalesField(
                    title: 'VEHICLE',
                    controller: vehicleController,
                  ),
                  SalesField(
                    title: 'CUSTOMER',
                    controller: customerController,
                  ),
                  SalesField(
                    title: 'MOBILE',
                    controller: mobileController,
                  ),
                  SalesField(
                    title: 'OPT',
                    controller: optController,
                  ),
                  SalesField(
                    title: 'KM',
                    controller: kmController,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: Button(
              mainButtonText: 'REGISTER',
              onPressed: register,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> register() async {
    if (serialNo == null || serialNo!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please scan the QR to get the serial number'),
          duration: Duration(seconds: 1),
        ),
      );
    } else if (_formKey.currentState!.validate()) {
      final date = DateTime.now();
      final String saleDate =
          date.day.toString() + date.month.toString() + date.year.toString();
      await _db
          .addSale(
        Sale(
          model: modelController.text,
          serial: serialNo ?? '',
          health: healthController.text,
          vehicle: vehicleController.text,
          customer: customerController.text,
          mobile: mobileController.text,
          opt: optController.text,
          km: kmController.text,
          date: saleDate,
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
