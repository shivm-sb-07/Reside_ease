import 'package:flutter/material.dart';
import 'package:reside_ease/widgets/event_card.dart';

class CommunityEvent extends StatelessWidget {
  const CommunityEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        children: [
          CardEvents(
            imageUrl:
                'https://images.unsplash.com/photo-1504805572947-34fad45aed93?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            title: 'Support our Little Stars 🌟',
            description:
                'Help brighten the future of our little stars by donating to their education fund.',
            onBookmarkPressed: () {
              // Add bookmark logic here
            },
            onLearnMorePressed: () {
              // Add learn more logic here
            },
          ),
          const SizedBox(height: 8),
          CardEvents(
            imageUrl:
                'https://images.unsplash.com/photo-1683009427666-340595e57e43?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            title: 'Scuba Diving in the Carribean 🏝️',
            description:
                'Join us for a fun day of scuba diving in the Carribean. We will be meeting at the beach at 8:00 AM. Please bring your own gear. We will be providing lunch. See you there!',
            onBookmarkPressed: () {
              // Add bookmark logic here
            },
            onLearnMorePressed: () {
              // Add learn more logic here
            },
          ),
          const SizedBox(height: 8),

          CardEvents(
            imageUrl:
                'https://images.unsplash.com/photo-1682685797527-63b4e495938f?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            title: 'Into the Desert 🏜️',
            description:
                'Join us for a fun day of hiking in the desert. We will be meeting at the trailhead at 8:00 AM. Please bring your own gear. We will be providing lunch. See you there! Get ready to explore the breathtaking landscapes and experience the thrill of conquering challenging trails. This event is suitable for both beginners and experienced hikers. Don\'t miss out on this amazing opportunity to connect with nature and make new friends. Remember to wear comfortable hiking shoes and bring plenty of water. We can\'t wait to see you on the trail!',
            onBookmarkPressed: () {
              // Add bookmark logic here
            },
            onLearnMorePressed: () {
              // Add learn more logic here
            },
          ),
          const SizedBox(height: 8),

          CardEvents(
            imageUrl:
                'https://images.unsplash.com/photo-1682685797366-715d29e33f9d?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            title: 'Saudi Arabia 🕌',
            description:
                'A trip to Saudi Arabia is incomplete without a visit to the holy city of Mecca. Join us for a spiritual journey to the birthplace of Islam. We will be meeting at the airport at 8:00 AM. Please bring your own gear. We will be providing lunch. See you there!',
            onBookmarkPressed: () {
              // Add bookmark logic here
            },
            onLearnMorePressed: () {
              // Add learn more logic here
            },
          ),
          // Add more CardEvents as needed
        ],
      ),
    );
  }
}
