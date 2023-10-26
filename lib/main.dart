import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/pages/completed_tasks_page.dart';
import 'package:todo/pages/home_page.dart';
import 'package:todo/pages/splash_screen.dart';
import 'package:todo/providers/task_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: MaterialApp(
        title: "Todo App",
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => const SplashScreen(),
          HomePage.routeName: (context) => const HomePage(),
          CompletedTasksPage.routeName: (context) => const CompletedTasksPage(),
        },
      ),
    );
  }
}
