import 'package:flutter/material.dart';

class VisitorCard extends StatelessWidget {
  final String guestName;
  final String visitorType;
  final String approvedBy;
  final String timeInfo;
  final String status;

  const VisitorCard({
    Key? key,
    required this.guestName,
    required this.visitorType,
    required this.approvedBy,
    required this.timeInfo,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$guestName - $visitorType',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                if (status == 'Approved') ...[
                  Icon(Icons.check_circle, color: Colors.green),
                  SizedBox(width: 8.0),
                  Text('Approved by $approvedBy'),
                ] else ...[
                  Icon(Icons.cancel, color: Colors.red),
                  SizedBox(width: 8.0),
                  Text('Declined by $approvedBy'),
                ],
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Icon(Icons.access_time, color: Colors.grey),
                SizedBox(width: 8.0),
                Text('$timeInfo'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
