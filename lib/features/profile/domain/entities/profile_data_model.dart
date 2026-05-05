class ProfileDataModel {
  final String? message;
  final ProfileUserModel? user;
  final String? error;

  ProfileDataModel({this.message, this.user, this.error});
}

class ProfileUserModel {
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
  final bool? resetCodeVerified;

  ProfileUserModel({
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
    this.resetCodeVerified,
  });
}
