import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/utils/fiveflix_colors.dart';

class TransparentGradientContainer extends StatelessWidget {
  final Widget child;
  final double height;

  const TransparentGradientContainer({
    super.key,
    required this.child,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: double.infinity,
          height: height + 1.2,
          foregroundDecoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                FiveflixColors.backgroundColor,
                Colors.transparent,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.center,
              stops: [0, 0.5],
            ),
          ),
          child: Container(
            color: FiveflixColors.backgroundColor,
            child: child,
          ),
        ),
      ],
    );
  }
}
