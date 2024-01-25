import 'package:flutter/material.dart';

import '../constants/colors.dart';

showSnackBar(String content, BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4).copyWith(bottom: 16),
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.startToEnd,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: colorPrimary,
      content: Row(
        children: [
          Flexible(
            child: Text(
              content,
              style: TextStyle(
                color: colorBlack,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.fade,
            ),
          )
        ],
      )));
}