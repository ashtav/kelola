import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kelola_produk/app/core/extensions/theme.dart';
import 'package:kelola_produk/app/routes/routes.dart';
import 'package:lazyui/lazyui.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  LazyUi.config(
    theme: AppTheme.light,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Kelola',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      builder: LazyUi.builder,
    );
  }
}
