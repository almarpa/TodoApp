class Validators {
  static String? emailValidator(String? value) {
    if (value!.isEmpty) {
      return 'El email es requerido';
    }
    if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
      return 'Porfavor ingrese un email valido';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value!.isEmpty) {
      return 'La contraseña es requerida';
    }
    if (value.length < 6) {
      return 'La contraseña debe tener al menos 4 caracteres';
    }
    return null;
  }

  static String? emailOrUser(String? value) {
    if (value!.isEmpty) {
      return 'El email o usuario es requerido';
    }

    if (value.contains(' ')) {
      return 'El email o usuario no puede contener espacios';
    }

    return null;
  }

  static String? validateUsername(String? value) {
    if (value!.isEmpty) {
      return 'El usuario es requerido';
    }
    if (value.contains(' ')) {
      return 'El usuario no puede contener espacios';
    }
    return null;
  }

  static String? birthValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Ingrese tu fecha de nacimiento';
    }

    final dateRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
    if (!dateRegex.hasMatch(value)) {
      return 'Ingrese una fecha válida en formato DD/MM/AAAA';
    }

    final parts = value.split('/');
    final day = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final year = int.tryParse(parts[2]);

    if (day == null || month == null || year == null) {
      return 'Ingrese una fecha válida en formato DD/MM/AAAA';
    }

    if (day < 1 || day > 31) {
      return 'El día debe estar entre 1 y 31';
    }

    if (month < 1 || month > 12) {
      return 'El mes debe estar entre 1 y 12';
    }

    if (year < 1900 || year > DateTime.now().year) {
      return 'Ingrese un año válido';
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
}
