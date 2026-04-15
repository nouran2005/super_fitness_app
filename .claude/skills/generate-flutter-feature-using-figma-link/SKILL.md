---
name: generate-flutter-feature-using-figma-link
description: >
  Generate a complete Flutter feature from a Figma link, following the project's Clean Architecture structure.
  Trigger this skill when the user provides:
    - A Figma link alone → generate the presentation layer only (UI + Cubit)
    - A Figma link + API endpoint + model → generate the full feature (data + presentation layers)
  Also trigger when the user says "generate a feature", "scaffold a feature", "build this screen with data",
  or any combination of a Figma design reference and backend integration details.
  Always follow the project's exact folder structure, naming conventions, and coding patterns from CLAUDE.md.
---

# Generate Flutter Feature from Figma

Scaffold a production-ready Flutter feature from a Figma design, following the project's Clean Architecture (data / presentation) and BLoC/Cubit state management patterns.

---

## Step 0 — Identify the Mode

Read what the user has provided and choose the correct mode:

| Provided | Mode |
|---|---|
| Figma link only | **UI-only** — generate `presentation/` layer only |
| Figma link + endpoint + model | **Full feature** — generate `data/` + `presentation/` layers |

If the mode is ambiguous, ask the user before proceeding.

---

## Step 1 — Read the Figma Design

Call `get_design_context` with the `fileKey` and `nodeId` extracted from the Figma URL:
- `figma.com/design/:fileKey/...?node-id=:nodeId` → replace `-` with `:` in nodeId

Extract from the design:
- Screen layout and widget tree
- Colors, typography, spacing, border radii
- Interactive elements and their states (loading, empty, error, success)
- Any list/grid structures that imply pagination

Map all colors to `ColorConstants.*`, text styles to `Styles.bold/medium/regular(context, size)`, and spacing to `.w`/`.h` via `flutter_screenutil`.

---

## Step 2 — Plan the File Structure

Determine `{feature_name}` in snake_case from the screen name or user input.

### UI-only mode
```
lib/features/{feature_name}/
└── presentation/
    ├── view/
    │   ├── pages/
    │   │   └── {feature_name}_view.dart
    │   └── widgets/
    │       └── {widget_name}.dart
    └── view_model/
        └── cubit/
            ├── {feature_name}_cubit.dart
            └── {feature_name}_state.dart
```

### Full feature mode
```
lib/features/{feature_name}/
├── data/
│   ├── datasource/
│   │   └── {feature_name}_remote_data_source.dart
│   ├── models/
│   │   └── {model_name}_model.dart
│   └── repo/
│       └── {feature_name}_repo_impl.dart
├── domain/
│   └── repo/
│       └── {feature_name}_repo.dart
└── presentation/
    ├── view/
    │   ├── pages/
    │   │   └── {feature_name}_view.dart
    │   └── widgets/
    │       └── {widget_name}.dart
    └── view_model/
        └── cubit/
            ├── {feature_name}_cubit.dart
            └── {feature_name}_state.dart
```

---

## Step 3 — Generate the Data Layer (Full feature mode only)

### 3.1 Model

Use `json_serializable` if the project already uses it; otherwise write `fromJson`/`toJson` manually.

```dart
class {ModelName}Model {
  final Type field;
  // ...

  const {ModelName}Model({required this.field});

  factory {ModelName}Model.fromJson(Map<String, dynamic> json) => {ModelName}Model(
    field: json['field'],
  );

  // Implement getDummyData() for skeleton loading
  factory {ModelName}Model.getDummyData() => {ModelName}Model(
    field: /* plausible placeholder */,
  );
}
```

Always implement `getDummyData()` — it is used by the Cubit for skeleton loading states.

### 3.2 Remote Data Source

```dart
abstract class {FeatureName}RemoteDataSource {
  Future<ApiResponse<{ModelName}Model>> get{FeatureName}();
}

class {FeatureName}RemoteDataSourceImpl implements {FeatureName}RemoteDataSource {
  final DioClient _dioClient;
  {FeatureName}RemoteDataSourceImpl(this._dioClient);

  @override
  Future<ApiResponse<{ModelName}Model>> get{FeatureName}() async {
    final response = await _dioClient.get(Endpoints.{endpointConstant});
    return ApiResponse.fromJson(response.data, (json) => {ModelName}Model.fromJson(json));
  }
}
```

Add the endpoint constant to `lib/core/helpers/network/endpoints.dart`:
```dart
static const String {endpointConstant} = '{endpoint_path}';
```

### 3.3 Domain Repo Interface

```dart
abstract class {FeatureName}Repo {
  Future<Either<String, {ModelName}Model>> get{FeatureName}();
}
```

### 3.4 Repo Implementation

```dart
class {FeatureName}RepoImpl implements {FeatureName}Repo {
  final {FeatureName}RemoteDataSource _dataSource;
  {FeatureName}RepoImpl(this._dataSource);

  @override
  Future<Either<String, {ModelName}Model>> get{FeatureName}() =>
      executApi<{ModelName}Model>(
        apiCall: () => _dataSource.get{FeatureName}(),
        fromJson: (json) => {ModelName}Model.fromJson(json as Map<String, dynamic>),
      );
}
```

### 3.5 Dependency Injection

Create `lib/core/di/{feature_name}/register_{feature_name}.dart`:

```dart
void register{FeatureName}(GetIt getIt) {
  getIt
    ..registerFactory<{FeatureName}RemoteDataSource>(
      () => {FeatureName}RemoteDataSourceImpl(getIt<DioClient>()),
    )
    ..registerFactory<{FeatureName}Repo>(
      () => {FeatureName}RepoImpl(getIt<{FeatureName}RemoteDataSource>()),
    )
    ..registerFactory(
      () => {FeatureName}Cubit(getIt<{FeatureName}Repo>()),
    );
}
```

Remind the user to call `register{FeatureName}(getIt)` in `lib/core/di/service_locator.dart`.

---

## Step 4 — Generate the Presentation Layer

### 4.1 State

States use `BaseLoadableResponse<T>` fields with `copyWith`. Follow the project pattern exactly.

```dart
part of '{feature_name}_cubit.dart';

class {FeatureName}State {
  final BaseLoadableResponse<{ModelName}Model> {featureName}Response;

  const {FeatureName}State({
    this.{featureName}Response = const BaseLoadableResponse(),
  });

  {FeatureName}State copyWith({
    BaseLoadableResponse<{ModelName}Model>? {featureName}Response,
  }) =>
      {FeatureName}State(
        {featureName}Response: {featureName}Response ?? this.{featureName}Response,
      );
}
```

For UI-only mode, keep state minimal — only the fields the UI needs.

### 4.2 Cubit

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{app_package}/shared/base_loadable_response/data/base_loadable_response.dart';
// ...

part '{feature_name}_state.dart';

class {FeatureName}Cubit extends Cubit<{FeatureName}State> {
  final {FeatureName}Repo _repo;

  {FeatureName}Cubit(this._repo) : super(const {FeatureName}State()) {
    get{FeatureName}();
  }

  Future<void> get{FeatureName}() async {
    emit(state.copyWith(
      {featureName}Response: state.{featureName}Response.copyWith(
        isLoading: true,
        clearError: true,
        data: {ModelName}Model.getDummyData(),
      ),
    ));

    final result = await _repo.get{FeatureName}();
    result.fold(
      (error) => emit(state.copyWith(
        {featureName}Response: state.{featureName}Response.copyWith(
          isLoading: false,
          error: error,
        ),
      )),
      (data) => emit(state.copyWith(
        {featureName}Response: state.{featureName}Response.copyWith(
          isLoading: false,
          data: data,
        ),
      )),
    );
  }
}
```

For UI-only mode, omit the repo dependency and data-fetching logic.

### 4.3 View

The Cubit is provided in `app_routes.dart` via `BlocProvider`, NOT inside the view itself. The view file only wraps the scaffold and body:

```dart
class {FeatureName}View extends StatelessWidget {
  const {FeatureName}View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar if the design shows one
      body: BlocBuilder<{FeatureName}Cubit, {FeatureName}State>(
        builder: (context, state) {
          return CustomSkeltonizerWidget(
            isLoading: state.{featureName}Response.isLoading,
            child: // ... build UI from state.{featureName}Response.data
          );
        },
      ),
    );
  }
}
```

Remind the user to add the route and `BlocProvider` in `lib/core/utils/routes/app_routes.dart`.

### 4.4 Widgets

Extract every logically self-contained piece of UI into `view/widgets/`. Rules:
- Accept data via constructor parameters — never access the Cubit directly from leaf widgets
- Use `const` constructors wherever possible
- Use `ColorConstants.*`, `Styles.*`, `.w`/`.h`/`.sp`/`.r`, `LocaleKeys.*` for all values
- Wrap repeated sections in `CustomSkeltonizerWidget` when they display loadable data

---

## Step 5 — Localization

For every user-facing string in the UI:
1. Add the key to all translation files: `assets/translations/ar.json`, `en.json`, `fr.json`, `hi.json`, `tl.json`
2. Regenerate locale keys:
   ```
   flutter pub run easy_localization:generate -S assets/translations -O lib/core/utils/languages
   ```
3. Use `LocaleKeys.{key}.tr()` in the widget — never hardcode strings

---

## Step 6 — Present the Output

1. Create all files in the correct paths
2. List every generated file with a one-line description
3. State clearly what the user still needs to do manually:
   - Register DI in `service_locator.dart`
   - Add route + `BlocProvider` in `app_routes.dart`
   - Add endpoint constant to `endpoints.dart` (if not already added)
   - Run `build_runner` if code generation is needed
   - Declare any new asset paths in `pubspec.yaml`

---

## Edge Cases

- **Pagination**: If the design shows a list, check if `PaginatedCubit` applies — extend it and implement `fetchPage(int page)` instead of a one-shot fetch
- **Forms / input fields**: Add a `GlobalKey<FormState>` and `TextEditingController`s to the Cubit, not the widget
- **Multiple endpoints**: Create one method per endpoint in the data source and repo; compose in the Cubit
- **No model provided**: Infer the model fields from the Figma design and ask the user to confirm before generating
- **Existing feature**: Read existing files before generating to avoid overwriting or duplicating code
