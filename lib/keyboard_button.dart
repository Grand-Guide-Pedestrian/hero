import 'package:flutter/material.dart';

class KeyboardButton extends StatelessWidget {
  const KeyboardButton(
    this.name, {
    this.pressed = false,
    Key? key,
    this.left,
    this.top,
    this.right,
    this.bottom,
  })  : assert(left == null || right == null),
        assert(top == null || bottom == null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: pressed ? Colors.black : Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Center(
          child: Text(
            name,
            style: Theme.of(context).textTheme.headline3?.copyWith(
                  color: pressed ? Colors.blue : Colors.black,
                  backgroundColor: Colors.transparent,
                ),
          ),
        ),
      ),
      left: left,
      top: top,
      right: right,
      bottom: bottom,
    );
  }

  final String name;
  final bool pressed;
  final double? left;
  final double? top;
  final double? right;
  final double? bottom;
}
