import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/edit_profile/domain/repos/edit_profile_repo.dart';
import 'package:super_fitness_app/features/edit_profile/domain/usecases/upload_profile_image_usecase.dart';

import 'upload_profile_image_usecase_test.mocks.dart';

@GenerateMocks([EditProfileRepo])
void main() {
  late MockEditProfileRepo mockRepo;
  late UploadProfileImageUseCase useCase;

  setUp(() {
    mockRepo = MockEditProfileRepo();
    useCase = UploadProfileImageUseCase(mockRepo);
  });

  setUpAll(() {
    provideDummy<ApiResult<String>>(SuccessApiResult<String>(data: ''));
  });

  group('UploadProfileImageUseCase Tests', () {
    final fakeFile = File('fake_path.jpg');

    test('should return success when upload succeeds', () async {
      when(mockRepo.uploadImage(fakeFile)).thenAnswer(
        (_) async =>
            SuccessApiResult<String>(data: "https://image-url.com/photo.jpg"),
      );

      final result = await useCase.uploadImage(fakeFile);

      expect(result, isA<SuccessApiResult<String>>());
      expect(
        (result as SuccessApiResult).data,
        "https://image-url.com/photo.jpg",
      );

      verify(mockRepo.uploadImage(fakeFile)).called(1);
      verifyNoMoreInteractions(mockRepo);
    });

    test('should return error when upload fails', () async {
      when(
        mockRepo.uploadImage(fakeFile),
      ).thenAnswer((_) async => ErrorApiResult<String>(error: "upload failed"));

      final result = await useCase.uploadImage(fakeFile);

      expect(result, isA<ErrorApiResult<String>>());
      expect((result as ErrorApiResult).error, "upload failed");

      verify(mockRepo.uploadImage(fakeFile)).called(1);
    });
  });
}
