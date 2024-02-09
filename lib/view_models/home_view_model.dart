import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../services/storage_service.dart';

class HomeViewModel extends ChangeNotifier {
  final StorageService _storageService = GetIt.I.get<StorageService>();

  int currentIndex = 0;

  void setIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  Future<void> logoutUser() async {
    await _storageService.deleteToken();
    await _storageService.deleteUsername();
  }
}