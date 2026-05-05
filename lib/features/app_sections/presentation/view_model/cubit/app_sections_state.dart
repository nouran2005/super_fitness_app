import 'package:equatable/equatable.dart';

class AppSectionsState extends Equatable {
  const AppSectionsState({this.currentIndex = 0});

  final int currentIndex;

  AppSectionsState copyWith({int? currentIndex}) {
    return AppSectionsState(currentIndex: currentIndex ?? this.currentIndex);
  }

  @override
  List<Object> get props => [currentIndex];
}
