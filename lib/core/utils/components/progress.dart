import 'package:flutter/material.dart';
import 'package:sw_finder/core/config/app_colors.dart';

class Progress extends StatelessWidget {

  const Progress({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(
            color: primaryColor,
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              'Loading ...',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
