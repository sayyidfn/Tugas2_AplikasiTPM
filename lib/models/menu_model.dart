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
  final Widget destination;
  final bool isFullWidth;

  MenuModel({
    required this.title,
    required this.iconPath,
    required this.destination,
    this.isFullWidth = false,
  });

  static List<MenuModel> get mainMenus => [
    MenuModel(
      title: "STOPWATCH",
      iconPath: "assets/icons/stopwatch.svg",
      destination: const StopwatchPage(),
      isFullWidth: true,
    ),
    MenuModel(
      title: "DATA KELOMPOK",
      iconPath: "assets/icons/group.svg",
      destination: const GroupDataPage(),
    ),
    MenuModel(
      title: "TAMBAH & KURANG",
      iconPath: "assets/icons/math.svg",
      destination: const CalculatorPage(),
    ),
    MenuModel(
      title: "TOTAL ANGKA INPUT",
      iconPath: "assets/icons/sigma.svg",
      destination: const SumPage(),
    ),
    MenuModel(
      title: "TEBAK ANGKA",
      iconPath: "assets/icons/guess.svg",
      destination: const GuessNumberPage(),
    ),
    MenuModel(
      title: "KALKULATOR PIRAMID",
      iconPath: "assets/icons/pyramid.svg",
      destination: const PyramidPage(),
      isFullWidth: true,
    ),
  ];
}
