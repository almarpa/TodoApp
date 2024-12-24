import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_app/app/domain/model/user_model.dart';

part 'sign_up_event.freezed.dart';

@freezed
class SignUpEvent with _$SignUpEvent {
  factory SignUpEvent.signUpRequired(UserModel user, String password) =
      SignUpRequired;
}
