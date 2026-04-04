abstract class RegisterIntent {}

class RegisterFormIntent extends RegisterIntent {
  String firstName;
  String lastName;
  String email;
  String password;

  RegisterFormIntent({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });
}
