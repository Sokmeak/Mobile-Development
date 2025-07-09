// utils/validators.dart
class Validators {
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters long';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }

    final phoneRegex = RegExp(r'^\d{8,15}$');
    if (!phoneRegex.hasMatch(value.trim())) {
      return 'Phone number must contain only digits and be 8-15 characters long';
    }
    return null;
  }

  static String? validateClassName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Class name is required';
    }
    return null;
  }

  static String? validateDepartment(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Department is required';
    }
    return null;
  }

  static String? validateGender(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Gender is required';
    }
    return null;
  }
}