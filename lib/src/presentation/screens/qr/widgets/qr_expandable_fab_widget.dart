import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/domain/entities/sign_in/user_unit_parent.dart';
import 'package:city_eye/src/presentation/widgets/circular_icon.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_svg/flutter_svg.dart';

class QrExpandableFabWidget extends StatefulWidget {
  final List<Widget> children;
  final UserUnitParent selectedType;
  bool open;
  bool showFloatingButton;
  final AnimationController? controller;

  QrExpandableFabWidget(
      {Key? key,
      required this.children,
      required this.selectedType,
      required this.open,
      required this.showFloatingButton,
      required this.controller})
      : super(key: key);

  @override
  QrExpandableFabWidgetState createState() => QrExpandableFabWidgetState();
}

class QrExpandableFabWidgetState extends State<QrExpandableFabWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();

    _expandAnimation = CurvedAnimation(
        parent: widget.controller!,
        curve: Curves.fastOutSlowIn,
        reverseCurve: Curves.easeOutQuad);
  }

  void _toggle() {
    setState(() {
      widget.open = !widget.open;
      if (widget.open) {
        widget.controller!.forward();
      } else {
        widget.controller!.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.showFloatingButton,
      child: SizedBox.expand(
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            _tapToClose(),
            ..._buildExpandableFabButton(),
            _tapToOpen(),
          ],
        ),
      ),
    );
  }

  Widget _tapToClose() {
    print("_tapToClose ${widget.open}");
    return Visibility(
      visible: widget.open,
      child: InkWell(
        onTap: _toggle,
        child: const CircularIcon(
          iconSize: 24,
          backgroundColor: ColorSchemes.white,
          borderColor: ColorSchemes.border,
          boxShadows: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 32,
              color: Color.fromRGBO(34, 34, 34, 0.32),
              spreadRadius: 0,
            ),
          ],
          imagePath: ImagePaths.fabClose,
          borderWidth: 1,
          iconColor: ColorSchemes.black,
        ),
      ),
    );
  }

  Widget _tapToOpen() {
    print("_tapToOpen ${widget.open}");

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      transformAlignment: Alignment.center,
      transform: Matrix4.diagonal3Values(
          widget.open ? 0.7 : 1.0, widget.open ? 0.7 : 1.0, 1.0),
      curve: Curves.easeOut,
      child: AnimatedOpacity(
        opacity: widget.open ? 0.0 : 1.0,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 250),
        child: InkWell(
            onTap: _toggle,
            child: Container(
                height: 36,
                width: 120,
                decoration: BoxDecoration(
                  color: ColorSchemes.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: ColorSchemes.border,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 32,
                      color: Color.fromRGBO(34, 34, 34, 0.32),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      ImagePaths.locations,
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "${widget.selectedType.id}",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: ColorSchemes.black),
                    ),
                    const SizedBox(width: 12),
                  ],
                ))),
      ),
    );
  }

  List<Widget> _buildExpandableFabButton() {
    final List<Widget> children = <Widget>[];
    final count = widget.children.length;

    for (var i = 0, angleInDegrees = 60.0;
        i < count;
        i++, angleInDegrees += 60) {
      children.add(_ExpandableFab(
        directionDegrees: 90,
        maxDistance: angleInDegrees,
        progress: _expandAnimation,
        child: widget.children[i],
      ));
    }

    return children;
  }
}

class _ExpandableFab extends StatelessWidget {
  const _ExpandableFab(
      {Key? key,
      required this.directionDegrees,
      required this.maxDistance,
      required this.progress,
      required this.child})
      : super(key: key);

  final double directionDegrees;
  final double maxDistance;
  final Animation<double>? progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress!,
      builder: (context, child) {
        final offset = Offset.fromDirection(
            directionDegrees * (math.pi / 180), progress!.value * maxDistance);
        return Positioned.directional(
          end: offset.dx,
          bottom: 4.0 + offset.dy,
          textDirection: Directionality.of(context),
          child: Transform.rotate(
            angle: 0,
            child: child,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress!,
        child: child,
      ),
    );
  }
}
