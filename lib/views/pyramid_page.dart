import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tugasaplikasitpm/main.dart';
import 'package:tugasaplikasitpm/models/menu_model.dart';
import 'dart:math';

class PyramidPage extends StatefulWidget {
  final MenuModel menuData;
  const PyramidPage({super.key, required this.menuData});

  @override
  State<PyramidPage> createState() => _PyramidPageState();
}

class _PyramidPageState extends State<PyramidPage> {
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  double? _volume;
  double? _surfaceArea;

  void _calculateAll() {
    String lText = _lengthController.text.trim();
    String wText = _widthController.text.trim();
    String hText = _heightController.text.trim();

    // 1. Handling Input Kosong
    if (lText.isEmpty || wText.isEmpty || hText.isEmpty) {
      _showSnack(
        "Semua kolom (Panjang, Lebar, Tinggi) wajib diisi!",
        Colors.red.shade700,
      );
      return;
    }

    // 2. Handling Format Angka (Validasi Huruf/Simbol)
    double? length = double.tryParse(lText);
    double? width = double.tryParse(wText);
    double? height = double.tryParse(hText);

    if (length == null || width == null || height == null) {
      _showSnack("Input harus berupa angka yang valid!", Colors.red.shade700);
      return;
    }

    // 3. Handling Nilai Nol atau Negatif (Penting untuk Geometri)
    if (length <= 0 || width <= 0 || height <= 0) {
      _showSnack(
        "Dimensi piramida harus lebih besar dari nol!",
        Colors.red.shade700,
      );
      return;
    }

    // 4. Perhitungan Utama
    setState(() {
      double baseArea = length * width;
      _volume = (1 / 3) * baseArea * height;

      double slantHeightLength = sqrt(pow(height, 2) + pow(width / 2, 2));
      double slantHeightWidth = sqrt(pow(height, 2) + pow(length / 2, 2));

      double uprightArea =
          (length * slantHeightLength) + (width * slantHeightWidth);
      _surfaceArea = baseArea + uprightArea;
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
    _lengthController.dispose();
    _widthController.dispose();
    _heightController.dispose();
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
              const SizedBox(height: 30),

              SvgPicture.asset(widget.menuData.iconPath, height: 160),
              const SizedBox(height: 20),

              _buildInputField(
                label: "Masukkan Panjang Alas:",
                controller: _lengthController,
              ),
              const SizedBox(height: 15),
              _buildInputField(
                label: "Masukkan Lebar Alas:",
                controller: _widthController,
              ),
              const SizedBox(height: 15),
              _buildInputField(
                label: "Masukkan Tinggi Piramida:",
                controller: _heightController,
              ),
              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _calculateAll,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.navy,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "HITUNG VOL & LUAS",
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

              if (_volume != null && _surfaceArea != null) ...[
                const Text(
                  "Volume Piramida:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.dark,
                  ),
                ),
                Text(
                  _volume!.toStringAsFixed(2),
                  style: const TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.w900,
                    color: AppColors.dark,
                    fontFamily: 'Courier',
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 20),

                const Text(
                  "Luas Permukaan:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.dark,
                  ),
                ),
                Text(
                  _surfaceArea!.toStringAsFixed(2),
                  style: const TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.w900,
                    color: AppColors.dark,
                    fontFamily: 'Courier',
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: AppColors.dark,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 50,
          child: TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.dark,
            ),
            decoration: InputDecoration(
              hintText: "Contoh: 10.5",
              hintStyle: TextStyle(
                color: AppColors.dark.withValues(alpha: 0.3),
                fontWeight: FontWeight.normal,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 0,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.dark, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.dark, width: 2.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
