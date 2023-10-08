import 'package:akar_icons_flutter/akar_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mobile/views/favorite/bookmark_page.dart';
import 'package:mobile/views/home/home_page.dart';
import 'package:mobile/views/profile/profile_page.dart';

class MyDashboard extends StatefulWidget {
  const MyDashboard({super.key});

  @override
  State<MyDashboard> createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboard> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: index,
              children: const [
                MyHomePage(),
                // MyWeeklyPage(),
                MyBookmarkPage(),
                MyProfilePage(),
              ],
            ),
          ),
          const Divider(height: 0, thickness: .2),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 56,
        notchMargin: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                setState(() => index = 0);
              },
              icon: Icon(
                AkarIcons.home,
                color: index == 0
                    ? Theme.of(context).colorScheme.onSurface
                    : Colors.grey,
              ),
            ),
            // IconButton(
            //   onPressed: () {
            //     setState(() => index = 1);
            //   },
            //   icon: Icon(
            //     AkarIcons.globe,
            //     color: index == 1
            //         ? Theme.of(context).colorScheme.onSurface
            //         : Colors.grey,
            //   ),
            // ),
            IconButton(
              onPressed: () {
                setState(() => index = 1);
              },
              icon: Icon(
                Icons.bookmark,
                color: index == 1
                    ? Theme.of(context).colorScheme.onSurface
                    : Colors.grey,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() => index = 2);
              },
              icon: Icon(
                AkarIcons.person,
                color: index == 2
                    ? Theme.of(context).colorScheme.onSurface
                    : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
