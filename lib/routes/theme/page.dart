import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:osumpi/models/theme.dart';
import 'package:osumpi/routes/theme/themejson.dart';
import 'package:osumpi/parts/view.dart';
import 'package:osumpi/shared/smooth_scroll_web.dart';

class ThemeEditorPage extends ConsumerWidget {
  /// The theme editor page will handle the entire theme settings for osumpi.
  const ThemeEditorPage({final Key? key}) : super(key: key);

  static final _globalSettingsViewScrollControllerForSmoothWebView =
      ScrollController();

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final json = ref.watch(ThemeJson.provider);
    final notifier = ref.watch(ThemeDataNotifier.provider.notifier);

    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Scrollbar(
              isAlwaysShown: true,
              controller: _globalSettingsViewScrollControllerForSmoothWebView,
              child: SmoothScrollWeb(
                scrollSpeed: 60,
                controller: _globalSettingsViewScrollControllerForSmoothWebView,
                child: SettingsView(
                  themeJson: json,
                  jsonPath: 'settings',
                  scrollController:
                      _globalSettingsViewScrollControllerForSmoothWebView,
                ),
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 25, 0),
              child: Wrap(
                spacing: 10,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.2,
                    height: 40,
                    child: DropdownSearch<String>(
                      showSearchBox: true,
                      showSelectedItems: true,
                      showClearButton: true,
                      showFavoriteItems: true,
                      mode: Mode.MENU,
                      items: notifier.getThemeList(),
                      onChanged: print,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: ElevatedButton.icon(
                      onPressed: () => FilePicker.platform.pickFiles(
                        dialogTitle: "Pick Theme Preset",
                        allowedExtensions: ['json'],
                        onFileLoading: (p0) => print('sdsd$p0'),
                      ),
                      icon: const Icon(Icons.download),
                      label: const Text("Export"),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.upload),
                      label: const Text("Import"),
                    ),
                  ),
                ],
              ),
            ),
            IgnorePointer(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.9,
                  // TODO: Put the dashboard page widget here to preview the theme.
                  child: ElevatedButton(
                    child: const Text("Preview"),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
