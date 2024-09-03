import 'package:flutter/material.dart';

class CardBig extends StatelessWidget {
  final String title;
  final String image;
  final String buttonText;
  final Color cardColor;
  final Color containerColor;

  const CardBig({
    Key? key,
    required this.title,
    required this.image,
    required this.buttonText,
    required this.cardColor,
    required this.containerColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {},
      child: Card(
        color: cardColor,
        child: SizedBox(
          // Use a percentage of the screen size instead of fixed values
          height: screenSize.height * 0.3,
          width: screenSize.width * 0.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Image.asset(
                  image,
                  fit: BoxFit.fitHeight,
                  width: double.infinity,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    color: containerColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.w600, // semibold
                            fontSize:
                                screenSize.height * 0.02, // 2% of screen height
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        child: Text(
                          buttonText,
                          style: TextStyle(
                            fontWeight: FontWeight.w600, // semibold
                            fontSize:
                                screenSize.height * 0.02, // 2% of screen height
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}