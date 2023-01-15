/*
This file contains a list of all Regex Validations methods, to validate the input fields.
*/

String? isValidEmail(String string, String errorMessage) {
  final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
 return emailRegExp.hasMatch(string) ? null : errorMessage;
}
