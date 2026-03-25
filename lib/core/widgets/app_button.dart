import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class AppButton {
  static Widget primary({
    required String title,
    bool isExpand = false,
    Color? backgroundColor,
    Color? textColor,
    Object? heroTag,
    required void Function() onPressed
  }) {
    return SizedBox(
      width: isExpand ? double.infinity : null,
      child: FloatingActionButton.extended(
        hoverElevation: 0,
        highlightElevation: 0,
        heroTag: heroTag,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        extendedPadding: EdgeInsets.symmetric(
          horizontal: 20
        ),
        elevation: 0,
        onPressed: onPressed,
        label: Text(
          title,
          style: TextStyle(
            color: textColor
          ),
        ),
      ),
    );
  }

  static Widget text({
    Color? color,
    required String title,
    required void Function() onPressed
  }) {
    return TextButton(
      onPressed: onPressed, 
      child: Text(
        title,
        style: TextStyle(color: color),
      )
    );
  }

  static Widget google({
    required String title,
    required void Function() onPressed,
    Color? backgroundColor,
    Color? textColor,
    bool isExpand = false,
    Object? heroTag
  }) {
    return SizedBox(
      width: isExpand ? double.infinity : null,
      child: FloatingActionButton.extended(
        hoverElevation: 0,
        heroTag: heroTag,
        backgroundColor: backgroundColor ?? Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: Color(0xff747775)),
          borderRadius: BorderRadius.circular(4),
        ),
        extendedPadding: EdgeInsets.symmetric(
          horizontal: 20
        ),
        elevation: 0,
        highlightElevation: 0,
        onPressed: onPressed,
        label: Row(
          children: [
            SvgPicture.asset("assets/images/ic_google.svg"),
            const SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                color: textColor ?? Colors.black
              ),
            ),
          ],
        ),
      ),
    );
  }
}