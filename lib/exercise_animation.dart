import 'package:flutter/material.dart';

class ExerciseAnimation extends StatefulWidget {
  const ExerciseAnimation({super.key});

  @override
  State<ExerciseAnimation> createState() => _ExerciseAnimationState();
}

class _ExerciseAnimationState extends State<ExerciseAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _legAnimation;
  late final Animation<double> _armAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _legAnimation = Tween<double>(begin: 0, end: 45).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.5, curve: Curves.easeInOut),
      ),
    );

    _armAnimation = Tween<double>(begin: 0, end: -45).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
      ),
    );

    _controller.repeat(reverse: true); // 애니메이션을 반복 실행하고 역방향으로도 재생합니다.
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Running Animation'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, -_legAnimation.value),
              child: Container(
                width: 100,
                height: 200,
                color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Transform.rotate(
                      angle: _armAnimation.value * (3.14 / 180),
                      child: Container(
                        width: 20,
                        height: 80,
                        color: Colors.white,
                      ),
                    ),
                    Transform.rotate(
                      angle: -_armAnimation.value * (3.14 / 180),
                      child: Container(
                        width: 20,
                        height: 80,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
