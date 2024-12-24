import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/app/data/repository/user_repository.dart';
import 'package:todo_app/app/domain/model/user_model.dart';
import 'package:todo_app/app/presentation/screens/sign_up/bloc/sign_up_event.dart';
import 'package:todo_app/app/presentation/screens/sign_up/bloc/sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository _userRepository;

  SignUpBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(SignUpInitial()) {
    on<SignUpRequired>((event, emit) async {
      emit(SignUpProcess());
      try {
        UserModel user =
            await _userRepository.signUp(event.user, event.password);
        await _userRepository.setUserData(user);
        emit(SignUpSuccess());
      } on FirebaseAuthException catch (e) {
        emit(SignUpFailure(message: e.code));
      } catch (e) {
        emit(SignUpFailure());
      }
    });
  }
}
