import 'package:bloc/bloc.dart';
import 'package:super_fitness_app/features/app_sections/presentation/view_model/cubit/app_sections_state.dart';

class AppSectionsCubit extends Cubit<AppSectionsState> {
  AppSectionsCubit() : super(const AppSectionsState());

  void changePage(int currentPage) {
    if (currentPage == state.currentIndex) {
      return;
    }
    emit(state.copyWith(currentIndex: currentPage));
  }
}
