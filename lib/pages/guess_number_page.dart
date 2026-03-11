import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tugasaplikasitpm/main.dart';
import 'package:tugasaplikasitpm/models/menu_model.dart';

class GuessNumberPage extends StatefulWidget {
  final MenuModel menuData;
  const GuessNumberPage({super.key, required this.menuData});

  @override
  State<GuessNumberPage> createState() => _GuessNumberPageState();
}

class _GuessNumberPageState extends State<GuessNumberPage> {
  final TextEditingController _numberController = TextEditingController();

  int? _lastCheckedNumber;
  bool _isOdd = false;
  bool _isPrime = false;

  bool _checkIfPrime(int n) {
    if (n <= 1) return false;
    for (int i = 2; i <= n ~/ 2; i++) {
      if (n % i == 0) return false;
    }
    return true;
  }

  void _handleCheck() {
    String input = _numberController.text.trim();

    if (input.isEmpty) {
      _showSnack("Masukkan angka terlebih dahulu!", Colors.orange.shade700);
      return;
    }

    int? num = int.tryParse(input);
    if (num == null) {
      _showSnack("Input harus berupa angka bulat!", Colors.red.shade700);
      return;
    }

    setState(() {
      _lastCheckedNumber = num;
      _isOdd = num % 2 != 0;
      _isPrime = _checkIfPrime(num);
    });
  }

  void _showSnack(String pesan, Color warna) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          pesan,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: warna,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              const SizedBox(height: 70),

              SvgPicture.asset(widget.menuData.iconPath, height: 140),
              const SizedBox(height: 15),

              const Text(
                "Cek Angka(Ganjil/Genap/Prima?)",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.dark,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),

              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Masukkan Angka:",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.dark,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              SizedBox(
                height: 50,
                child: TextField(
                  controller: _numberController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.dark,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 0,
                    ), // Padding disesuaikan
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: AppColors.dark,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: AppColors.dark,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _handleCheck,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.navy,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "CEK STATUS",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              if (_lastCheckedNumber != null) ...[
                Text(
                  "$_lastCheckedNumber",
                  style: const TextStyle(
                    fontSize: 80,
                    fontWeight: FontWeight.w900,
                    color: AppColors.dark,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 20),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildStatusRow(
                      iconData: Icons.functions,
                      label: _isOdd ? "Ganjil" : "Genap",
                      isYes: true,
                    ),
                    const SizedBox(height: 8),
                    _buildStatusRow(
                      iconData: Icons.check,
                      label: "Prima",
                      isYes: _isPrime,
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusRow({
    required IconData iconData,
    required String label,
    required bool isYes,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: const BoxDecoration(
            color: AppColors.dark,
            shape: BoxShape.circle,
          ),
          child: Icon(iconData, color: Colors.white, size: 14),
        ),
        const SizedBox(width: 10),
        RichText(
          text: TextSpan(
            style: const TextStyle(fontSize: 15, color: AppColors.dark),
            children: [
              TextSpan(text: "$label: "),
              TextSpan(
                text: isYes ? "YES (✓)" : "NO (✗)",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: isYes ? Colors.green.shade700 : Colors.red.shade700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
