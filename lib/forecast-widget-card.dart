import 'package:flutter/material.dart';

class ForecastWidgetCard extends StatelessWidget {
  final IconData icon;
  final String time;
  final String temp;
  const ForecastWidgetCard(
      {super.key, required this.icon, required this.temp, required this.time});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      height: 110,
      child: Card(
        //TIME
        elevation: 50,
        child: Column(
          children: [
            const SizedBox(
              height: 2.5,
            ),
            Text(
              time,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            //weather Icon
            Icon(
              icon,
              size: 50,
            ),
            const SizedBox(
              height: 2.5,
            ),
            //TEMPERATURE
            Text(
              temp,
              style: const TextStyle(
                // fontWeight: FontWeight.bold,
                fontSize: 12.5,
              ),
            ),
            const SizedBox(
              height: 1.5,
            ),
          ],
        ),
      ),
    );
  }
}
