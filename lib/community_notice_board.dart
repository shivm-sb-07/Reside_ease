import 'package:flutter/material.dart';
import 'package:reside_ease/widgets/notice_card.dart';

class CommunityNotice extends StatelessWidget {
  const CommunityNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        children: [
          CardNotice(
            title: 'Event Announcements',
            description:
                "Don't miss our Annual General Meeting today. All members are encouraged to attend.",
            onLearnMorePressed: () {
              // Add learn more logic here
            },
          ),
          const SizedBox(height: 8),
          CardNotice(
            title: 'Promoting Club Activities',
            description:
                "Book Club Meeting: Discussing [book] on [date] at [location]. New members welcome!",
            onLearnMorePressed: () {
              // Add learn more logic here
            },
          ),
          const SizedBox(height: 8),
          CardNotice(
            title: 'General Announcements',
            description:
                "Lost and Found: A Mobile phone was found in parking area. Claim it at the front desk.",
            onLearnMorePressed: () {
              // Add learn more logic here
            },
          ),
          const SizedBox(height: 8),
          CardNotice(
            title: 'Safety and Security Notices',
            description:
                "Emergency Evacuation Drill: We will be conducting a drill on 17th. Please familiarize yourself with emergency exits.",
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
