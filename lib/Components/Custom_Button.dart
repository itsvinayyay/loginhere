import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


GestureDetector CustomButton({required String name, required VoidCallback ontap}){
  return GestureDetector(
    onTap: ontap,
    child: Container(
      alignment: Alignment.center,
      height: 50.h,
      decoration: BoxDecoration(
        color: Color(0XFFAF795D),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        name,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
    ),
  );
}