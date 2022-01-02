import 'dart:io';

/// The editor's path constants are stored in this class. The class contains
/// path for loading themes, extension, etc for the editor.
///
/// To get the path use the [toString] method.
///
class EditorPaths {
  const EditorPaths._(this._path);

  factory EditorPaths.customTheme(final String name) {
    final filename = '$name.yaml';

    if (!File(filename).existsSync()) {
      return defaultTheme;
    }

    return EditorPaths._(filename);
  }

  final String _path;

  static const theme = EditorPaths._('editor/themes/theme.yaml');

  static const themeDirectory = EditorPaths._('editor/themes');

  static const defaultTheme = EditorPaths._('editor/themes/theme_default.yaml');

  static const backupTheme = EditorPaths._('editor/themes/theme_backup.yaml');

  static const extension = EditorPaths._('editor/extension/extension.yaml');

  @override
  String toString() => _path;
}
