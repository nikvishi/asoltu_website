import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Subtle continuous float — disabled under test binding (no pending timers).
class FloatingSoftMotion extends StatefulWidget {
  const FloatingSoftMotion({
    super.key,
    required this.child,
    this.amplitude = 8,
    this.duration = const Duration(milliseconds: 2800),
  });

  final Widget child;
  final double amplitude;
  final Duration duration;

  @override
  State<FloatingSoftMotion> createState() => _FloatingSoftMotionState();
}

class _FloatingSoftMotionState extends State<FloatingSoftMotion>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  late final bool _enableMotion;

  @override
  void initState() {
    super.initState();
    // AutomatedTestWidgetsFlutterBinding leaves timers pending if we loop forever.
    final isTest = SchedulerBinding.instance.runtimeType
        .toString()
        .contains('TestWidgetsFlutterBinding');
    _enableMotion = !isTest;
    if (_enableMotion) {
      _controller = AnimationController(vsync: this, duration: widget.duration)
        ..repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = _controller;
    if (c == null) return widget.child;
    return AnimatedBuilder(
      animation: c,
      builder: (context, child) {
        final dy = (c.value * 2 - 1) * widget.amplitude;
        return Transform.translate(offset: Offset(0, dy), child: child);
      },
      child: widget.child,
    );
  }
}
