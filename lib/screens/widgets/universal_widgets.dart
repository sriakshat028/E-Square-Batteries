import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.mainButtonText,
    required this.onPressed,
    // this.futureOnPressed,
  }) : super(key: key);

  final String mainButtonText;
  final void Function() onPressed;
  // final Future Function()? futureOnPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.black,
              width: 2,
            ),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        mainButtonText,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 25,
          color: Colors.black,
        ),
      ),
    );
  }
}

class TopImage extends StatelessWidget {
  const TopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 50,
        bottom: 50,
      ),
      child: Image.asset('assets/logo.png'),
    );
  }
}

class H1 extends StatelessWidget {
  const H1({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 25,
          color: Colors.black,
        ),
      ),
    );
  }
}

class H2 extends StatelessWidget {
  const H2({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      ),
    );
  }
}
