class Validators {
  // Email validation
  static bool isValidEmail(String email) {
    final emailRegExp = RegExp(
        r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegExp.hasMatch(email);
  }

  // Password validation (at least 6 characters)
  static bool isValidPassword(String password) {
    return password.length >= 6;
  }

  // Name validation
  static bool isValidName(String name) {
    return name.trim().isNotEmpty && name.length >= 2;
  }

  // Department validation
  static bool isValidDepartment(String department) {
    return department.trim().isNotEmpty;
  }

  // Date of birth validation (must be at least 16 years old)
  static bool isValidDateOfBirth(DateTime dateOfBirth) {
    final now = DateTime.now();
    final difference = now.difference(dateOfBirth).inDays;
    final age = difference / 365;
    return age >= 16;
  }

  // Phone number validation
  static bool isValidPhoneNumber(String phoneNumber) {
    final phoneRegExp = RegExp(r'^\d{10}$');
    return phoneRegExp.hasMatch(phoneNumber);
  }

  // Student ID validation
  static bool isValidStudentId(String studentId) {
    return studentId.trim().isNotEmpty && studentId.length >= 5;
  }

  // Credit card validation
  static bool isValidCreditCard(String cardNumber) {
    // Remove any spaces or dashes
    final cleanNumber = cardNumber.replaceAll(RegExp(r'[\s-]'), '');

    // Check if the number contains only digits
    if (!RegExp(r'^\d+$').hasMatch(cleanNumber)) {
      return false;
    }

    // Check length (13-19 digits)
    if (cleanNumber.length < 13 || cleanNumber.length > 19) {
      return false;
    }

    // Luhn algorithm
    int sum = 0;
    bool alternate = false;
    for (int i = cleanNumber.length - 1; i >= 0; i--) {
      int n = int.parse(cleanNumber[i]);
      if (alternate) {
        n *= 2;
        if (n > 9) {
          n = (n % 10) + 1;
        }
      }
      sum += n;
      alternate = !alternate;
    }

    return sum % 10 == 0;
  }

  // Expiry date validation (MM/YY format)
  static bool isValidExpiryDate(String expiryDate) {
    if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(expiryDate)) {
      return false;
    }

    final parts = expiryDate.split('/');
    final month = int.tryParse(parts[0]);
    final year = int.tryParse(parts[1]);

    if (month == null || year == null) {
      return false;
    }

    if (month < 1 || month > 12) {
      return false;
    }

    final now = DateTime.now();
    final currentYear = now.year % 100;
    final currentMonth = now.month;

    if (year < currentYear) {
      return false;
    }

    if (year == currentYear && month < currentMonth) {
      return false;
    }

    return true;
  }

  // CVV validation
  static bool isValidCVV(String cvv) {
    return RegExp(r'^\d{3,4}$').hasMatch(cvv);
  }
}