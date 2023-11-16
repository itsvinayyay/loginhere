import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loginhere/Components/Custom_Button.dart';
import 'package:loginhere/Cubits/auth_cubit/auth_cubit.dart';
import 'package:loginhere/Cubits/auth_cubit/auth_state.dart';
import 'package:loginhere/Layouts/Login_Layout.dart';
import 'package:loginhere/Screens/Home_Screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPVerificationScreen extends StatefulWidget {
  static const String routeName = "/OTPVerification";

  OTPVerificationScreen({Key? key}) : super(key: key);

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  TextEditingController _otpcontroller = TextEditingController();

  String phoneOTP = "";

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
          "Enter OTP",
          style: TextStyle(fontSize: 42.sp, fontWeight: FontWeight.w700),
        ),
        Text(
          "Enter the OTP sent to your Mobile number",
          style: TextStyle(fontSize: 14.sp),
        ),
        Hero(tag: "OTPScreen", child: Image.asset("assets/images/OTP.png")),
        SizedBox(
          height: 15.h,
        ),
        PinCodeTextField(
          controller: _otpcontroller,
          keyboardType: TextInputType.number,
          appContext: context,
          length: 6,
          obscureText: false,
          animationType: AnimationType.fade,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            inactiveColor: Color(0XFFAF795D),
            selectedColor: Colors.green,
            inactiveFillColor: Colors.white,
            selectedFillColor: Colors.white,
            activeBorderWidth: 3,
            selectedBorderWidth: 5,
            inactiveBorderWidth: 3,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 50,
            fieldWidth: 40,
            activeFillColor: Colors.white,
          ),
          animationDuration: Duration(milliseconds: 300),
          backgroundColor: Colors.transparent,
          enableActiveFill: true,
          onChanged: (v){
            setState(() {
              phoneOTP = v;
            });
          },
          onCompleted: (v) {},
        ),
        SizedBox(
          height: 25.h,
        ),
        BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
          if (state is LoggedInState) {
            Navigator.pushNamedAndRemoveUntil(
                context, HomeScreen.routeName, (route) => route.isFirst);
            print("Logged In Succeessfully!");
          }
          else if(state is ErrorState){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error),),);
          }
        }, builder: (context, state) {
          if (state is LoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          return CustomButton(
              name: "Verify",
              ontap: () {
                print("Clicked Verify!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                if(_otpcontroller.text == null){
                  print("The value is null aborting!!!!!!!!!!!!!!!!!!!!!");
                }
                print(_otpcontroller.text);
                print(phoneOTP);
                if(phoneOTP != ""){
                  print("Calling Bloc here!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                  BlocProvider.of<AuthCubit>(context).verifyOTP(phoneOTP);
                }
              });
        })
      ],
    ));
  }
}
