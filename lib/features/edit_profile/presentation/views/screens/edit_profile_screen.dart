import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/app/core/ui_helper/assets/app_images.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/view_model/edit_profile_cubit.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/view_model/edit_profile_events.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/view_model/edit_profile_state.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/views/screens/activity_edit_screen.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/views/screens/goal_edit_screen.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/views/screens/weight_edit_screen.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/views/widgets/edit_profile_body.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/views/widgets/success_snack_bar.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/views/widgets/unsaved_changes_dialog.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _populatingControllers = false;
  bool _controllersPopulated = false;
  bool _wasSaving = false;
  late final EditProfileCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<EditProfileCubit>()
      ..onEvent(GetLoggedUserDataProcessEvent());

    _firstNameController.addListener(_onTextChanged);
    _lastNameController.addListener(_onTextChanged);
    _emailController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _cubit.close();
    super.dispose();
  }

  void _onTextChanged() {
    if (_populatingControllers) return;
    final isValid = _formKey.currentState?.validate() ?? false;
    _cubit.onEvent(
      UpdateLocalFieldEvent(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        isFormValid: isValid,
      ),
    );
  }

  void _onStateChanged(BuildContext context, EditProfileState state) {
    if (state.getLoggedUserData.isSuccess &&
        state.updatedUser != null &&
        !_controllersPopulated) {
      _populatingControllers = true;
      _firstNameController.text = state.updatedUser!.firstName ?? '';
      _lastNameController.text = state.updatedUser!.lastName ?? '';
      _emailController.text = state.updatedUser!.email ?? '';
      _populatingControllers = false;
      _controllersPopulated = true;
    }

    if (mounted) {
      if (_wasSaving && !state.isSavingData) {
        if (state.saveError == null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(buildSuccessSnackBar(context));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.saveError!),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      }
    }

    _wasSaving = state.isSavingData;
  }

  Future<void> _openWeightSheet() async {
    final result = await Navigator.of(context).push<int>(
      MaterialPageRoute(
        builder: (_) => WeightEditScreen(
          initialWeight: _cubit.state.updatedUser?.weight ?? 70,
        ),
      ),
    );
    if (result != null) {
      _cubit.onEvent(UpdateLocalFieldEvent(weight: result));
      _revalidateForm();
    }
  }

  Future<void> _openGoalSheet() async {
    final result = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (_) =>
            GoalEditScreen(selectedGoal: _cubit.state.updatedUser?.goal ?? ''),
      ),
    );
    if (result != null) {
      _cubit.onEvent(UpdateLocalFieldEvent(goal: result));
      _revalidateForm();
    }
  }

  Future<void> _openActivitySheet() async {
    final result = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (_) => ActivityEditScreen(
          selectedActivity: _cubit.state.updatedUser?.activityLevel ?? '',
        ),
      ),
    );
    if (result != null) {
      _cubit.onEvent(UpdateLocalFieldEvent(activityLevel: result));
      _revalidateForm();
    }
  }

  void _revalidateForm() {
    final isValid = _formKey.currentState?.validate() ?? false;
    _cubit.onEvent(
      UpdateLocalFieldEvent(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        isFormValid: isValid,
      ),
    );
  }

  bool get _hasUnsavedChanges =>
      _cubit.state.originalUser != _cubit.state.updatedUser;

  Future<bool> _onWillPop() async {
    if (!_hasUnsavedChanges) return true;
    await _showUnsavedDialog();
    return false;
  }

  Future<void> _showUnsavedDialog() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => BlocProvider.value(
        value: _cubit,
        child: UnsavedChangesDialog(
          onDiscard: () {
            Navigator.of(dialogContext).pop();
            context.pop();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider<EditProfileCubit>.value(
      value: _cubit,
      child: BlocConsumer<EditProfileCubit, EditProfileState>(
        listener: _onStateChanged,
        builder: (context, state) => PopScope(
          canPop: !_hasUnsavedChanges,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop) _showUnsavedDialog();
          },
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.imagesExerciseBackground),
                fit: BoxFit.cover,
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                surfaceTintColor: Colors.transparent,
                leading: InkWell(
                  onTap: () async {
                    final router = GoRouter.of(context);
                    final canPop = await _onWillPop();
                    if (canPop && mounted) router.pop();
                  },
                  child: Image.asset(Assets.imagesArrowBack),
                ),
                title: Text(
                  LocaleKeys.editProfile.tr(),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              body: EditProfileBody(
                state: state,
                size: size,
                horizontalPadding: size.width * 0.06,
                formKey: _formKey,
                firstNameController: _firstNameController,
                lastNameController: _lastNameController,
                emailController: _emailController,
                openWeightSheet: _openWeightSheet,
                openGoalSheet: _openGoalSheet,
                openActivitySheet: _openActivitySheet,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
