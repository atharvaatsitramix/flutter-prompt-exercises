import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  static const String _themeKey = 'theme_mode';
  static const String _fontKey = 'selected_font';
  
  ThemeMode _themeMode = ThemeMode.system;
  String _selectedFont = 'Roboto';

  ThemeMode get themeMode => _themeMode;
  String get selectedFont => _selectedFont;

  final List<String> availableFonts = [
    'Roboto',
    'Open Sans',
    'Lato',
    'Montserrat',
    'Poppins',
    'Source Sans Pro',
    'Nunito',
    'Inter',
  ];

  ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.light,
      ),
      textTheme: GoogleFonts.getTextTheme(_selectedFont),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey[800],
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.dark,
      ),
      textTheme: GoogleFonts.getTextTheme(_selectedFont, ThemeData.dark().textTheme),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey[200],
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    _saveThemeMode();
    notifyListeners();
  }

  void setFont(String font) {
    _selectedFont = font;
    _saveFont();
    notifyListeners();
  }

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    
    final themeModeIndex = prefs.getInt(_themeKey) ?? ThemeMode.system.index;
    _themeMode = ThemeMode.values[themeModeIndex];
    
    _selectedFont = prefs.getString(_fontKey) ?? 'Roboto';
    
    notifyListeners();
  }

  Future<void> _saveThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeKey, _themeMode.index);
  }

  Future<void> _saveFont() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_fontKey, _selectedFont);
  }
} 