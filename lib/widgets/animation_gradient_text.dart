import 'package:flutter/material.dart';

class AnimatedGradientText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration period;
  final int loop;
  final bool enabled;

  const AnimatedGradientText({
    super.key,
    required this.text,
    this.style,
    this.period = const Duration(milliseconds: 1500),
    this.loop = 0,
    this.enabled = true,
  });

  @override
  _AnimatedGradientTextState createState() => _AnimatedGradientTextState();
}

class _AnimatedGradientTextState extends State<AnimatedGradientText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _shimmerAnimation;
  int _count = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.period,
      vsync: this,
    );

    _shimmerAnimation = Tween<double>(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    _controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        _count++;
        if (widget.loop <= 0 || _count < widget.loop) {
          await Future.delayed(const Duration(seconds: 1));
          if (mounted) {
            _controller.reset();
            _controller.forward();
          }
        }
      }
    });

    if (widget.enabled) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shimmerAnimation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              begin: Alignment(_shimmerAnimation.value - 1, 0),
              end: Alignment(_shimmerAnimation.value + 1, 0),
              colors: const [
                Colors.grey,
                Colors.white,
                Colors.grey,
              ],
              stops: const [
                0.35, 0.5, 1.1
              ],
            ).createShader(bounds);
          },
          child: Text(
            widget.text,
            style: widget.style ??
                const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
          ),
        );
      },
    );
  }
}