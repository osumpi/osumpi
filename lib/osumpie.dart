import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OsumPie extends ChangeNotifier with _AppThemeManager {
  OsumPie.create();

  String get title => 'OsumPie - IoT ecosystem management interface';

  factory OsumPie.of(BuildContext context) =>
      Provider.of<OsumPie>(context, listen: false);
}

mixin _AppThemeManager on ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;

  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode value) {
    if (themeMode != value) {
      _themeMode = value;
      notifyListeners();
    }
  }

  ThemeData get theme => ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFFED8936),
        textTheme: _defaultTextTheme.apply(
          bodyColor: Colors.black,
          displayColor: Colors.black,
        ),
      );

  ThemeData get darkTheme => ThemeData(
        scaffoldBackgroundColor: const Color(0xFF202B3C),
        backgroundColor: const Color(0xFF1B202C),
        primaryColor: const Color(0xFFED8936),
        accentColor: Colors.grey.shade400,
        iconTheme: IconThemeData(
          color: Colors.grey.shade600,
        ),
        textTheme: _defaultTextTheme.apply(
          bodyColor: Colors.grey.shade300,
          displayColor: Colors.grey.shade600,
        ),
      );

  TextTheme get _defaultTextTheme => GoogleFonts.openSansTextTheme();
}
