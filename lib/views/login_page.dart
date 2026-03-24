import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tugasaplikasitpm/main.dart';
import 'package:tugasaplikasitpm/models/user_model.dart';
import 'package:tugasaplikasitpm/views/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;

  // login logic
void _handleLogin() {
    String usernameInput = _usernameController.text.trim();
    String passwordInput = _passwordController.text.trim();

    if (usernameInput.isEmpty || passwordInput.isEmpty) {
      _showSnack("Username dan Password wajib diisi!", Colors.red.shade700);
      return;
    }

    // 3. Logika Pencarian User dengan Handling jika tidak ketemu
    try {
      final userExists = UserModel.groupData.where(
        (u) => u.username == usernameInput && u.nim == passwordInput,
      );

      if (userExists.isNotEmpty) {
        UserModel user = userExists.first;
        _showSnack("Selamat datang, ${user.username}!", Colors.green.shade700);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage(loginUser: user)),
        );
      } else {
        _showSnack("Username atau Password salah!", Colors.red.shade700);
      }
    } catch (e) {
      _showSnack("Terjadi kesalahan sistem. Coba lagi.", Colors.grey);
    }
  }

  // Snackbar
  void _showSnack(String pesan, Color warna) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          pesan,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: warna,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        duration: const Duration(seconds: 2), 
      ),
    );
  }

  // Clear a memory
  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            top: 75,
            child: SvgPicture.asset(
              'assets/images/decoration.svg',
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
            ),
          ),

          // Main Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 80),
                    // Title
                    child: Text(
                      "LOGIN.",
                      style: AppTextStyles.heading.copyWith(
                        fontSize: 70,
                        letterSpacing: 8,
                      ),
                    ),
                  ),

                  const SizedBox(height: 90),

                  // Input
                  _buildInputGrup(),

                  const SizedBox(height: 40),

                  // Button Login
                  _buildCustomButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputGrup() {
    return CustomPaint(
      painter: FolderBorderPainter(),
      child: ClipPath(
        clipper: FolderClipper(),
        child: Container(
          color: AppColors.white,
          child: Column(
            children: [
              _buildInputField(
                label: "Username",
                controller: _usernameController,
              ),

              Container(height: 2, color: AppColors.dark),

              _buildInputField(
                label: "Password",
                controller: _passwordController,
                isPassword: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    bool isPassword = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.body.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          TextField(
            controller: controller,
            obscureText: isPassword ? _isObscure : false,
            cursorColor: AppColors.dark,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
              border: InputBorder.none,
              // prefixIcon: isPassword
              //     ? Icon(Icons.lock, size: 30)
              //     : Icon(Icons.person, size: 30),
              hintText: isPassword
                  ? "Masukan NIM anda"
                  : "Masukan username anda",
              suffixIcon: isPassword
                  ? IconButton(
                      onPressed: () => setState(() => _isObscure = !_isObscure),
                      icon: Icon(
                        _isObscure ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.dark,
                        size: 30,
                      ),
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ClipPath(
        clipper: ButtonCutClipper(),
        child: ElevatedButton(
          onPressed: _handleLogin,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.navy,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
          child: Text(
            "LOGIN",
            style: AppTextStyles.heading.copyWith(
              color: Colors.white,
              fontSize: 18,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
    );
  }
}

// clipper & painter
class FolderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double tabWidth = 110.0;
    double tabHeight = 25.0;
    double slope = 20.0;
    path.moveTo(0, tabHeight);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, tabHeight);
    path.lineTo(tabWidth + slope, tabHeight);
    path.lineTo(tabWidth, 0);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class FolderBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppColors.dark
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5;
    Path path = Path();
    double tabWidth = 110.0;
    double tabHeight = 25.0;
    double slope = 20.0;
    path.moveTo(0, tabHeight);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, tabHeight);
    path.lineTo(tabWidth + slope, tabHeight);
    path.lineTo(tabWidth, 0);
    path.lineTo(0, 0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class ButtonCutClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double cutSize = 15.0;
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - cutSize);
    path.lineTo(size.width - cutSize, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
