import 'package:flutter/material.dart';

class AditionalInfoWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const AditionalInfoWidget(
      {super.key,
      required this.icon,
      required this.label,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Icon(
            icon,
            size: 30,
          ),
          // const SizedBox(
          //   height: 5,
          // ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
          // const SizedBox(
          //   height: 5,
          // ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
