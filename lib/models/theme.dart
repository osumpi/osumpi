import 'dart:io';

import 'package:fhir_yaml/fhir_yaml.dart';
import 'package:file/local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glob/glob.dart';
import 'package:json_theme/json_theme.dart';
import 'package:osumlog/osumlog.dart';
import 'package:osumpi/shared/path.dart';
import 'package:path/path.dart';

import 'package:recase/recase.dart';
import 'package:watcher/watcher.dart';
import 'package:yaml/yaml.dart';

LocalFileSystem fs = const LocalFileSystem();

/// The theme provider will provide the editor the theme data from the
/// theme file. This provider will listen for any changes in the theme
/// file and notify the editor to reload the theme changes when necessary.
class ThemeDataNotifier extends ChangeNotifier {
  var _theme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: const Color(0xFF00B173),
    canvasColor: const Color(0xFFF9FAFD),
    // textTheme: _defaultTextTheme
    //     .apply(
    //       bodyColor: Colors.black,
    //       displayColor: Colors.black,
    //     )
    //     .copyWith(
    //       headline6: const TextStyle(
    //         fontWeight: FontWeight.bold,
    //       ),
    //     ),
    shadowColor: Colors.blueGrey.shade50,
    tooltipTheme: const TooltipThemeData(
      margin: EdgeInsets.only(left: 50),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black45,
      ),
      verticalOffset: -10,
    ),
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: Colors.grey.shade50,
      selectedIconTheme: const IconThemeData(
        color: Colors.black,
      ),
      unselectedIconTheme: IconThemeData(
        color: Colors.grey.shade500,
      ),
    ),
    visualDensity: VisualDensity.comfortable,
  );

  static bool isMonitoring = false;

  List<String> getThemeList() {
    print(join("${EditorPaths.themeDirectory}", "*"));

    final themeFiles = Glob(
      join("${EditorPaths.themeDirectory}", "*"),
      recursive: true,
      caseSensitive: false,
    );

    print([
      for (final entity in themeFiles.listFileSystemSync(fs))
        entity.basename.sentenceCase
    ]);

    return [
      for (final entity in themeFiles.listFileSystemSync(fs))
        entity.basename.sentenceCase
    ];
  }

  /// The theme data.
  ThemeData get theme => _theme;

  /// Load theme data from [map].
  void fromMap(final Map<String, dynamic> map) {
    Log.trace("ThemeDataNotifier.fromMap $map");
    final value = ThemeDecoder.decodeThemeData(map, validate: false);

    if (_theme != value) {
      _theme = value!;
      notifyListeners();
    }
  }

  /// The theme data provider.
  static final provider =
      ChangeNotifierProvider((final ref) => ThemeDataNotifier());

  /// Init & Monitor theme file and reload if changes.
  Future<void> initAndMonitor() async {
    // Call once before actually monitoring the file changes.
    await load();
    notifyListeners();

    Watcher(file.path).events.listen((final _) async {
      await load();
      notifyListeners();
    });
  }

  /// The theme file.
  static File file = File('${EditorPaths.theme}');

  @deprecated
  Future<void> toggleDarkMode() async {
    switch (_theme.brightness) {
      case Brightness.light:
        _theme = ThemeData(brightness: Brightness.dark);
        break;
      default:
        _theme = ThemeData(brightness: Brightness.light);
        break;
    }
    await save();
  }

  /// Save the theme. (Also reloads if file monitor is enabled!)
  Future<void> save() async =>
      file.writeAsString(json2yaml(ThemeEncoder.encodeThemeData(_theme)!));

  /// Load the theme by giving passing the theme [name].
  Future<void> load([final EditorPaths name = EditorPaths.theme]) async {
    file = File('$name');

    try {
      // Try to load the theme data from the json file.
      if (!await file.exists()) {
        await file.create(recursive: true);
      }

      final content = loadYaml(await file.readAsString());

      // validator is soo slow!
      _theme = ThemeDecoder.decodeThemeData(content, validate: false)!;
    } catch (e) {
      stderr.writeln(e);

      _theme = await fallback();
      await save();
    }
  }

  /// Fallback logic to trigger if loading the theme data failed.
  Future<ThemeData> fallback() async {
    // Save the current corrupted theme data in a backup file.
    final backupFile = File('${EditorPaths.backupTheme}');

    final content = await file.readAsString();

    await backupFile.writeAsString(content);

    return _theme;
  }
}
