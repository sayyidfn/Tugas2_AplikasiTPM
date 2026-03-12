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
          child: ListenableBuilder(
            listenable: _stopwatch,
            builder: (context, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  SvgPicture.asset(widget.menuData.iconPath, height: 180),
                  const SizedBox(height: 10),
                  Text(
                    _stopwatch.formatTime(),
                    style: AppTextStyles.heading.copyWith(
                      fontSize: 42,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildSideButton(
                        icon: Icons.replay,
                        onTap: () => _stopwatch.reset(),
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () => _stopwatch.toggle(),

                            child: Container(
                              height: 70,
                              width: 70,
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
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: AppColors.dark,
                            ),
                          ),
                        ],
                      ),
                      _buildSideButton(
                        icon: Icons.flag,
                        onTap: () => _stopwatch.addLap(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
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
                          child: _stopwatch.laps.isEmpty
                              ? Center(child: Text("Belum ada data lap"))
                              : ListView.builder(
                                  key: ValueKey(_stopwatch.laps.length),
                                  itemCount: _stopwatch.laps.length,
                                  itemBuilder: (context, index) {
                                    int lapNumber =
                                        _stopwatch.laps.length - index;
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            lapNumber.toString().padLeft(
                                              2,
                                              '0',
                                            ),
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
              );
            },
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
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.dark, width: 1.5),
        ),
        child: Icon(icon, color: AppColors.dark, size: 24),
      ),
    );
  }
}
