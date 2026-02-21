import 'package:flutter/foundation.dart'; // ← обязательно для debugPrint

class Log {
  static const _reset = '\x1B[0m';
  static const red = '\x1B[31m';
  static const green = '\x1B[32m';
  static const yellow = '\x1B[33m';
  static const blue = '\x1B[34m';
  static const magenta = '\x1B[35m';
  static const cyan = '\x1B[36m';

  static void e(String msg) => debugPrint('$red[ERROR] $msg$_reset');
  static void w(String msg) => debugPrint('$yellow[WARN] $msg$_reset');
  static void i(String msg) => debugPrint('$blue[INFO]  $msg$_reset');
  static void s(String msg) => debugPrint('$green[SUCCESS] $msg$_reset');
  static void d(String msg) => debugPrint('$cyan[DEBUG] $msg$_reset');
}

// Использование:
// Log.e("Не удалось подключиться к базе");
// Log.s("Кэш успешно очищен");
