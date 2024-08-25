import 'dart:math';
import 'package:flutter/material.dart';

/// A custom circular progress indicator with a dashed unfilled portion.
///
/// This widget creates a circular progress indicator that fills clockwise,
/// with the unfilled portion represented by a dashed line. The colors for
/// both the filled and unfilled portions are customizable.
class CustomCircularProgressIndicator extends StatefulWidget {
  /// The current progress value, from 0.0 to 1.0.
  final double progress;

  /// The color of the filled portion of the progress indicator.
  final Color filledColor;

  /// The color of the unfilled (dashed) portion of the progress indicator.
  final Color unfilledColor;

  /// The width of the progress indicator's stroke.
  final double strokeWidth;

  /// The overall size of the progress indicator.
  final double size;

  /// Creates a [CustomCircularProgressIndicator].
  ///
  /// [progress] must be between 0.0 and 1.0.
  const CustomCircularProgressIndicator({
    super.key,
    required this.progress,
    required this.filledColor,
    required this.unfilledColor,
    this.strokeWidth = 10.0,
    this.size = 100.0,
  }) : assert(progress >= 0.0 && progress <= 1.0);

  @override
  State<CustomCircularProgressIndicator> createState() =>
      _CustomCircularProgressIndicatorState();
}

class _CustomCircularProgressIndicatorState
    extends State<CustomCircularProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _progressAnimation = Tween<double>(begin: 0, end: widget.progress)
        .animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    _animationController.forward();
  }

  @override
  void didUpdateWidget(CustomCircularProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress != widget.progress) {
      _progressAnimation = Tween<double>(
        begin: _progressAnimation.value,
        end: widget.progress,
      ).animate(_animationController);
      _animationController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: CustomPaint(
        painter: _CircularProgressPainter(
          progress: _progressAnimation.value,
          filledColor: widget.filledColor,
          unfilledColor: widget.unfilledColor,
          strokeWidth: widget.strokeWidth,
        ),
      ),
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final double progress;
  final Color filledColor;
  final Color unfilledColor;
  final double strokeWidth;

  _CircularProgressPainter({
    required this.progress,
    required this.filledColor,
    required this.unfilledColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Draw unfilled dashed arc
    final unfilledPaint = Paint()
      ..color = unfilledColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    const dashLength = 5;
    const dashSpace = 3;
    double startAngle = -pi / 2;
    final sweepAngle = 2 * pi * (1 - progress);
    while (startAngle < -pi / 2 + sweepAngle) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        dashLength / radius,
        false,
        unfilledPaint,
      );
      startAngle += (dashLength + dashSpace) / radius;
    }

    // Draw filled arc
    final filledPaint = Paint()
      ..color = filledColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      filledPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}