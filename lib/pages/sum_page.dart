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
    if (_textController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "Teks tidak boleh kosong! Silahkan ketik sesuatu.",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red.shade600,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );

      setState(() {
        _result = 0;
      });
      return;
    }

    setState(() {
      _result = _textController.text.length;
    });
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
              const SizedBox(height: 60),

              SvgPicture.asset(widget.menuData.iconPath, height: 120),
              const SizedBox(height: 20),

              const Text(
                "Masukkan Teks",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.dark,
                ),
              ),
              const SizedBox(height: 15),

              TextField(
                controller: _textController,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                style: const TextStyle(fontSize: 16, color: AppColors.dark),
                decoration: InputDecoration(
                  hintText: "Ketik teks di sini...",
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
              const SizedBox(height: 25),

              GestureDetector(
                onTap: _calculateLength,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  decoration: BoxDecoration(
                    color: AppColors.navy,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "HITUNG (Σ)",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),

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
