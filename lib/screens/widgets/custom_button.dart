import 'package:flutter/material.dart';
import 'package:staylit_admin/screens/widgets/custom_card.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Function() onTap;
  final IconData? icon;
  final Color? buttonColor, iconColor, labelColor, hoverBorderColor;
  final double elevation;
  final bool isLoading;
  const CustomButton({
    Key? key,
    required this.label,
    required this.onTap,
    this.icon,
    this.buttonColor,
    this.iconColor,
    this.labelColor,
    this.elevation = 0,
    this.isLoading = false,
    this.hoverBorderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color: buttonColor ?? Colors.blue[50],
      hoverBorderColor: hoverBorderColor ?? Colors.blue,
      child: InkWell(
        onTap: isLoading ? null : onTap,
        borderRadius: BorderRadius.circular(0),
        child: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: icon != null ? 10 : 20,
            top: 12.5,
            bottom: 12.5,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: icon != null
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.center,
            children: isLoading
                ? [
                    Transform.scale(
                      scale: 0.7,
                      child: CircularProgressIndicator(
                        color: labelColor,
                        backgroundColor: labelColor?.withOpacity(.2),
                      ),
                    ),
                    // SizedBox(
                    //   width: 50,
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(30),
                    //     child: Center(
                    //       child: CircularProgressIndicator(
                    //         color: labelColor,
                    //         backgroundColor: labelColor?.withOpacity(.2),
                    //       ),
                    //     ),
                    //   ),
                    // )
                  ]
                : [
                    Text(
                      label,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: labelColor,
                          ),
                    ),
                    SizedBox(
                      width: icon != null ? 5 : 0,
                    ),
                    icon != null
                        ? Icon(
                            icon!,
                            color: iconColor,
                            size: 20,
                          )
                        : const SizedBox()
                  ],
          ),
        ),
      ),
    );
  }
}
