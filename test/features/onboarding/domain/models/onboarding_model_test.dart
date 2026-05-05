import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/onboarding/domain/models/onboarding_model.dart';

void main() {
  group('OnboardingModel', () {
    test('should create instance with correct values', () {
      final model = OnboardingModel(
        title: 'Welcome to Super Fitness App',
        description: 'Get ready to achieve your fitness goals with us!',
        image: 'assets/images/onboarding1.png',
      );

      expect(model.title, 'Welcome to Super Fitness App');
      expect(model.description, model.description);
      expect(model.image, 'assets/images/onboarding1.png');
    });
  });
}
