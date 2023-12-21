import 'package:flutter/material.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/views/home/components/all_news_page.dart';
import 'package:mobile/views/home/components/anime_page.dart';
import 'package:mobile/views/home/components/comics_page.dart';
import 'package:mobile/views/home/components/gaming_page.dart';
import 'package:mobile/views/home/components/movie_page.dart';
import 'package:mobile/views/home/components/tv_page.dart';

final List<String> tabs = [
  'All',
  'Movies',
  'TV Series',
  'Anime',
  'Gaming',
  'Comics',
];

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  void updateIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              title: Text(
                'The Cultural News',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
              ),
            ),
            const SliverToBoxAdapter(child: verticalMargin12),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: tabs.length,
                  padding: horizontalPadding16 + bottomPadding8,
                  itemBuilder: (BuildContext context, int index) {
                    return selectedText(label: tabs[index], index: index);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return horizontalMargin12;
                  },
                ),
              ),
            ),
          ],
          body: IndexedStack(
            index: _currentIndex,
            children: const [
              AllNewsPage(),
              MoviePage(),
              TVPage(),
              AnimePage(),
              GamingPage(),
              ComicsPage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget selectedText({required String label, required int index}) {
    return InkWell(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        padding: horizontalPadding16,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
          color: _currentIndex == index
              ? Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade700
                  : Colors.grey.shade300
              : null,
        ),
        child: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ),
    );
  }
}
