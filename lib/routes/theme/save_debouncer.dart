
import 'dart:async';

/// The theme saving debouncer will debounce the theme content edits.
class ThemeSavingDebouncer {
  const ThemeSavingDebouncer._();

  /// Debounce duration.
  static Duration duration = const Duration(seconds: 1);

  static Timer _timer = Timer(duration, () {});

  /// Is timer active?
  static bool get isActive => _timer.isActive;

  /// Cancel the timer.
  static void cancel() => _timer.cancel();

  /// Register a [callback] for the timer to execute.
  static void register(final void Function() callback) =>
      _timer = Timer(duration, callback);

  /// Refresh the timer by also passing the [callback].
  static void refreshTimer(final void Function() callback) {
    if (isActive) cancel();
    register(callback);
  }
}