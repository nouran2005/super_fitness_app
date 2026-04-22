class AppEndpoints {
  static const String baseUrl = 'https://fitness.elevateegy.com/api/v1/';
  // SHARED PATHS
  static const String authPath = 'auth';
  // AUTH PATHS
  static const String signInPath = 'signin';
  static const String signupPath = 'auth/signup';
  static const String changePasswordPath = 'change-password';
  static const String verifyResetCodePath = 'auth/verifyResetCode';
  static const String resetPasswordPath = 'auth/resetPassword';
  static const String forgotPasswordPath = 'auth/forgotPassword';
  static const String musclesRandomPath = 'muscles/random';
  static const String levelsPath = 'levels';
  static const String exercisesByMuscleDifficulty =
      "exercises/by-muscle-difficulty";
}
