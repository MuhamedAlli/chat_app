bool isEmailValid(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

bool isUsernameValid(String username) {
  return username.length >= 8;
}

bool isPhoneValid(String phone) {
  return phone.length >= 11;
}

bool isPasswordValid(String password) {
  return password.length >= 6;
}
