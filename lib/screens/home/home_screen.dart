import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/blocs/blocs_exports.dart';
import 'package:flutter_fiveflix/models/widgets_keys.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';
import 'package:flutter_fiveflix/screens/screens_exports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _countBadge = 0;

  final List<Widget> _pages = [
    const PopularHomeScreen(),
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
    context.read<FavoriteBloc>().add(const FavoriteGetAllEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          FiveflixAssetsManager.imageLogo,
          width: 140,
        ),
        actions: [
          IconButton(
            key: Key(
              WidgetKeys.searchIcon.key,
            ),
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: Image.asset(
                FiveflixAssetsManager.profile,
                height: 30,
              ),
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
          BottomNavigationBarItem(
            key: Key(WidgetKeys.gamesScreenIcon.key),
            icon: const Icon(Icons.sports_esports),
            label: 'Games',
          ),
          BottomNavigationBarItem(
            key: Key(WidgetKeys.newsScreenIcon.key),
            icon: const Icon(Icons.home_max),
            label: 'News',
          ),
          BottomNavigationBarItem(
            key: Key(WidgetKeys.favoritesScreenIcon.key),
            icon: Badge(
              backgroundColor: FiveflixColors.primaryColor,
              label: BlocBuilder<FavoriteBloc, FavoriteState>(
                builder: (context, state) {
                  state is FavoriteGetAllSuccessState
                      ? _countBadge = state.items.length
                      : '';
                  return Text(
                    key: Key(WidgetKeys.favoriteCountBadge.key),
                    '$_countBadge',
                  );
                },
              ),
              child: const Icon(Icons.favorite),
            ),
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
