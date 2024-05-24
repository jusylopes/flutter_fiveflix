import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/utils/fiveflix_assets_manager.dart';

class CustomSymbolApp extends StatelessWidget {
  const CustomSymbolApp({
    super.key,
    required this.symbolHeight,
  });

  final double symbolHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Image.asset(
        FiveflixAssetsManager.imageSymbol,
        height: symbolHeight,
      ),
    );
  }
}
