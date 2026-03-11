import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tugasaplikasitpm/main.dart';
import 'package:tugasaplikasitpm/models/menu_model.dart';
import 'package:tugasaplikasitpm/models/stopwatch_model.dart';

class StopwatchPage extends StatefulWidget {
  final MenuModel menuData;
  const StopwatchPage({super.key, required this.menuData});

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  final StopwatchModel _stopwatch = StopwatchModel();

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: Text(
          widget.menuData.title,
          style: AppTextStyles.heading.copyWith(fontSize: 26),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 70),
              SvgPicture.asset(widget.menuData.iconPath, height: 200),
              const SizedBox(height: 20),
              Text(
                _stopwatch.formatTime(),
                style: AppTextStyles.heading.copyWith(
                  fontSize: 56,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSideButton(
                    icon: Icons.replay,
                    onTap: () => _stopwatch.reset(_refresh),
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () => _stopwatch.toggle(_refresh),
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: AppColors.navy,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _stopwatch.isRunning
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.white,
                            size: 44,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "START/STOP",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.dark,
                        ),
                      ),
                    ],
                  ),
                  _buildSideButton(
                    icon: Icons.flag,
                    onTap: () => _stopwatch.addLap(_refresh),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Lap",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.dark,
                          ),
                        ),
                        Text(
                          "Time",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.dark,
                          ),
                        ),
                      ],
                    ),
                    const Divider(color: AppColors.dark, thickness: 1),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _stopwatch.laps.length,
                        itemBuilder: (context, index) {
                          int lapNumber = _stopwatch.laps.length - index;
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  lapNumber.toString().padLeft(2, '0'),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  _stopwatch.laps[index],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSideButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.dark, width: 1.5),
        ),
        child: Icon(icon, color: AppColors.dark, size: 24),
      ),
    );
  }
}
