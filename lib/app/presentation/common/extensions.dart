import 'package:firebase_auth/firebase_auth.dart';

extension FirebaseUserExtensions on User {
  bool get isVerified => email != null && emailVerified;
}
