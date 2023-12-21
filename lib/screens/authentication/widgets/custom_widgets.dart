import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  const AuthField({
    Key? key,
    required this.emailController,
    required this.obscureText,
  }) : super(key: key);

  final TextEditingController emailController;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    final text = (obscureText ? 'PASSWORD' : 'USER ID');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text),
        SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          child: TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(
                  width: 3.0,
                  color: Colors.black,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            obscureText: obscureText,
            controller: emailController,
          ),
        ),
      ],
    );
  }
}
