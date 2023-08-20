import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../helper/show_snack_bar.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  Future<void> loginUser(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'user-not-found') {
        emit(LoginFailure(errormassage: 'user not found'));
      } else if (ex.code == 'wrong-password') {
        emit(LoginFailure(errormassage: 'wrong password'));
      }
    } on Exception catch (e) {
      emit(LoginFailure(errormassage: "something went wrong "));
    }
  }
}
