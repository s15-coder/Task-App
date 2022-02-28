class ValidationsFields {
  ValidationsFields();
  //Returns
  String? _isValidName(String name) {
    if (name.isEmpty) return "Name must not be empty";
    if (name.length < 3) return "Name too short";
  }

  String? _isValidPassword(String password) {
    if (password.length < 7) return "Password too short";
  }

  String? _isValidEmail(Field field) {
    final regExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    bool valid = regExp.hasMatch(field.value!);
    if (!valid) return "${field.fieldName} is not a valid email";
  }

  String? validateFields(List<Field> fields) {
    for (var i = 0; i < fields.length; i++) {
      return _validateAccordType(fields[i]);
    }
  }

  String? _validateAccordType(Field field) {
    if (field.optional) {
      if (field.value == null || field.value!.isEmpty) {
        return null;
      }
    }
    if (field.value == null || field.value!.isEmpty) {
      return 'The field ${field.fieldName} is required.';
    }

    if (field.minLenght != null) {
      if (field.value!.length < field.minLenght!) {
        return '${field.fieldName} is too short';
      }
    }
    switch (field.typeField) {
      case TypeField.email:
        return _isValidEmail(field);
      case TypeField.name:
        return _isValidName(field.value!);
      case TypeField.password:
        return _isValidPassword(field.value!);
      case TypeField.none:
        break;
    }
  }
}

class Field {
  String? value;
  String fieldName;
  TypeField typeField;
  int? minLenght;
  bool optional;
  Field(
      {this.typeField = TypeField.none,
      required this.value,
      required this.fieldName,
      this.minLenght,
      this.optional = false});
}

enum TypeField { email, name, password, none }
