import 'package:flutter/material.dart';


InputDecoration Custom_Decoration({required String hinttext}){
  return InputDecoration(
    // border: OutlineInputBorder(
    //   borderSide: BorderSide(color: Color(0XFFAF795D), width: 3),
    //   borderRadius: BorderRadius.circular(10),
    // ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0XFFAF795D), width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
    // disabledBorder: OutlineInputBorder(
    //   borderSide: BorderSide(color: Color(0XFFAF795D), width: 3),
    //   borderRadius: BorderRadius.circular(10),
    // ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.brown, width: 2),
      borderRadius: BorderRadius.circular(10),
    ),
    hintText: hinttext,
    hintStyle: TextStyle(
      color: Color(0XFFAF795D),
    ),
  );
}