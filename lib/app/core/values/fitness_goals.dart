import 'package:easy_localization/easy_localization.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';

class FitnessGoals {
  static const List<String> backendGoals = [
    'Gain weight',
    'Lose weight',
    'Get fitter',
    'Gain more flexibility',
    'Learn the basics',
  ];

  static const Map<String, String> _goalToKey = {
    'Gain weight': LocaleKeys.gainWeight,
    'Lose weight': LocaleKeys.loseWeight,
    'Get fitter': LocaleKeys.getFitter,
    'Gain more flexibility': LocaleKeys.gainMoreFlexibility,
    'Learn the basics': LocaleKeys.learnBasics,
  };

  static String getDisplayGoal(String? backendGoal) {
    if (backendGoal == null) return '--';
    final key = _goalToKey[backendGoal];
    return key != null ? key.tr() : backendGoal;
  }
}
