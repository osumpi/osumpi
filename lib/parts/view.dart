import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:osumpi/models/theme.dart';
import 'package:osumpi/routes/theme/save_debouncer.dart';
import 'package:osumpi/routes/theme/setting.dart';
import 'package:osumpi/shared/hexcolor.dart';
import 'package:recase/recase.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({
    final Key? key,
    required this.themeJson,
    required this.jsonPath,
    required this.scrollController,
  }) : super(key: key);

  final Map<String, dynamic> themeJson;

  final ScrollController? scrollController;

  final String jsonPath;

  /// Save theme changes on setting's value change.
  void onChanged(
    final String value,
    final ThemeDataNotifier themeNotifier,
    final Map<String, dynamic> json,
    final String currentKey,
  ) {
    json[currentKey] = value;
    themeNotifier.fromMap(json);

    ThemeSavingDebouncer.refreshTimer(themeNotifier.save);
  }

  /// Convert value to (meaningful) string.
  static String convertValue(final dynamic value) =>
      (value is Color) ? value.toHexString() : value.toString();

  Widget buildListViewContent(
    final Map<String, dynamic> json,
    final BuildContext context,
    final int index,
    final String themeTitle,
    final dynamic themeValue,
    final String path,
    final ThemeDataNotifier notifier,
    final String themeIndex,
  ) {
    return FadeIn(
      preferences: const AnimationPreferences(
        offset: Duration(milliseconds: 100),
      ),
      child: (themeValue is Map)
          ? ExpansionTile(
              title: Text(themeTitle),
              subtitle: Text(path),
              children: [
                SizedBox(
                  height: 65 * themeValue.keys.length.toDouble(),
                  child: SettingsView(
                    themeJson: themeValue as Map<String, dynamic>,
                    jsonPath: path,
                    scrollController: null,
                  ),
                ),
              ],
            )
          : ListTile(
              tileColor: Colors.white,
              title: Text(themeTitle),
              subtitle: Text(path),
              trailing: SizedBox(
                width: 120,
                child: ThemeSetting(
                  value: themeValue.toString(),
                  onChanged: (final value) {
                    onChanged(
                      convertValue(value),
                      notifier,
                      json,
                      themeIndex,
                    );
                  },
                ),
              ),
            ),
    );
  }

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final isTopLevel = jsonPath == 'settings';
    final notifier = ref.watch(ThemeDataNotifier.provider);
    final json = themeJson;

    return ListView.builder(
      controller: scrollController,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: json.keys.length,
      itemBuilder: (final context, final index) {
        final themeIndex = json.keys.toList()[index];

        final themeTitle = themeIndex.titleCase;
        final themeValue = json[themeIndex];
        final path = '$jsonPath/$themeIndex';

        return buildListViewContent(
          json,
          context,
          index,
          themeTitle,
          themeValue,
          path,
          notifier,
          themeIndex,
        );
      },
    );
  }
}
