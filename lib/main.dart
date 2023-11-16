import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loginhere/Cubits/auth_cubit/auth_cubit.dart';
import 'package:loginhere/Cubits/auth_cubit/auth_state.dart';
import 'package:loginhere/Screens/Home_Screen.dart';
import 'package:loginhere/Screens/Login_Screen.dart';
import 'package:loginhere/Screens/OTPVerfiy_Screen.dart';
import 'package:loginhere/Screens/OTP_Screen.dart';
import 'package:loginhere/Screens/SignUp_Screen.dart';
import 'package:loginhere/Screens/Splash_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider(
          create: (context) => AuthCubit(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Color(0XFFFFFFFF),
              textTheme: const TextTheme(
                bodyLarge:
                    TextStyle(color: Color(0XFFAF795D), fontFamily: "Inter"),
                bodyMedium:
                    TextStyle(color: Color(0XFFAF795D), fontFamily: "Inter"),
              ),
            ),
            home: BlocBuilder<AuthCubit, AuthState>(
              buildWhen: (oldState, newState){
                return oldState is InitialState;
              },
              builder: (context, state){
                if(state is LoggedInState){
                  return HomeScreen();
                }
                else if(state is LoggedOutState){
                  return SplashScreen();
                }
                else{
                  return SplashScreen();
                }
              },
            ),
            routes: {
              SplashScreen.routeName: (context) => SplashScreen(),
              LoginScreen.routeName: (context) => LoginScreen(),
              OTPScreen.routeName: (context) => OTPScreen(),
              OTPVerificationScreen.routeName: (context) =>
                  OTPVerificationScreen(),
              HomeScreen.routeName: (context) => HomeScreen(),
              SignUpScreen.routeName: (context) => SignUpScreen(),
            },
          ),
        );
      },
    ),
  );
}

// String InitialRoute(){
//   BlocBuilder<AuthCubit, AuthState>(
//     builder: (context, state){
//       if(state is LoggedInState){
//         return HomeScreen.routeName;
//       }
//       else if(state is LoggedOutState){
//         return LoginScreen.routeName;
//       }
//       else{
//         return SplashScreen.routeName;
//       }
//     },
//   );
// }
