import 'package:flutter/material.dart';

class FadeInUp extends StatefulWidget {
  final Widget child;
  final int delay;

  const FadeInUp({super.key, required this.child, this.delay = 0});

  @override
  State<FadeInUp> createState() => _FadeInUpState();
}

class _FadeInUpState extends State<FadeInUp>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacity;
  late Animation<double> translate;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    opacity = Tween(begin: 0.0, end: 1.0).animate(controller);
    translate = Tween(begin: 40.0, end: 0.0).animate(controller);

    Future.delayed(Duration(milliseconds: widget.delay), () {
      controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, child) {
        return Opacity(
          opacity: opacity.value,
          child: Transform.translate(
            offset: Offset(0, translate.value),
            child: widget.child,
          ),
        );
      },
    );
  }
}