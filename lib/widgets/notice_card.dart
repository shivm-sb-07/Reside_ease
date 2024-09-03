import 'package:flutter/material.dart';

class CardNotice extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onLearnMorePressed;

  const CardNotice({
    super.key,
    required this.title,
    required this.description,
    required this.onLearnMorePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // elevation: 5,
      color: Colors.lightBlue.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 16,
          left: 12,
          right: 12,
          bottom: 16,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              description,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: OutlinedButton(
                onPressed: onLearnMorePressed,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Learn More'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
