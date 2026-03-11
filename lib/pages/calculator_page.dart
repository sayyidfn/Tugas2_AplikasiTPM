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
    double num1 = double.tryParse(_num1Controller.text) ?? 0.0;
    double num2 = double.tryParse(_num2Controller.text) ?? 0.0;

    setState(() {
      if (isAddition) {
        _result = num1 + num2;
      } else {
        _result = num1 - num2;
      }
    });
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.dark,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.menuData.title,
          style: AppTextStyles.heading.copyWith(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: AppColors.dark,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const SizedBox(height: 60),

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
                  SizedBox(width: 30),
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
              const SizedBox(height: 30),

              const Text(
                "Masukkan Angka A dan B:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.dark,
                ),
              ),
              const SizedBox(height: 20),

              _buildTextField(_num1Controller, "Masukan angka A"),
              const SizedBox(height: 15),
              _buildTextField(_num2Controller, "Masukan angka B"),
              const SizedBox(height: 35),

              Row(
                children: [
                  Expanded(
                    child: _buildButton("TAMBAH (+)", () => _calculate(true)),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _buildButton("KURANG (-)", () => _calculate(false)),
                  ),
                ],
              ),
              const SizedBox(height: 50),

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

  Widget _buildTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.dark,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: AppColors.dark.withValues(
            alpha: 0.3,
          ),
          fontWeight: FontWeight.normal,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.dark, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.dark, width: 2.5),
        ),
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
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
