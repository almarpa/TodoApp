import 'dart:io';

abstract class RegisterRepository {
  Future<void> registerUser({
    required String username,
    required String email,
    required String password,
    required String birth,
    required String age,
    required String createdAt,
    required File? image,
    required Function() onSuccess,
    required Function(String) onError,
  });

  Future<bool> userExists(String username);

  Future<bool> emailExists(String email);

  Future<String> uploadImage(String ref, File file);
}
