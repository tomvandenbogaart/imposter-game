import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/config/router_config.dart';
import 'core/theme/app_theme.dart';

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
    return MaterialApp.router(
      title: 'Sus Night',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      routerConfig: AppRouter.router,
    );
  }
}
