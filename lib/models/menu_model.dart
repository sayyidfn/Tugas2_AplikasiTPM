import 'package:flutter/material.dart';
import 'package:tugasaplikasitpm/views/calculator_page.dart';
import 'package:tugasaplikasitpm/views/group_data_page.dart';
import 'package:tugasaplikasitpm/views/guess_number_page.dart';
import 'package:tugasaplikasitpm/views/pyramid_page.dart';
import 'package:tugasaplikasitpm/views/stopwatch_page.dart';
import 'package:tugasaplikasitpm/views/sum_page.dart';
import 'package:tugasaplikasitpm/views/date_conversion_page.dart';

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
      title: "DATA KELOMPOK",
      iconPath: "assets/icons/group.svg",
      pageBuilder: (m) => GroupDataPage(menuData: m),
    ),

    MenuModel(
      title: "TAMBAH & KURANG",
      iconPath: "assets/icons/math.svg",
      pageBuilder: (m) => CalculatorPage(menuData: m),
    ),

    MenuModel(
      title: "TOTAL ANGKA INPUT",
      iconPath: "assets/icons/sigma.svg",
      pageBuilder: (m) => SumPage(menuData: m),
    ),

    MenuModel(
      title: "TEBAK BILANGAN's",
      iconPath: "assets/icons/guess.svg",
      pageBuilder: (m) => GuessNumberPage(menuData: m),
    ),

    MenuModel(
      title: "DETAIL TANGGAL",
      iconPath: "assets/icons/calendar.svg",
      pageBuilder: (m) => DateConversionPage(menuData: m),
    ),

    MenuModel(
      title: "KALKULATOR PIRAMID",
      iconPath: "assets/icons/pyramid.svg",
      pageBuilder: (m) => PyramidPage(menuData: m),
    ),
  ];
}
