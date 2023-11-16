import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loginhere/Components/Custom_Button.dart';
import 'package:loginhere/Components/TextFormField_Decoration.dart';
import 'package:loginhere/Cubits/auth_cubit/auth_cubit.dart';
import 'package:loginhere/Cubits/auth_cubit/auth_state.dart';
import 'package:loginhere/Layouts/Login_Layout.dart';
import 'package:loginhere/Screens/OTPVerfiy_Screen.dart';


class OTPScreen extends StatefulWidget {
  static const String routeName = "/OTP";
  OTPScreen({Key? key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController _phonecontroller = TextEditingController.fromValue(TextEditingValue(text: '', selection: TextSelection.collapsed(offset: 0)));

  @override
  Widget build(BuildContext context) {
    return LoginLayout(child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SizedBox(
        //   height: 1.h,
        // ),
        Text(
          "Enter Mobile",
          style: TextStyle(fontSize: 42.sp, fontWeight: FontWeight.w700),
        ),
        Text(
          "Get Started by entering your mobile number to get an OTP",
          style: TextStyle(fontSize: 14.sp),
        ),
        Hero(tag: "OTPScreen",
        child: Image.asset("assets/images/OTP.png")),
        SizedBox(
          height: 15.h,
        ),
        Text("OTP will be sent to the number provided below!", style: TextStyle(fontSize: 15.sp,),),
        SizedBox(
          height: 5.h,
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          controller: _phonecontroller,
          decoration: Custom_Decoration(hinttext: "Please Enter Mobile No."),
          onFieldSubmitted: (v){
            _phonecontroller.text = v;
          },
        ),
        SizedBox(
          height: 5.h,
        ),
        Text("Error goes here...", style: TextStyle(fontSize: 15.sp,),),
        SizedBox(
          height: 25.h,
        ),
        BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state){
            if(state is CodeSentState){
              Navigator.pushNamed(context, OTPVerificationScreen.routeName);
            }
          },
          builder: (context, state){
            if(state is LoadingState){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return CustomButton(name: "Continue", ontap: (){
              String phoneNumber = "+91" + _phonecontroller.text;
              BlocProvider.of<AuthCubit>(context).sendOTP(phoneNumber);
            });
          },
        ),
      ],
    ),);
  }
}
