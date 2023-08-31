import 'package:flutter/material.dart';


class RoundedButton extends StatelessWidget {
  const RoundedButton({required this.onpressed, required this.color, required this.title,});
  final Color color;
  final String title;
  final void Function()? onpressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: onpressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
          ),
        ),
      ),
    );
  }
}