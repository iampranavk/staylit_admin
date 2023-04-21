import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  final Widget child;
  final Color? color;
  final Color hoverBorderColor;
  final double borderRadius;
  final Function()? onPressed;

  const CustomCard({
    super.key,
    required this.child,
    this.onPressed,
    this.color = Colors.white,
    this.borderRadius = 0,
    this.hoverBorderColor = Colors.blue,
  });

  @override
  CustomCardState createState() => CustomCardState();
}

class CustomCardState extends State<CustomCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onPressed,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: MouseRegion(
          onEnter: (event) => setState(() => _isHovering = true),
          onExit: (event) => setState(() => _isHovering = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              color: widget.color ?? Colors.blue[100],
              border: Border.all(
                width: 1,
                color:
                    _isHovering ? widget.hoverBorderColor : Colors.transparent,
              ),
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
