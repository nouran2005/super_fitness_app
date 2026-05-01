import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/app/core/ui_helper/theme/app_theme.dart';

class TestAssetLoader extends AssetLoader {
  const TestAssetLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) async {
    return const {
      'heyThere': 'Hey There',
      'welcomeBack': 'WELCOME BACK',
      'login': 'Login',
      'email': 'Email',
      'password': 'Password',
      'forgotPassword': 'Forgot password',
      'signIn': 'Sign in',
      'dontHaveAccount': 'Dont have an account yet ?',
      'registerNow': 'Register',
      'work_outs': 'Workouts',
      'recommendationToDay': 'Recommendation To Day',
      'upcomingWorkouts': 'Upcoming Workouts',
      'recommendationForYou': 'Recommendation For You',
      'hi': 'Hi',
      'letsStartYourDay': "Let's Start Your Day",
      'category': 'Category',
      'gym': 'Gym',
      'fitness': 'Fitness',
      'yoga': 'Yoga',
      'aerobics': 'Aerobics',
      'trainer': 'Trainer',
      'seeAll': 'See All',
      'PopularsTraining': 'Popular Training',
      'Tasks': 'Tasks',
      'something_went_wrong': 'Something went wrong',
      'no_muscles_or_levels_available': 'No muscles or levels available.',
      'editProfile': 'Edit Profile',
      'saveChanges': 'Save Changes',
      'tapToEdit': 'Tap to edit',
      'yourWeight': 'Your Weight',
      'yourGoal': 'Your Goal',
      'yourActivityLevel': 'Your Activity Level',
      'retry': 'Retry',
      'somethingWentWrong': 'Something went wrong',
      'unsavedChanges': 'Unsaved Changes',
      'unsavedChangesMessage': 'You have unsaved changes.',
      'discard': 'Discard',
      'kg': 'kg',
      'userDataUpdatedSuccessfully': 'User data updated successfully',
      'firstName': 'First Name',
      'lastName': 'Last Name',
      'loseWeight': 'Lose weight',
      'gainWeight': 'Gain weight',
      'getFitter': 'Get fitter',
      'gainMoreFlexibility': 'Gain more flexibility',
      'learnBasics': 'Learn the basics',
      'rookie': 'Rookie',
      'beginner': 'Beginner',
      'intermediate': 'Intermediate',
      'advance': 'Advance',
      'trueBeast': 'True Beast',
    };
  }
}

extension PumpApp on WidgetTester {
  Future<void> pumpLocalizedWidget(
    Widget child, {
    bool withScaffold = true,
    bool settle = true,
  }) async {
    await pumpWidget(
      EasyLocalization(
        supportedLocales: const [Locale('en')],
        fallbackLocale: const Locale('en'),
        startLocale: const Locale('en'),
        saveLocale: false,
        path: 'unused',
        assetLoader: const TestAssetLoader(),
        child: Builder(
          builder: (context) {
            return MaterialApp(
              locale: context.locale,
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              theme: AppTheme.lightTheme,
              home: withScaffold ? Scaffold(body: child) : child,
            );
          },
        ),
      ),
    );

    if (settle) {
      await pumpAndSettle();
    } else {
      await pump();
    }
    if (settle) {
      await pumpAndSettle();
    } else {
      await pump();
    }
  }
}
