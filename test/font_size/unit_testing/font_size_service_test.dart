import 'package:flutter_test/flutter_test.dart';
import 'package:luciapp/features/auth/domain/enums/gender.dart';
import 'package:luciapp/features/auth/domain/models/user.dart';
import 'package:luciapp/features/font_size/application/font_size_service.dart';
import 'package:luciapp/features/font_size/domain/models/user_font_settings.dart';
import 'package:luciapp/features/font_size/presentation/state/font_size_state.dart';
import 'package:mocktail/mocktail.dart';
import '../../common/mocks/mock_auth_repository.dart';
import '../mocks/mock_font_settings_repository.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late MockFontSettingsRepository mockFontSettingsRepository;
  late FontSizeService service;
  late User user;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockFontSettingsRepository = MockFontSettingsRepository();
    service = FontSizeService(
      fontSettingsRepository: mockFontSettingsRepository,
      authRepository: mockAuthRepository,
    );
    user = User(
      userId: '1234',
      age: 21,
      gender: Gender.male,
      name: 'Carlos',
    );
  });

  group("Unit testing", () {
    test("getcurrent for not authenticated", () async {
      when(() => mockAuthRepository.userId).thenAnswer((_) => null);

      final result = await service.getCurrentFontSizeState();

      expect(result, const FontSizeState.initial());
    });
    test("getcurrent for authenticated", () async {
      when(() => mockAuthRepository.userId).thenAnswer((_) => user.userId);

      final existingSettings = UserFontSettings(scaleFactor: 2, userId: '1234');

      when(() => mockFontSettingsRepository.get(user.userId)).thenAnswer(
        (invocation) => Future.value(existingSettings),
      );

      final result = await service.getCurrentFontSizeState();

      expect(result, FontSizeState.fromUserFontSettings(existingSettings));
    });
    test("increse when it can increase", () async {
      when(() => mockAuthRepository.userId).thenAnswer((_) => user.userId);
      final existingSettings =
          UserFontSettings(scaleFactor: 1.9, userId: '1234');

      when(() => mockFontSettingsRepository.get(user.userId)).thenAnswer(
        (invocation) => Future.value(existingSettings),
      );

      final increased = existingSettings.copyWithScaleFactor(2);

      when(() => mockFontSettingsRepository.update(increased))
          .thenAnswer((invocation) => Future.value(true));

      final result = await service.increaseFontSize();

      expect(result, FontSizeState.fromUserFontSettings(increased));
    });
    test("increse when it can't increase", () async {
      when(() => mockAuthRepository.userId).thenAnswer((_) => user.userId);
      final existingSettings = UserFontSettings(scaleFactor: 2, userId: '1234');

      when(() => mockFontSettingsRepository.get(user.userId)).thenAnswer(
        (invocation) => Future.value(existingSettings),
      );

      final result = await service.increaseFontSize();

      expect(result, FontSizeState.fromUserFontSettings(existingSettings));
    });
    test("decrease when it can decrease", () async {
      when(() => mockAuthRepository.userId).thenAnswer((_) => user.userId);
      final existingSettings =
          UserFontSettings(scaleFactor: 1.8, userId: '1234');

      when(() => mockFontSettingsRepository.get(user.userId)).thenAnswer(
        (invocation) => Future.value(existingSettings),
      );

      final decreased = existingSettings.copyWithScaleFactor(1.7);

      when(() => mockFontSettingsRepository.update(decreased))
          .thenAnswer((invocation) => Future.value(true));

      final result = await service.decreaseFontSize();

      expect(result, FontSizeState.fromUserFontSettings(decreased));
    });
    test("decrease when it can't decrease", () async {
      when(() => mockAuthRepository.userId).thenAnswer((_) => user.userId);
      final existingSettings =
          UserFontSettings(scaleFactor: .8, userId: '1234');

      when(() => mockFontSettingsRepository.get(user.userId)).thenAnswer(
        (invocation) => Future.value(existingSettings),
      );

      final result = await service.decreaseFontSize();

      expect(result, FontSizeState.fromUserFontSettings(existingSettings));
    });
    test("get existing from database", () async {
      final existingSettings =
          UserFontSettings(scaleFactor: .8, userId: '1234');

      when(() => mockFontSettingsRepository.get(user.userId)).thenAnswer(
        (invocation) => Future.value(existingSettings),
      );

      final result = await service.getOrCreateUserFontSettings(user.userId);

      expect(result, existingSettings);
    });
    test("create new in database", () async {
      when(() => mockFontSettingsRepository.get(user.userId)).thenAnswer(
        (invocation) => Future.value(null),
      );

      when(() => mockFontSettingsRepository.get(user.userId)).thenAnswer(
        (invocation) => Future.value(UserFontSettings.initial(user.userId)),
      );

      final result = await service.getOrCreateUserFontSettings(user.userId);

      expect(result, UserFontSettings.initial(user.userId));
    });
  });
}
