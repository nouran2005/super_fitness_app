sealed class SignupIntent {}

class SetBasicInfo extends SignupIntent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String rePassword;

  SetBasicInfo({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.rePassword,
  });
}

class SetGender extends SignupIntent {
  final String gender;
  SetGender(this.gender);
}

class SetAge extends SignupIntent {
  final int age;
  SetAge(this.age);
}

class SetWeight extends SignupIntent {
  final int weight;
  SetWeight(this.weight);
}

class SetHeight extends SignupIntent {
  final int height;
  SetHeight(this.height);
}

class SetGoal extends SignupIntent {
  final String goal;
  SetGoal(this.goal);
}

class SetActivityLevel extends SignupIntent {
  final String activityLevel;
  SetActivityLevel(this.activityLevel);
}

class MoveToPreviousStep extends SignupIntent {
  MoveToPreviousStep();
}

class MoveToNextStep extends SignupIntent {
  MoveToNextStep();
}
