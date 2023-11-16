import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginhere/Cubits/auth_cubit/auth_cubit.dart';
import 'package:loginhere/Cubits/auth_cubit/auth_state.dart';
import 'package:loginhere/Layouts/Home_Layout.dart';
import 'package:loginhere/Screens/Login_Screen.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "./Home";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeLayout(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Welcome home!"),
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is LoggedOutState) {
                Navigator.popUntil(context, (route) => false);
                Navigator.pushNamed(context, LoginScreen.routeName);
              }
            },
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  BlocProvider.of<AuthCubit>(context).logout();
                },
                child: Text(
                  "LogOut",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
