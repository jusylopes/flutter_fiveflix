import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

class FiveflixAnimatedIcon extends StatefulWidget {
  const FiveflixAnimatedIcon({
    super.key,
    required this.sizeIcon,
  });

  final double sizeIcon;

  @override
  State<FiveflixAnimatedIcon> createState() => _FiveflixAnimatedIconState();
}

class _FiveflixAnimatedIconState extends State<FiveflixAnimatedIcon>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _animation = Tween<Offset>(
      begin: const Offset(0, -0.3),
      end: const Offset(0, -0.5),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: widget.sizeIcon,
        child: SlideTransition(
          position: _animation,
          child: Image.asset(FiveflixAssetsManager.imageSymbol),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
