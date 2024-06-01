import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/screens/popular_screen/tab_bar_items.dart';
import 'package:flutter_fiveflix/screens/popular_screen/widgets/categories_media_screen.dart';
import 'package:flutter_fiveflix/screens/popular_screen/widgets/popular_movie_screen.dart';
import 'package:flutter_fiveflix/screens/popular_screen/widgets/popular_serie_screen.dart';

class PopularHomeScreen extends StatefulWidget {
  const PopularHomeScreen({super.key});

  @override
  State<PopularHomeScreen> createState() => _PopularHomeScreenState();
}

class _PopularHomeScreenState extends State<PopularHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Widget> _myTabViews = [];

  @override
  void initState() {
    super.initState();
    _myTabViews = [
      const PopularMovieScreen(),
      const PopularSerieScreen(),
      const CategoriesMediaScreen()
    ];

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TabBarItems(
            tabController: _tabController,
          ),
          Expanded(
            child: Center(
              child: TabBarView(
                controller: _tabController,
                children: _myTabViews,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
