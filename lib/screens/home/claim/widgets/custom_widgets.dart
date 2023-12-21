import 'package:flutter/material.dart';

class ClaimField extends StatelessWidget {
  const ClaimField({
    Key? key,
    required this.title,
    required this.controller,
  }) : super(key: key);
  final String title;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          SizedBox(
            height: 30,
            width: MediaQuery.of(context).size.width / 2,
            child: TextFormField(
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(
                    width: 1.0,
                    color: Colors.black,
                  ),
                ),
              ),
              controller: controller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please fill this field';
                } else {
                  return null;
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
