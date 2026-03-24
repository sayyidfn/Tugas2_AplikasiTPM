import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:tugasaplikasitpm/main.dart';
import 'package:tugasaplikasitpm/models/menu_model.dart';

class DateConversionPage extends StatefulWidget {
  final MenuModel menuData;
  const DateConversionPage({super.key, required this.menuData});

  @override
  State<DateConversionPage> createState() => _DateConversionPageState();
}

class _DateConversionPageState extends State<DateConversionPage> {
  DateTime? _selectedDate;

  bool _isCalculated = false;
  String _wetonResult = "-";
  String _umurTahun = "0", _umurBulan = "0", _umurHari = "0", _umurJam = "0";
  String _hijriahResult = "-";

  // Fungsi untuk memunculkan kalender
  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.navy,
              onPrimary: Colors.white,
              onSurface: AppColors.dark,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _isCalculated = false;
      });
    }
  }

  // Fungsi utama perhitungan
  void _calculateAll() {
    // 1. Handling Input Kosong
    if (_selectedDate == null) {
      _showSnack(
        "Silakan pilih tanggal kejadian atau lahir terlebih dahulu!",
        Colors.red.shade700,
      );
      return;
    }

    DateTime now = DateTime.now();

    // 2. Handling Masa Depan (Validasi Tambahan)
    if (_selectedDate!.isAfter(now)) {
      _showSnack(
        "Tanggal tidak boleh melebihi waktu hari ini!",
        Colors.orange.shade900,
      );
      return;
    }

    setState(() {
      // Weton
      const hariArray = [
        'Senin',
        'Selasa',
        'Rabu',
        'Kamis',
        'Jumat',
        'Sabtu',
        'Minggu',
      ];
      String hari = hariArray[_selectedDate!.weekday - 1];

      const pasaranArray = ['Legi', 'Pahing', 'Pon', 'Wage', 'Kliwon'];
      DateTime patokan = DateTime(1945, 8, 17); // Patokan Jumat Legi

      int selisihHari = _selectedDate!.difference(patokan).inDays;
      int pasaranIndex = selisihHari % 5;
      if (pasaranIndex < 0) pasaranIndex += 5;

      String pasaran = pasaranArray[pasaranIndex];
      _wetonResult = "$hari / $pasaran";

      // Detail umur
      int y = now.year - _selectedDate!.year;
      int m = now.month - _selectedDate!.month;
      int d = now.day - _selectedDate!.day;

      if (d < 0) {
        m--;
        int daysInLastMonth = DateTime(now.year, now.month, 0).day;
        d += daysInLastMonth;
      }
      if (m < 0) {
        y--;
        m += 12;
      }
      int h = now.hour;

      _umurTahun = y.toString();
      _umurBulan = m.toString();
      _umurHari = d.toString();
      _umurJam = h.toString();

      // Hijriah
      HijriCalendar.setLocal('id');
      HijriCalendar hijriDate = HijriCalendar.fromDate(_selectedDate!);
      _hijriahResult =
          "${hijriDate.hDay} ${hijriDate.getLongMonthName()} ${hijriDate.hYear} H";

      _isCalculated = true;
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
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30),

              SvgPicture.asset(widget.menuData.iconPath, height: 140),
              const SizedBox(height: 30),

              const Text(
                "Pilih Tanggal Kejadian/Lahir:",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.dark,
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _pickDate,
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white, // Menandakan bisa diisi
                    border: Border.all(color: AppColors.dark, width: 1.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedDate == null
                            ? "Contoh: 17/08/1945"
                            : "${_selectedDate!.day.toString().padLeft(2, '0')} / ${_selectedDate!.month.toString().padLeft(2, '0')} / ${_selectedDate!.year}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: _selectedDate == null
                              ? FontWeight.normal
                              : FontWeight.bold,
                          color: _selectedDate == null
                              ? AppColors.dark.withValues(alpha: 0.3)
                              : AppColors.dark,
                        ),
                      ),
                      Icon(
                        Icons.calendar_month,
                        color: AppColors.dark.withValues(alpha: 0.7),
                      ),
                    ],
                  ),
                ),
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
                    "HITUNG DETAIL",
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

              if (_isCalculated) ...[
                _buildResultCard(
                  title: "Hari & Weton",
                  content: Text(
                    _wetonResult,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: AppColors.dark,
                      fontFamily: 'Courier',
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                _buildResultCard(
                  title: "Umur Detail",
                  content: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildUmurGridItem(_umurTahun, "Tahun"),
                          ),
                          Expanded(
                            child: _buildUmurGridItem(_umurBulan, "Bulan"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: _buildUmurGridItem(_umurHari, "Hari"),
                          ),
                          Expanded(child: _buildUmurGridItem(_umurJam, "Jam")),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),

                _buildResultCard(
                  title: "Kalender Hijriah",
                  content: Text(
                    _hijriahResult,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: AppColors.dark,
                    ),
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

  Widget _buildResultCard({required String title, required Widget content}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.dark, width: 2),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: AppColors.dark, offset: Offset(0, 4), blurRadius: 0),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),
          content,
        ],
      ),
    );
  }

  Widget _buildUmurGridItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w900,
            color: AppColors.dark,
            fontFamily: 'Courier',
            height: 1.1,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.dark,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
