import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fiveflix/blocs/news_screen/news_bloc.dart';
import 'package:flutter_fiveflix/screens/favorite/favorite_screen.dart';
import 'package:flutter_fiveflix/screens/game/game_home_screen.dart';
import 'package:flutter_fiveflix/screens/news/news_screen.dart';
import 'package:flutter_fiveflix/screens/popular_media/popular_media_screen.dart';
import 'package:flutter_fiveflix/screens/search/search_screen.dart';
import 'package:flutter_fiveflix/utils/assets_manager.dart';
import 'package:flutter_fiveflix/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _countBadge = 0;

  final List<Widget> _pages = [
    const PopularMediaScreen(),
    const GameHomeScreen(),
    const NewsScreen(),
    const FavoriteScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<NewsBloc>().add(NewsMediaFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          AssetsManager.imageLogo,
          width: 140,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchScreen(),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 20,
            ),
            child: Image.asset(
              AssetsManager.profile,
              height: 30,
            ),
          ),
        ],
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.sports_esports),
            label: 'Games',
          ),
          BottomNavigationBarItem(
            icon: Badge(
              backgroundColor: AppColors.primaryColor,
              label: BlocBuilder<NewsBloc, NewsState>(
                builder: (context, state) {
                  state is NewsSuccessState
                      ? _countBadge = state.newsMovies.length
                      : '';
                  return Text(
                    '$_countBadge',
                  );
                },
              ),
              child: const Icon(Icons.home_max),
            ),
            label: 'News',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
