import 'package:flutter/material.dart';


class AppButton extends StatelessWidget{
  final Function onTap;
  final String caption;

  AppButton({
    @required this.caption,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(15.0))
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 4.0),
            child: Text(
                caption
            ),
          ),
        ),
      ),
    );
  }
}
