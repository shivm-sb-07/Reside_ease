import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SOSScreen extends StatelessWidget {
  SOSScreen({super.key});

  final List<Map<String, dynamic>> helplineNumbers = [
    {"name": "NATIONAL EMERGENCY NUMBER", "number": "112"},
    {"name": "POLICE", "number": "100"},
    {"name": "FIRE", "number": "101"},
    {"name": "AMBULANCE", "number": "102"},
    {"name": "Disaster Management Services", "number": "108"},
    {"name": "Woman Helpline", "number": "1094"},
    {"name": "Woman Helpline (Domestic Abuse)", "number": "181"},
    {"name": "Air Ambulance", "number": "9540161344"},
    {"name": "Aids Helpline", "number": "1097"},
    {"name": "Anti Poison ( New Delhi )", "number": "1066"},
    {"name": "Disaster Management ( N.D.M.A )", "number": "01126701728"},
    {
      "name":
          "EARTHQUAKE / FLOOD / DISASTER ( N.D.R.F Headquaters ) NDRF HELPLINE NO",
      "number": "9711077372"
    },
    {"name": "Children In Difficult Situation", "number": "1098"},
    {"name": "CYBER CRIME HELPLINE", "number": "155620"},
    {"name": "COVID 19 HELPLINE", "number": "104"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SOS Numbers',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.red.shade200,
      ),
      body: ListView.separated(
        itemCount: helplineNumbers.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(helplineNumbers[index]['name']),
            subtitle: Text(helplineNumbers[index]['number']),
            onTap: () {
              launch("tel://${helplineNumbers[index]['number']}");
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Theme.of(context).colorScheme.secondary,
          ); // This adds a divider after each ListTile
        },
      ),
    );
  }
}
