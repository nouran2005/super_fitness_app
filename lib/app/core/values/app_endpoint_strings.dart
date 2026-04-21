class AppEndpoints {
  static const String baseUrl = 'https://fitness.elevateegy.com/api/v1/';
  static const String mealsBaseUrl = 'www.themealdb.com/api/json/v1/1/';

  // SHARED PATHS
  static const String authPath = 'auth';
  // AUTH PATHS
  static const String signInPath = 'signin';
  static const String signupPath = 'auth/signup';
  static const String changePasswordPath = 'change-password';
  static const String verifyResetCodePath = 'auth/verifyResetCode';
  static const String resetPasswordPath = 'auth/resetPassword';
  static const String forgotPasswordPath = 'auth/forgotPassword';

  // MEALS PATHS
  static const String mealsCategoryPath = 'categories.php';
}
