import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  Future<void> RegisterUser(
      {required String email, required String password}) async {
    emit(RegisterLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'weak-password') {
        emit(RegisterFailure(errormassage: 'weak password '));
      } else if (ex.code == 'email-already-in-use') {
        emit(RegisterFailure(errormassage: 'email-already-in-use'));
      }
    } on Exception catch (e) {
      emit(RegisterFailure(errormassage: "something went wrong "));
    }
  }
}
