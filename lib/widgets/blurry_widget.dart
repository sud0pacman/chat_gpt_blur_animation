import 'dart:ui';
import 'package:flutter/material.dart';

class BlurryWidget extends StatefulWidget {
  final String imgAsset;
  final double initialWidth;
  final double initialHeight;

  const BlurryWidget({
    super.key,
    required this.initialWidth,
    required this.initialHeight,
    required this.imgAsset,
  });

  @override
  _BlurryWidgetState createState() => _BlurryWidgetState();
}

class _BlurryWidgetState extends State<BlurryWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _heightAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );


    _heightAnimation = Tween<double>(
      begin: widget.initialHeight,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // start animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.initialWidth,
      height: widget.initialHeight,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            Image.asset(
              widget.imgAsset,
              width: widget.initialWidth,
              height: widget.initialHeight,
              fit: BoxFit.cover,
            ),

            // Blurred Overlay
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      // Clips the blurred content to the container's bounds, ensuring the blur effect disappears when height reaches 0
                      return ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7), // Blur effect
                          child: Container(
                            width: widget.initialWidth,
                            height: _heightAnimation.value,
                            color: Colors.white.withValues(alpha: 0.2),
                            alignment: Alignment.center,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}