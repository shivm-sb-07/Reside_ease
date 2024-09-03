import 'package:flutter/material.dart';
import 'package:reside_ease/community_event_page.dart';
import 'package:reside_ease/community_post.dart';
import 'package:reside_ease/widgets/top_appbar.dart';
import 'package:reside_ease/community_notice_board.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: const TopAppBar(),
        body: Column(
          children: [
            Material(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 15.0,
                ),
                child: TabBar(
                  indicatorColor: Colors.blue.shade900,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black54,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerHeight: 0,
                  indicator: BoxDecoration(
                    color: Colors.blue.shade900,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  tabs: const <Widget>[
                    Tab(
                      text: 'Posts',
                    ),
                    Tab(
                      text: 'Events',
                    ),
                    Tab(
                      text: 'Notice Board',
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: <Widget>[
                  CommunityPost(),
                  CommunityEvent(),
                  CommunityNotice()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
