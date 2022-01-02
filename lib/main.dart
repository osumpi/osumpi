import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:osumlog/osumlog.dart';
import 'package:osumpi/models/theme.dart';
import 'package:osumpi/routes/theme/page.dart';
import 'package:osumpi/shared/path.dart';

const title = "osumpi";

void main() => runApp(const ProviderScope(child: OsumPi()));

class OsumPi extends ConsumerWidget {
  const OsumPi({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final themeProvider = ref.watch(ThemeDataNotifier.provider);

    if (!ThemeDataNotifier.isMonitoring) {
      Log.fatal("Monitoring ${EditorPaths.theme}");
      themeProvider.initAndMonitor();
      ThemeDataNotifier.isMonitoring = true;
    }

    return MaterialApp(
      title: title,
      theme: themeProvider.theme,
      home: const Dashboard(),
    );
  }
}

class Dashboard extends ConsumerWidget {
  const Dashboard({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final themeNotifier = ref.watch(ThemeDataNotifier.provider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
      ),
      body: ThemeEditorPage(),
      floatingActionButton: FloatingActionButton(
        onPressed: themeNotifier.toggleDarkMode,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
