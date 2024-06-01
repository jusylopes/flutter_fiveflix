import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/screens/popular_screen/tab_bar_items.dart';
import 'package:flutter_fiveflix/screens/popular_screen/widgets/categories_media_screen.dart';
import 'package:flutter_fiveflix/screens/popular_screen/widgets/popular_media_screen.dart';
import 'package:flutter_fiveflix/screens/popular_screen/widgets/popular_serie_screen.dart';

class PopularMediaScreen extends StatefulWidget {
  const PopularMediaScreen({super.key});

  @override
  State<PopularMediaScreen> createState() => _PopularMediaScreenState();
}

class _PopularMediaScreenState extends State<PopularMediaScreen>
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
