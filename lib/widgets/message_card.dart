import 'package:flutter/material.dart';

class CardNotice extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final VoidCallback onMessagePressed;

  const CardNotice({
    super.key,
    required this.title,
    required this.description,
    required this.onMessagePressed,
    required CircleAvatar leading,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    child: Text(
                      'A',
                    ),
                  ),
                  const SizedBox(
                    width: 19,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
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
            Container(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: OutlinedButton(
                  onPressed: onMessagePressed,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Message'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
