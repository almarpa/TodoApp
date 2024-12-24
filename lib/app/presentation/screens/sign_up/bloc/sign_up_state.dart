import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_state.freezed.dart';

@freezed
class SignUpState with _$SignUpState {
  factory SignUpState.initial() = SignUpInitial;
  factory SignUpState.success() = SignUpSuccess;
  factory SignUpState.failure({String? message}) = SignUpFailure;
  factory SignUpState.process() = SignUpProcess;
}
