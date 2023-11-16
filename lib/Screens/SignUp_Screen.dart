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

class SignUpScreen extends StatefulWidget {
  static const String routeName = "./SignUp";

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  TextEditingController _confirm_passwordcontroller = TextEditingController();

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
          "Sign Up",
          style: TextStyle(fontSize: 42.sp, fontWeight: FontWeight.w700),
        ),
        Text(
          "Get Started by creating your account",
          style: TextStyle(fontSize: 14.sp),
        ),
        Image.asset("assets/images/SignUp.png"),
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
                controller: _passwordcontroller,
                decoration: Custom_Decoration(hinttext: "Enter your Password"),
              ),
              SizedBox(
                height: 15.h,
              ),
              TextFormField(
                controller: _confirm_passwordcontroller,
                decoration:
                    Custom_Decoration(hinttext: "Confirm your Password"),
              ),
              _passwordcontroller.text != _confirm_passwordcontroller.text
                  ? Text("Password don't match")
                  : Text(""),
              SizedBox(
                height: 30.h,
              ),
              BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is LoggedInState) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, HomeScreen.routeName, (route) => false);
                      print("Logged In Succeessfully!");
                    }
                    else if(state is ErrorState){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error),),);
                    }
                  },
                  builder: (context, state) {
                    if(state is LoadingState){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return CustomButton(
                        name: "Continue",
                        ontap: () {
                          BlocProvider.of<AuthCubit>(context).signupwithLogin(
                              _emailcontroller.text,
                              _confirm_passwordcontroller.text);
                        });
                  }),
              SizedBox(
                height: 25.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already a User? ",
                      style:
                          TextStyle(color: Colors.grey.shade600, fontSize: 15)),
                  Text(
                    "Sign In",
                    style: TextStyle(
                        color: Color(0XFFAF795D),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
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
