import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tugasaplikasitpm/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class AppColors {
  static const Color navy = Color(0xFF1E2246);
  static const Color bg = Color(0xFFF8F9F9);
  static const Color dark = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
}

class AppTextStyles {
  static TextStyle heading = GoogleFonts.oswald(
    color: AppColors.dark,
    fontWeight: FontWeight.bold,
  );
  static TextStyle body = GoogleFonts.inter(color: AppColors.dark);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Tugas Aplikasi TPM",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.bg,
        textTheme: GoogleFonts.interTextTheme(),
      ),
      home: const LoginPage(),
    );
  }
}
