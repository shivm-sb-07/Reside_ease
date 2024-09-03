import 'package:flutter/material.dart';

class HorizontalCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  const HorizontalCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        color: Colors.blue.shade100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 100,
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 23,
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      child: Text(
                        subtitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: Image.asset(image),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
