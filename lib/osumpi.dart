import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OsumPi extends ChangeNotifier with _AppThemeManager {
  OsumPi.create();

  String get title => 'OsumPi - IoT ecosystem management interface';

  factory OsumPi.of(BuildContext context) =>
      Provider.of<OsumPi>(context, listen: false);
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
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFF00B173),
        canvasColor: const Color(0xFFF9FAFD),
        textTheme: _defaultTextTheme.apply(
          bodyColor: Colors.black,
          displayColor: Colors.black,
        ),
        shadowColor: Colors.blueGrey.shade50,
        tooltipTheme: TooltipThemeData(
          margin: const EdgeInsets.only(left: 50),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black45,
          ),
          verticalOffset: -10,
        ),
        navigationRailTheme: NavigationRailThemeData(
          backgroundColor: const Color(0xFF24242C),
          selectedIconTheme: const IconThemeData(
            color: Colors.white,
          ),
          unselectedIconTheme: IconThemeData(
            color: Colors.grey.shade600,
          ),
        ),
        visualDensity: VisualDensity.comfortable,
      );

  ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF292934),
        backgroundColor: const Color(0xFF212228),
        primaryColor: const Color(0xFF00B173),
        accentColor: Colors.grey.shade600,
        iconTheme: IconThemeData(
          color: Colors.grey.shade600,
        ),
        textTheme: _defaultTextTheme.apply(
          bodyColor: Colors.grey.shade300,
          displayColor: Colors.grey.shade600,
        ),
        tooltipTheme: TooltipThemeData(
          margin: const EdgeInsets.only(left: 50),
          padding: const EdgeInsets.all(8),
          // decoration: BoxDecoration(
          //   // color: Colors.black45,
          // ),
          verticalOffset: -10,
        ),
        navigationRailTheme: NavigationRailThemeData(
          backgroundColor: const Color(0xFF24242C),
          selectedIconTheme: const IconThemeData(
            color: Colors.white,
          ),
          unselectedIconTheme: IconThemeData(
            color: Colors.grey.shade600,
          ),
        ),
      );

  TextTheme get _defaultTextTheme => GoogleFonts.openSansTextTheme();
}
