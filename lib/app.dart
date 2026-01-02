import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/config/router_config.dart';
import 'core/theme/app_theme.dart';
import 'l10n/app_localizations.dart';
import 'presentation/providers/locale_provider.dart';

class SusNightApp extends ConsumerStatefulWidget {
  const SusNightApp({super.key});

  @override
  ConsumerState<SusNightApp> createState() => _SusNightAppState();
}

class _SusNightAppState extends ConsumerState<SusNightApp> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Precache the background image for better performance
    precacheImage(const AssetImage('assets/images/background.jpg'), context);
  }

  @override
  Widget build(BuildContext context) {
    final locale = ref.watch(localeProvider);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Sus Night',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.dark,
          routerConfig: AppRouter.router,

          // Localization configuration
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: supportedLocales,
          locale: locale, // null = system default
        );
      },
    );
  }
}
