import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState{}

class InitialState extends AuthState{}

class LoadingState extends AuthState{}

class ErrorState extends AuthState{
  final String error;
  ErrorState({required this.error});
}

class CodeSentState extends AuthState{}

class CodeVerifiedState extends AuthState{}

class LoggedInState extends AuthState{
  final User firebaseUser;
  LoggedInState({required this.firebaseUser});
}

class LoggedOutState extends AuthState{}
