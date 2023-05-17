import 'package:apex_assessment/utils/colors.dart';
import 'package:apex_assessment/home/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apex Assessment',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: AppColors.backgroundColor,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeView(),
    );
  }
}
