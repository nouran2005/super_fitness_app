import 'package:equatable/equatable.dart';

class LoggedUserDataResponseEntity extends Equatable {
  final String? message;
  final LoggedUserEntity? user;

  const LoggedUserDataResponseEntity({this.message, this.user});

  @override
  List<Object?> get props => [message, user];
}

class LoggedUserEntity extends Equatable {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? gender;
  final int? age;
  final int? weight;
  final int? height;
  final String? activityLevel;
  final String? goal;
  final String? photo;
  final String? createdAt;
  final String? passwordChangedAt;
  final bool? resetCodeVerified;

  const LoggedUserEntity({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.age,
    this.weight,
    this.height,
    this.activityLevel,
    this.goal,
    this.photo,
    this.createdAt,
    this.passwordChangedAt,
    this.resetCodeVerified,
  });

  @override
  List<Object?> get props => [
    id,
    firstName,
    lastName,
    email,
    gender,
    age,
    weight,
    height,
    activityLevel,
    goal,
    photo,
    createdAt,
    passwordChangedAt,
    resetCodeVerified,
  ];
}
