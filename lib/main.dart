import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'catalog_provider.dart';
import 'home_page.dart';
import 'app_scroll_behavior.dart';

void main() {
  runApp(const GoatherderApp());
}

class GoatherderApp extends StatelessWidget {
  const GoatherderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CatalogProvider()..load(),
      child: MaterialApp(
        title: "Goatherder’s Guide to the Galaxy",
        debugShowCheckedModeBanner: false,
        scrollBehavior: AppScrollBehavior(),
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          colorSchemeSeed: Colors.deepPurple,
        ),
        home: const HomePage(),
      ),
    );
  }
}
