import 'package:flutter/material.dart';
import 'package:reside_ease/widgets/card_visitor.dart';

class VisitorLogsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visitors Log'),
        backgroundColor: Colors.blue.shade100,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Today',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              VisitorCard(
                guestName: 'Aishwarya Singh',
                approvedBy: 'Abhishek',
                timeInfo: '10:00 - Still Inside',
                visitorType: 'Guest',
                status: 'Approved',
              ),
              VisitorCard(
                guestName: 'Ihsan Pradipta',
                approvedBy: 'Abhishek',
                timeInfo: '11:45 - Declined Entry',
                visitorType: 'Amazon',
                status: 'Declined',
              ),
              VisitorCard(
                guestName: 'Ahmad Farouq',
                approvedBy: 'Abhishek',
                timeInfo: '01:45 - 01:47',
                visitorType: 'Zomato',
                status: 'Approved',
              ),
              SizedBox(height: 16.0),
              Text(
                'Yesterday',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              VisitorCard(
                guestName: 'Gurpreet Ram',
                approvedBy: 'Abhishek',
                timeInfo: '10:00 - Still Inside',
                visitorType: 'Guest',
                status: 'Approved',
              ),
              VisitorCard(
                guestName: 'Ihsan Pradipta',
                approvedBy: 'Abhishek',
                timeInfo: '11:45 - 11:50',
                visitorType: 'Uber',
                status: 'Approved',
              ),
              SizedBox(height: 16.0),
              Text(
                'Last Week',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              VisitorCard(
                guestName: 'Gurjot Singh',
                approvedBy: 'Abhishek',
                timeInfo: '10:00 - 10:05',
                visitorType: 'Flipkart',
                status: 'Approved',
              ),
              VisitorCard(
                guestName: 'Jane Smith',
                approvedBy: 'Abhishek',
                timeInfo: '11:45 - Declined Entry',
                visitorType: 'Amazon',
                status: 'Declined',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
