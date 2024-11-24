import 'package:flutter/cupertino.dart';

class FormProvider extends ChangeNotifier {
  final GlobalKey<FormState> formKeys = GlobalKey<FormState>();
  final TextEditingController userOrEmailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController birthController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _obscureText = true;
  bool get obscureText => _obscureText;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setObscureText() {
    _obscureText = !_obscureText;
    notifyListeners();
  }
}
