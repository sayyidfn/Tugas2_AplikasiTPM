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
      pageBuilder: (m) => GroupDataPage(menuData: m),
    ),
    MenuModel(
      title: "TAMBAH & KURANG",
      iconPath: "assets/icons/math.svg",
      pageBuilder: (m) => CalculatorPage(menuData: m),
    ),
    MenuModel(
      title: "HITUNG KARAKTER",
      iconPath: "assets/icons/sigma.svg",
      pageBuilder: (m) => SumPage(menuData: m),
    ),
    MenuModel(
      title: "TEBAK BILANGAN",
      iconPath: "assets/icons/guess.svg",
      pageBuilder: (m) => GuessNumberPage(menuData: m),
    ),
    MenuModel(
      title: "KALKULATOR PIRAMID",
      iconPath: "assets/icons/pyramid.svg",
      pageBuilder: (m) => PyramidPage(menuData: m),
      isFullWidth: true,
    ),
  ];
}
