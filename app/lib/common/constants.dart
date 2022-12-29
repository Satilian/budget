import 'dart:io';

import 'package:flutter/cupertino.dart';

class StorageKeys {
  final onboardStatus = 'onboardVisited';

  const StorageKeys();
}

class Constants {
  // change !Platform.isAndroid to get iOS view
  static final isAndroid = Platform.isAndroid;
  static const double gridSize = 8;
  static getFigmaSize(context, int size) => MediaQuery.of(context).size.width / 375 * size;
  static const apiUrl = "https://api-dev.k3s.dex-it.ru";
  static const authDeviceClientId = "mobile.device";
  static const authDeviceClientSecret = "33FCAD9A-B2E0-4962-A1F2-E0BFBD7D75B7";
  static const authUserClientId = "mobile.client";
  static const authUserClientSecret = "D7927BE0-A841-414C-880E-206D08235B6D";

  static const storageKeys = StorageKeys();
}