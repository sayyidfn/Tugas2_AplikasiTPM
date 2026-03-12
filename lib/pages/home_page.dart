import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tugasaplikasitpm/main.dart';
import 'package:tugasaplikasitpm/models/menu_model.dart';
import 'package:tugasaplikasitpm/models/stopwatch_model.dart';
import 'package:tugasaplikasitpm/models/user_model.dart';
import 'package:tugasaplikasitpm/pages/login_page.dart';

class HomePage extends StatefulWidget {
  final UserModel loginUser;
  const HomePage({super.key, required this.loginUser});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final StopwatchModel _stopwatch = StopwatchModel();

  @override
  Widget build(BuildContext context) {
    final allMenus = MenuModel.mainMenus;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 30),
                _buildMenuCard(allMenus[0], isStopwatch: true),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: _buildMenuCard(allMenus[1])),
                    const SizedBox(width: 10),
                    Expanded(child: _buildMenuCard(allMenus[2])),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: _buildMenuCard(allMenus[3])),
                    const SizedBox(width: 10),
                    Expanded(child: _buildMenuCard(allMenus[4])),
                  ],
                ),

                const SizedBox(height: 10),
                _buildMenuCard(allMenus[5], isPyramid: true),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CircleAvatar(
          radius: 28,
          backgroundColor: AppColors.dark,
          child: Icon(Icons.person, color: AppColors.white, size: 30),
        ),
        // const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Halo, ${widget.loginUser.name}",
              style: AppTextStyles.body.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const Text(
              "Silahkan pilih menu dibawah",
              style: TextStyle(color: Colors.black54, fontSize: 14),
            ),
          ],
        ),
        IconButton(
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          ),
          icon: Icon(Icons.logout),
        ),
      ],
    );
  }

  Widget _buildMenuCard(
    MenuModel menu, {
    bool isStopwatch = false,
    bool isPyramid = false,
  }) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => menu.pageBuilder(menu)),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(
            color: AppColors.dark.withValues(alpha: 0.8),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: isStopwatch
            ? _buildStopwatchContent(menu)
            : isPyramid
            ? _buildPyramidContent(menu)
            : _buildStandardContent(menu),
      ),
    );
  }

  Widget _buildStandardContent(MenuModel menu) {
    return Column(
      children: [
        SvgPicture.asset(menu.iconPath, height: 60),
        Text(
          menu.title,
          textAlign: TextAlign.center,
          style: AppTextStyles.heading.copyWith(fontSize: 18),
        ),
      ],
    );
  }

  Widget _buildStopwatchContent(MenuModel menu) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(menu.iconPath, height: 110),
        const SizedBox(width: 15),

        Expanded(
          child: ListenableBuilder(
            listenable: _stopwatch,
            builder: (context, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        menu.title,
                        style: AppTextStyles.heading.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          height: 1.0,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () => _stopwatch.toggle(),
                            child: Icon(
                              _stopwatch.isRunning
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              size: 20,
                              color: AppColors.dark,
                            ),
                          ),
                          const Text("/"),
                          GestureDetector(
                            onTap: () => _stopwatch.reset(),
                            child: const Icon(
                              Icons.stop,
                              size: 20,
                              color: AppColors.dark,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black.withValues(alpha: 0.5),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          _stopwatch.formatTime(),
                          style: AppTextStyles.heading.copyWith(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                            fontSize: 40,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPyramidContent(MenuModel menu) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                menu.title,
                style: AppTextStyles.heading.copyWith(fontSize: 18),
              ),
              const SizedBox(height: 4),
              Text(
                "Luas = luas alas + jumlah luas sisi tegak",
                style: AppTextStyles.body.copyWith(fontSize: 10),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "Volume = 1/3 x luas alas x tinggi",
                style: AppTextStyles.body.copyWith(fontSize: 10),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        SvgPicture.asset(menu.iconPath, height: 110),
      ],
    );
  }
}
