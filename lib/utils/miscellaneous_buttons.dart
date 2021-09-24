import 'package:flutter/material.dart';

/// Home for any project specific buttons and widgets that may be needed
/// in more than one place in the codebase.
///
class SearchificationButtons {

  /// A generic button widget for the search provider logos.
  ///
  static Widget logoButton(string, onPressed, buttonColor, [isGoogle = false]) =>
      (isGoogle)
          ? ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.transparent),
                shadowColor:
                    MaterialStateProperty.all<Color>(Colors.transparent),
              ),
              onPressed: onPressed,
              child: Container(
                width: 70,
                height: 70,
                decoration: ShapeDecoration(shape: CircleBorder(), shadows: [
                  BoxShadow(
                    color: buttonColor,
                    blurRadius: 8.5,
                  ),
                ]),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    string,
                    width: 60,
                    height: 60,
                  ),
                ),
              ))
          : ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.transparent),
                shadowColor:
                    MaterialStateProperty.all<Color>(Colors.transparent),
              ),
              onPressed: onPressed,
              child: Container(
                width: 70,
                height: 70,
                decoration: ShapeDecoration(shape: CircleBorder(), shadows: [
                  BoxShadow(
                    color: buttonColor,
                    blurRadius: 8.5,
                  ),
                ]),
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Image.asset(
                    string,
                    width: 60,
                    height: 60,
                  ),
                ),
              ));
}
