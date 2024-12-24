import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/app/data/repository/user_repository.dart';
import 'package:todo_app/app/presentation/screens/sign_in/bloc/sign_in_event.dart';
import 'package:todo_app/app/presentation/screens/sign_in/bloc/sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepository _userRepository;

  SignInBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(SignInInitial()) {
    on<SignInRequired>((event, emit) async {
      emit(SignInProcess());
      try {
        await _userRepository.signIn(event.email, event.password);
        bool isEmailVerified = await _userRepository.isUserEmailVerified();
        if (isEmailVerified) {
          emit(SignInSuccess());
        } else {
          emit(SignInSuccessWithoutVerification());
        }
      } on FirebaseAuthException catch (e) {
        emit(SignInFailure(message: e.code));
      } catch (e) {
        emit(SignInFailure());
      }
    });
    on<SignOutRequired>((event, emit) async {
      await _userRepository.logOut();
    });
  }
}
