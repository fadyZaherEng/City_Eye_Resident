import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/extensions/color_extension.dart';
import 'package:city_eye/src/domain/entities/support/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StepCircleWidget extends StatefulWidget {
  final Status status;

  const StepCircleWidget({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  State<StepCircleWidget> createState() => _StepCircleWidgetState();
}

class _StepCircleWidgetState extends State<StepCircleWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _animation = Tween<double>(begin: 0.4, end: 1.0).animate(_controller);

    _controller.forward();
  }

  @override
  void deactivate() {
    _controller.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
              width: 32,
              height: 32,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: widget.status.colorCode.toColor(),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.network(
                widget.status.logo,
              ),
          ),
          Positioned(
            bottom: -20,
            child: Text(
              widget.status.name,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: widget.status.colorCode.toColor(),
                  ),
            ),
          ),
        ],
      ),
    );
  }

  String _stepIcon(Status status) {
    if (status.captionStatusCode == "completed") {
      return ImagePaths.approved;
    } else if (status.captionStatusCode == "prograss") {
      return ImagePaths.loading;
    } else if (status.captionStatusCode == "pending") {
      return ImagePaths.completeStatus;
    } else if (status.captionStatusCode == "cancelled") {
      return ImagePaths.close;
    } else {
      return "";
    }
  }

  Widget _getStatusIcon(Status status) {
    if (status.isCompleted) {
      return SvgPicture.asset(
        ImagePaths.approved,
      );
    } else {
      return status.logo.isNotEmpty
          ? SvgPicture.network(
              status.logo,
            )
          : SvgPicture.asset(
              ImagePaths.frame,
            );
    }
  }

  Color _getStatusColor(Status status) {
    if (status.isCompleted && status.captionStatusCode != "cancelled") {
      return ColorSchemes.green;
    } else {
      return status.colorCode.toColor();
    }
  }
}
