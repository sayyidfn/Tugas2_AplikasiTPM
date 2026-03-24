import 'package:flutter/material.dart';
import 'package:tugasaplikasitpm/main.dart';
import 'package:tugasaplikasitpm/models/menu_model.dart';

class CalculatorPage extends StatefulWidget {
  final MenuModel menuData;
  const CalculatorPage({super.key, required this.menuData});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final TextEditingController _num1Controller = TextEditingController();
  final TextEditingController _num2Controller = TextEditingController();

  double _result = 0.0;

  void _calculate(bool isAddition) {
    String rawNum1 = _num1Controller.text.trim();
    String rawNum2 = _num2Controller.text.trim();

    // Cek Kosong
    if (rawNum1.isEmpty || rawNum2.isEmpty) {
      _showSnack(
        "Angka A dan Angka B tidak boleh kosong!",
        Colors.red.shade700,
      );
      return;
    }

    // Parsing dan Cek Validitas Angka
    double? num1 = double.tryParse(rawNum1);
    double? num2 = double.tryParse(rawNum2);

    // Jika salah satu null, berarti input bukan angka valid
    if (num1 == null || num2 == null) {
      _showSnack(
        "Input harus berupa angka! Jangan masukkan huruf atau simbol.",
        Colors.red.shade900,
      );
      return;
    }

    // Jika Valid, baru jalankan setState
    setState(() {
      if (isAddition) {
        _result = num1 + num2;
      } else {
        _result = num1 - num2;
      }
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
    _num1Controller.dispose();
    _num2Controller.dispose();
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

              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "+",
                    style: TextStyle(
                      fontSize: 100,
                      fontWeight: FontWeight.w900,
                      color: AppColors.dark,
                      height: 1,
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    "-",
                    style: TextStyle(
                      fontSize: 120,
                      fontWeight: FontWeight.w900,
                      color: AppColors.dark,
                      height: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              const Text(
                "Masukkan Angka A dan B:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.dark,
                ),
              ),
              const SizedBox(height: 10),

              _buildTextField(_num1Controller),
              const SizedBox(height: 10),
              _buildTextField(_num2Controller),
              const SizedBox(height: 25),

              Row(
                children: [
                  Expanded(
                    child: _buildButton("TAMBAH (+)", () => _calculate(true)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildButton("KURANG (-)", () => _calculate(false)),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              const Text(
                "Hasil Operasi:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.dark,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                _result.toString(),
                style: const TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.w900,
                  color: AppColors.dark,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller) {
    return SizedBox(
      height: 50,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.dark,
        ),
        decoration: InputDecoration(
          hintText: "Contoh: 99.2",
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
    );
  }

  Widget _buildButton(String text, VoidCallback onTap) {
    return SizedBox(
      height: 55,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.navy,
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
