import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../utils/constants.dart';

part 'secure_storage_provider.g.dart';

@riverpod
FlutterSecureStorage secureStorage(SecureStorageRef ref) => const FlutterSecureStorage();

@riverpod
Future<Map<String, String>> secureStorageRead(SecureStorageReadRef ref) async {
  final storage = ref.watch(secureStorageProvider);
  ref.keepAlive();
  return storage.readAll();
}

@riverpod
Future<void> secureStorageWrite(SecureStorageWriteRef ref,
    String? handle, String? apiKey, String? apiSecret) async {

  final storage = ref.watch(secureStorageProvider);
  await storage.write(key: Constants.handleKey, value: handle);
  await storage.write(key: Constants.apiKeyKey, value: apiKey);
  await storage.write(key: Constants.apiSecretKey, value: apiSecret);

  ref.invalidate(secureStorageReadProvider);
}
