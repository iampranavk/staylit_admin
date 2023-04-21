import 'package:flutter/material.dart';

class CustomActionButton extends StatelessWidget {
  final IconData? iconData;
  final String label;
  final Color color;
  final Function() onPressed;
  final bool isLoading;
  final MainAxisSize mainAxisSize;
  const CustomActionButton({
    super.key,
    this.iconData,
    this.color = Colors.blue,
    required this.onPressed,
    required this.label,
    this.isLoading = false,
    this.mainAxisSize = MainAxisSize.max,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withOpacity(.1),
      borderRadius: BorderRadius.circular(0),
      child: InkWell(
        onTap: onPressed,
        hoverColor: color.withOpacity(.15),
        focusColor: color.withOpacity(.15),
        highlightColor: color.withOpacity(.15),
        splashColor: color.withOpacity(.2),
        borderRadius: BorderRadius.circular(0),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
            bottom: 10,
          ),
          child: isLoading
              ? SizedBox(
                  width: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: LinearProgressIndicator(
                      color: color,
                      backgroundColor: color.withOpacity(.2),
                    ),
                  ),
                )
              : Row(
                  mainAxisSize: mainAxisSize,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      label,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: color,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(width: iconData != null ? 5 : 0),
                    iconData != null
                        ? Icon(
                            iconData,
                            color: color,
                            size: 16,
                          )
                        : const SizedBox(),
                  ],
                ),
        ),
      ),
    );
  }
}
