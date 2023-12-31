import 'package:flutter/material.dart';

class Utils {
  double screenSafeAreaHeight(BuildContext context) {
    return MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
  }

  double screenSafeAreaWidth(BuildContext context) {
    return MediaQuery.of(context).size.width -
        MediaQuery.of(context).padding.left -
        MediaQuery.of(context).padding.right;
  }

  BorderRadius buildBorderRadius() {
    return const BorderRadius.all(Radius.circular(20));
  }

  String prepareLists(List<String> list) {
    String result = "";
    if (list.isNotEmpty) {
      for (var person in list) {
        result = "$result${person
                .toString()
                .split("/")[person.toString().split("/").length - 2]},";
      }
      result = result.substring(0, (result.length) - 1).replaceAll(",", "\n");
    } else {
      result = " - ";
    }
    return result;
  }

  // Future<Widget> getFilms(List<String> list) {
  //   String result = "";
  //   if (list.isNotEmpty) {
  //     for (var person in list) {
  //       result = "$result${person
  //           .toString()
  //           .split("/")[person.toString().split("/").length - 2]},";
  //     }
  //     result = result.substring(0, (result.length) - 1).replaceAll(",", "\n");
  //   } else {
  //     result = " - ";
  //   }
  //   return result;
  // }
}
