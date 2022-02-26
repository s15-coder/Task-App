class Validations {
  Validations() {}
  //Returns
  String? _isValidName(String name) {
    if (name.isEmpty) return "Name must not be empty";
    if (name.length < 3) return "Name too short";
  }

  String? _isValidPassword(String password) {
    if (password.length < 8) return "Password too short";
  }

  String? _isValidEmail(String email) {
    if (!email.contains("@")) return "Insert a valid email";
  }

  String? validateFields(List<Field> fields) {
    String? textError;
    for (var i = 0; i < fields.length; i++) {
      textError = _validateAccordType(fields[i]);
      if (textError != null) break;
    }
    return textError;
  }

  String? _validateAccordType(Field field) {
    switch (field.typeField) {
      case TypeField.email:
        return _isValidEmail(field.value);
      case TypeField.name:
        return _isValidName(field.value);
      case TypeField.password:
        return _isValidPassword(field.value);
    }
  }
}

class Field {
  String value;
  TypeField typeField;
  Field({required this.typeField, required this.value});
}

enum TypeField { email, name, password }
