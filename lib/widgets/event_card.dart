import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CardEvents extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final VoidCallback onBookmarkPressed;
  final VoidCallback onLearnMorePressed;

  const CardEvents({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.onBookmarkPressed,
    required this.onLearnMorePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.yellow.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12,
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      placeholder: (context, url) => Center(
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.cover,
                      fadeInDuration: Duration(seconds: 1),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.black.withOpacity(0.5),
                      ),
                      shape: MaterialStateProperty.all(
                        const CircleBorder(),
                      ),
                    ),
                    icon: const Icon(
                      Icons.bookmark_border,
                      color: Colors.white,
                    ),
                    onPressed: onBookmarkPressed,
                  ),
                ),
              ],
            ),
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
