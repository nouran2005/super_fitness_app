import 'package:easy_localization/easy_localization.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';

class ActivityLevels {
  static const List<String> backendLevels = [
    'level1',
    'level2',
    'level3',
    'level4',
    'level5',
  ];

  static const Map<String, String> _levelToKey = {
    'level1': LocaleKeys.rookie,
    'level2': LocaleKeys.beginner,
    'level3': LocaleKeys.intermediate,
    'level4': LocaleKeys.advance,
    'level5': LocaleKeys.trueBeast,
  };

  static String getDisplayLevel(String? backendLevel) {
    if (backendLevel == null) return '--';
    final key = _levelToKey[backendLevel];
    return key != null ? key.tr() : backendLevel;
  }
}
