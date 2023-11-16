import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loginhere/Components/Custom_Button.dart';
import 'package:loginhere/Components/TextFormField_Decoration.dart';
import 'package:loginhere/Cubits/auth_cubit/auth_cubit.dart';
import 'package:loginhere/Cubits/auth_cubit/auth_state.dart';
import 'package:loginhere/Layouts/Login_Layout.dart';
import 'package:flutter/services.dart';
import 'package:loginhere/Screens/Home_Screen.dart';
import 'package:loginhere/Screens/OTP_Screen.dart';
import 'package:loginhere/Screens/SignUp_Screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "./Login";

  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailcontroller = TextEditingController();

  TextEditingController _passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LoginLayout(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SizedBox(
        //   height: 1.h,
        // ),
        Text(
          "Sign In",
          style: TextStyle(fontSize: 42.sp, fontWeight: FontWeight.w700),
        ),
        Text(
          "Get Started by logging into your account",
          style: TextStyle(fontSize: 14.sp),
        ),
        Image.asset("assets/images/SignIn.png"),
        SizedBox(
          height: 15.h,
        ),
        Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailcontroller,
                decoration: Custom_Decoration(hinttext: "Enter your E-mail"),
              ),
              SizedBox(
                height: 15.h,
              ),
              TextFormField(
                obscureText: true,
                controller: _passwordcontroller,
                decoration: Custom_Decoration(hinttext: "Enter your Password"),
              ),
              Text("Error goes here..."),
              SizedBox(
                height: 30.h,
              ),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is LoggedInState) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, HomeScreen.routeName, (route) => false);
                  } else if (state is ErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is LoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return CustomButton(
                      name: "Continue",
                      ontap: () {
                        BlocProvider.of<AuthCubit>(context).signinwithlogin(
                            _emailcontroller.text, _passwordcontroller.text);
                      });
                },
              ),
              SizedBox(
                height: 25.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? ",
                      style:
                          TextStyle(color: Colors.grey.shade600, fontSize: 15)),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignUpScreen.routeName);
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Color(0XFFAF795D),
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25.h,
              ),
              Stack(
                children: [
                  Divider(
                    thickness: 1,
                    color: Colors.grey.shade600,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.white,
                      width: 120.w,
                      child: Text(
                        "Or Log-In with",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 15.sp),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, OTPScreen.routeName);
                    },
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/otp_icon.png"),
                      maxRadius: 30.sp,
                      minRadius: 30.sp,
                    ),
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/images/google.png"),
                    maxRadius: 30.sp,
                    minRadius: 30.sp,
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/images/facebook.png"),
                    maxRadius: 30.sp,
                    minRadius: 30.sp,
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/images/apple.png"),
                    maxRadius: 30.sp,
                    minRadius: 30.sp,
                  ),
                ],
              ),
              SizedBox(
                height: 25.h,
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
