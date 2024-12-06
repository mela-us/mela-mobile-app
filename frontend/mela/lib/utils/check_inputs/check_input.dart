class CheckInput {
  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Vui lòng nhập dữ liệu';
    }

    if (password.length < 8) {
      return 'Mật khẩu phải có ít nhất 8 kí tự';
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return 'Mật khẩu phải chứa ít nhất 1 chữ in hoa';
    }

    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return 'Mật khẩu phải chứa ít nhất 1 chữ thường';
    }

    if (!RegExp(r'\d').hasMatch(password)) {
      return 'Mật khẩu phải chứa ít nhất 1 chữ số';
    }

    if (!RegExp(r'[@$!%*?&]').hasMatch(password)) {
      return 'Mật khẩu phải chứa ít nhất 1 ký tự đặc biệt (@\$!%*?&)';
    }

    return null;
  }

  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Vui lòng nhập dữ liệu';
    }

    bool emailValid = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    ).hasMatch(email);

    if (!emailValid) {
      return 'Nhập địa chỉ email phù hợp';
    }

    return null;
  }
}
