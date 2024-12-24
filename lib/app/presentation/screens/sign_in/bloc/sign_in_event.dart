import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_event.freezed.dart';

@freezed
class SignInEvent with _$SignInEvent {
  factory SignInEvent.signInRequired(String email, String password) =
      SignInRequired;
  factory SignInEvent.signOutRequired() = SignOutRequired;
}
