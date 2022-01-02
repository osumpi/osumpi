import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_theme/json_theme.dart';
import 'package:osumpi/models/theme.dart';

class ThemeJson extends StateNotifier<Map<String, dynamic>> {
  ThemeJson(final Map<String, dynamic> _json)
      : home = _json,
        super(_json);

  final Map<String, dynamic> home;

  Map<String, dynamic> get json => super.state;

  void moveDeeper(final String setting) {
    print(true);
    super.state = super.state[setting] as Map<String, dynamic>;
  }

  void returnToHome() => super.state = home;

  static final provider =
      StateNotifierProvider<ThemeJson, Map<String, dynamic>>((final ref) {
    final themeProvider = ref.watch(ThemeDataNotifier.provider);
    return ThemeJson(ThemeEncoder.encodeThemeData(themeProvider.theme)!);
  });
}
