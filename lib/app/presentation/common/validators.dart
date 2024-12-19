class Validators {
  static String? emailValidator(String? value) {
    if (value!.isEmpty) {
      return 'El email es obligatorio';
    }
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value)) {
      return 'Porfavor introduce un email válido';
    }

    return null;
  }

  static String? passwordValidator(String? value) {
    if (value!.isEmpty) {
      return 'La contraseña es obligatoria';
    }
    if (!RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$')
        .hasMatch(value)) {
      return 'Porfavor introduce una contraseña válida';
    }

    return null;
  }

  static String? userNameValidator(String? value) {
    if (value!.isEmpty) {
      return 'El usuario es obligatorio';
    } else if (value.contains(' ')) {
      return 'El usuario no puede contener espacios';
    } else if (value.length > 30) {
      return 'El usuario es demasiado largo';
    }
    return null;
  }

  static String? birthValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Introduce tu fecha de nacimiento';
    }

    final dateRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
    if (!dateRegex.hasMatch(value)) {
      return 'Introduce una fecha válida en formato DD/MM/AAAA';
    }

    final parts = value.split('/');
    final day = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final year = int.tryParse(parts[2]);

    if (day == null || month == null || year == null) {
      return 'Introduce una fecha válida en formato DD/MM/AAAA';
    }

    if (day < 1 || day > 31) {
      return 'El día debe estar entre 1 y 31';
    }

    if (month < 1 || month > 12) {
      return 'El mes debe estar entre 1 y 12';
    }

    if (year < 1900 || year > DateTime.now().year) {
      return 'Introduce un año válido';
    }

    // must be legal age
    DateTime birthDate = DateTime(year, month, day);
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);

    if (birthDate.isAfter(today)) {
      return 'La fecha de nacimiento no puede ser posterior a la fecha actual';
    } else if (birthDate
        .isAfter(today.subtract(const Duration(days: 365 * 18)))) {
      return 'Debes ser mayor de edad para registrarte';
    }

    return null;
  }

  static bool containsSpecialCharacter(String val) =>
      RegExp(r'[!@#$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]').hasMatch(val);
  static bool containsUppercase(String val) => RegExp(r'[A-Z]').hasMatch(val);
  static bool containsLowercase(String val) => RegExp(r'[a-z]').hasMatch(val);
  static bool containsDigits(String val) => RegExp(r'[0-9]').hasMatch(val);
}
