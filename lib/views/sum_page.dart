import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tugasaplikasitpm/main.dart';
import 'package:tugasaplikasitpm/models/menu_model.dart';

class SumPage extends StatefulWidget {
  final MenuModel menuData;
  const SumPage({super.key, required this.menuData});

  @override
  State<SumPage> createState() => _SumPageState();
}

class _SumPageState extends State<SumPage> {
  final TextEditingController _textController = TextEditingController();
  int _result = 0;

  void _calculateLength() {
    String rawText = _textController.text;

    // 1. Handling Input Kosong atau Hanya Spasi
    if (rawText.trim().isEmpty) {
      _showSnack(
        "Teks tidak boleh kosong! Silakan ketik sesuatu.",
        Colors.red.shade700,
      );
      setState(() {
        _result = 0;
      });
      return;
    }

    // 2. Handling Limit Memori/Performa
    if (rawText.length > 50000) {
      _showSnack(
        "Teks terlalu panjang! Maksimal 50.000 karakter.",
        Colors.orange.shade900,
      );
      return;
    }

    // 3. Eksekusi Hasil
    setState(() {
      _result = RegExp(r'[0-9]').allMatches(rawText).length;
      
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
    _textController.dispose();
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
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const SizedBox(height: 30),

              SvgPicture.asset(widget.menuData.iconPath, height: 110),
              const SizedBox(height: 10),

              const Text(
                "Masukkan teks yang ingin dihitung jumlah angka (0-9) di dalamnya:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.dark,
                ),
              ),
              const SizedBox(height: 10),

              TextField(
                controller: _textController,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                style: const TextStyle(fontSize: 16, color: AppColors.dark),
                decoration: InputDecoration(
                  hintText: "Contoh: Halo123, ini adalah tes456!",
                  hintStyle: TextStyle(
                    color: AppColors.dark.withValues(alpha: 0.3),
                  ),
                  contentPadding: const EdgeInsets.all(20),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.dark,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.dark,
                      width: 2.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _calculateLength,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.navy,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "HITUNG (Σ)",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                "Hasil Penghitungan (Σ):",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.dark,
                ),
              ),
              const SizedBox(height: 10),

              Text(
                _result.toString(),
                style: const TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.w900,
                  color: AppColors.dark,
                  fontFamily: 'Courier',
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
