import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loginhere/Layouts/Splash_Layout.dart';
import 'package:loginhere/Screens/Login_Screen.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = "/Splash";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashLayout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30.h,
          ),
          Text(
            "Welcome!",
            style: TextStyle(fontSize: 42.sp, fontWeight: FontWeight.w700),
          ),
          Text(
            "Nice to see you again.",
            style: TextStyle(fontSize: 14.sp),
          ),
          Image.asset("assets/images/design.png"),
          SizedBox(
            height: 15.h,
          ),
          Text(
            "Saarte Apparels",
            style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            "Conveying excellence from the start along with an excitement at the same time.",
            style: TextStyle(fontSize: 16.sp),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, LoginScreen.routeName);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 130.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: Color(0XFFAF795D),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 130.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 40.h,),
        ],
      ),
    );
  }
}
