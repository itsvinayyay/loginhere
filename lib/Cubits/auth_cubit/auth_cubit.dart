import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginhere/Cubits/auth_cubit/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationID;

  AuthCubit() : super(InitialState()) {

      User? currentuser = _auth.currentUser;

      if (currentuser != null) {
        emit(LoggedInState(firebaseUser: currentuser));
      } else {
        emit(LoggedOutState());
      }

  }

  void sendOTP(String PhoneNumber) async {
    emit(LoadingState());
    await _auth.verifyPhoneNumber(
        phoneNumber: PhoneNumber,
        codeSent: (VerificationId, forceResendingToken) {
          print("code Sent!!!!!!!!!!!!!!!!!!!!");
          print(VerificationId);
          _verificationID = VerificationId;
          print(_verificationID);
          emit(CodeSentState());
        },
        verificationCompleted: (phoneAuthCredential) {
          signinwithPhone(phoneAuthCredential);
        },
        verificationFailed: (error) {
          emit(ErrorState(error: error.message.toString()));
        },
        codeAutoRetrievalTimeout: (verificationId) {
          _verificationID = verificationId;
        });
  }

  void verifyOTP(String otp) async {
    print("Reached VerifyOTP(1)!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    emit(LoadingState());
    if (_verificationID == null) {
      await Future.delayed(Duration(seconds: 1));
      if (_verificationID == null) {
        // If _verificationID is still null, show an error or take appropriate action
        print(
            "Error: Verification ID is null. OTP verification cannot proceed.");
        return;
      }
    }
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationID!, smsCode: otp);
    print("Reached VerifyOTP(2)!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    signinwithPhone(credential);
  }

  void signinwithPhone(PhoneAuthCredential phoneAuthCredential) async {
    try {
      print("Reached (try)signinwithphone!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      UserCredential userCredential =
      await _auth.signInWithCredential(phoneAuthCredential);
      if (userCredential.user != null) {
        emit(LoggedInState(firebaseUser: userCredential.user!));
      }
    } on FirebaseAuthException catch (exception) {
      print("Reached (catch)signinwithphone!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      emit(ErrorState(error: exception.message.toString()));
    }
  }

  void signupwithLogin(String Email, String Password) async {
    emit(LoadingState());
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: Email, password: Password);
      if (credential.user != null) {
        emit(LoggedInState(firebaseUser: credential.user!));
      }
    } on FirebaseAuthException catch(exception){
      emit(ErrorState(error: exception.message.toString()));
    }
  }

  void signinwithlogin(String Email, String Password) async {
    emit(LoadingState());
    try{
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: Email, password: Password);
      if(credential.user != null){
        emit(LoggedInState(firebaseUser: credential.user!));
      }
    } on FirebaseAuthException catch (exception){
      emit(ErrorState(error: exception.message.toString()));
    }
  }

  void logout() async {
    await _auth.signOut();
    emit(LoggedOutState());
  }
}
