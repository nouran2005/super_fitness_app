import 'package:equatable/equatable.dart';

class LoggedUserDataResponseEntity extends Equatable {
  final String? message;
  final LoggedUserEntity? user;

  const LoggedUserDataResponseEntity({this.message, this.user});

  @override
  List<Object?> get props => [message, user];
}

class LoggedUserEntity extends Equatable {
  final String? firstName;
  final String? lastName;
  final String? email;
  final int? weight;
  final String? activityLevel;
  final String? goal;
  final String? photo;

  const LoggedUserEntity({
    this.firstName,
    this.lastName,
    this.email,
    this.weight,
    this.activityLevel,
    this.goal,
    this.photo,
  });

  LoggedUserEntity copyWith({
    String? firstName,
    String? lastName,
    String? email,
    int? weight,
    String? activityLevel,
    String? goal,
    String? photo,
  }) {
    return LoggedUserEntity(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      weight: weight ?? this.weight,
      activityLevel: activityLevel ?? this.activityLevel,
      goal: goal ?? this.goal,
      photo: photo ?? this.photo,
    );
  }

  @override
  List<Object?> get props => [
    firstName,
    lastName,
    email,
    weight,
    activityLevel,
    goal,
    photo,
  ];
}
