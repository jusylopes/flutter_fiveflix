import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/screens/screens_exports.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: Image.asset(
          FiveflixAssetsManager.imageLogo,
          width: 140,
        ),
      ),
      actions: [
        IconButton(
          icon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(
              Icons.search,
              size: 40,
            ),
          ),
          onPressed: () {
            showSearch(
              context: context,
              delegate: SearchScreen(),
            );
          },
        ),
      ],
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
