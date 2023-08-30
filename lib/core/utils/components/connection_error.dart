import 'package:flutter/material.dart';
import 'package:sw_finder/core/config/app_colors.dart';

class ConnectionError extends StatelessWidget {
  const ConnectionError({
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
            Icons.wifi_off_outlined,
            color: errorColor,
            size: 250,
          ),
          Text(
            "Cannot Connect to \r\na Network",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text(
              "You must connect to a Wifi network \r\nto download the data from the internet",
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
