import 'package:flutter/material.dart';
import 'package:sw_finder/core/config/app_colors.dart';

class UnknownError extends StatelessWidget {
  const UnknownError({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.thumb_down_alt,
            color: errorColor,
            size: 250,
          ),
          Text(
            "Data Download Error",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text(
              "An unknown error has ocurred",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          )
        ],
      ),
    );
  }
}
