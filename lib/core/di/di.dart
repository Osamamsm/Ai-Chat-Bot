import 'package:ai_chat_bot/core/services/api_client.dart';
import 'package:ai_chat_bot/core/services/gemini_message_service.dart';
import 'package:ai_chat_bot/data/repositories/gemini_message_repository.dart';
import 'package:ai_chat_bot/data/repositories/message_repository.dart';
import 'package:ai_chat_bot/logic/send_message_cubit/send_message_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<ApiClient>(
    () => ApiClient(dio: getIt<Dio>()),
  );
  getIt.registerLazySingleton<GeminiMessageService>(
    () => GeminiMessageService(
      apiClient: getIt<ApiClient>(),
      apiKey: dotenv.env['GEMINI_API_KEY'] ?? 'default_val',
    ),
  );
  getIt.registerLazySingleton<IMessageRepository>(
    () => GeminiMessageRepository(
      geminiService: getIt<GeminiMessageService>(),
    ),
  );
  getIt.registerFactory<SendMessageCubit>(
    () => SendMessageCubit(getIt<IMessageRepository>()),
  );
}
