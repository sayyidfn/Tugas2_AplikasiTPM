import 'package:flutter/material.dart';
import 'package:tugasaplikasitpm/pages/calculator_page.dart';
import 'package:tugasaplikasitpm/pages/group_data_page.dart';
import 'package:tugasaplikasitpm/pages/guess_number_page.dart';
import 'package:tugasaplikasitpm/pages/pyramid_page.dart';
import 'package:tugasaplikasitpm/pages/stopwatch_page.dart';
import 'package:tugasaplikasitpm/pages/sum_page.dart';

class MenuModel {
  final String title;
  final String iconPath;
  final Widget Function(MenuModel) pageBuilder;
  final bool isFullWidth;

  MenuModel({
    required this.title,
    required this.iconPath,
    required this.pageBuilder,
    this.isFullWidth = false,
  });

  static List<MenuModel> get mainMenus => [
    MenuModel(
      title: "STOPWATCH",
      iconPath: "assets/icons/stopwatch.svg",
      pageBuilder: (m) => StopwatchPage(menuData: m),
      isFullWidth: true,
    ),
    MenuModel(
      title: "ANGGOTA KELOMPOK",
      iconPath: "assets/icons/group.svg",
      pageBuilder: (m) => const GroupDataPage(),
    ),
    MenuModel(
      title: "TAMBAH & KURANG",
      iconPath: "assets/icons/math.svg",
      pageBuilder: (m) => const CalculatorPage(),
    ),
    MenuModel(
      title: "HITUNG KARAKTER",
      iconPath: "assets/icons/sigma.svg",
      pageBuilder: (m) => const SumPage(),
    ),
    MenuModel(
      title: "TEBAK BILANGAN",
      iconPath: "assets/icons/guess.svg",
      pageBuilder: (m) => const GuessNumberPage(),
    ),
    MenuModel(
      title: "KALKULATOR PIRAMID",
      iconPath: "assets/icons/pyramid.svg",
      pageBuilder: (m) => PyramidPage(),
      isFullWidth: true,
    ),
  ];
}
