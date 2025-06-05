import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/todo_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/todo_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return FutureBuilder(
            future: themeProvider.loadPreferences(),
            builder: (context, snapshot) {
              return MaterialApp(
                title: 'Todo App',
                debugShowCheckedModeBanner: false,
                theme: themeProvider.lightTheme,
                darkTheme: themeProvider.darkTheme,
                themeMode: themeProvider.themeMode,
                home: const TodoListScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
