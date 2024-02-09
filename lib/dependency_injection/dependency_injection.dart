import 'package:get_it/get_it.dart';

import '../services/api_service.dart';
import '../services/storage_service.dart';

class DependencyInjection {
  static final GetIt getIt = GetIt.instance;

  static void setup() {
    getIt.registerSingleton<StorageService>(StorageService());
    getIt.registerSingleton<ApiService>(ApiService());
  }
}