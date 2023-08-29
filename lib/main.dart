import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sw_finder/di_container.dart';
import 'package:sw_finder/resource/langs/codegen_loader.g.dart';
import 'application.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();


  await DiContainer().init();

  runApp(EasyLocalization(
    // for generate parser dart run easy_localization:generate -S "lib/resource/langs" -O "lib/resource/langs"
    // for generate keys dart run easy_localization:generate -f keys -o locale_keys.g.dart -S "lib/resource/langs" -O "lib/resource/langs"
    supportedLocales: const [Locale('en'), Locale('ru')],
    path: 'lib/resource/lang',
    fallbackLocale: const Locale('ru'),
    assetLoader: const CodegenLoader(),
    child: MyApp(savedThemeMode: savedThemeMode),
  ),);
}