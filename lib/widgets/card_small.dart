import 'package:flutter/material.dart';

class SmallCard extends StatelessWidget {
  final String title;
  final String image;
  // final String route;
  const SmallCard({
    super.key,
    required this.title,
    required this.image,
    // required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.shade100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 120,
          width: 100,
          child: Column(
            children: [
              Image.asset(image, height: 80, width: 70),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600, // semibold
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
