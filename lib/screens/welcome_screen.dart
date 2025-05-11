import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

class WelcomeScreen extends StatefulWidget {
  final String studentName;
  final String imagePath;

  const WelcomeScreen(
      {Key? key, required this.studentName, required this.imagePath})
      : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // إعداد التحريك
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
      ),
    );

    // بدء التحريك
    _animationController.forward();

    // إغلاق الشاشة بعد 5 ثواني
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pop();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode 
        ? Color(0xFF121212).withOpacity(0.95) 
        : Colors.white.withOpacity(0.95),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // صورة خلفية الترحيب
          Image.asset(
            'assets/images/welcome.jpg',
            fit: BoxFit.cover,
            color: isDarkMode 
              ? Colors.black.withOpacity(0.8) 
              : Colors.black.withOpacity(0.6),
            colorBlendMode: BlendMode.darken,
          ),

          // محتوى الترحيب
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // صورة الطالب
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage(widget.imagePath),
                  ),
                ),

                const SizedBox(height: 30),

                // رسالة الترحيب
                Text(
                  'مرحبًا ${widget.studentName}!',
                  style: GoogleFonts.cairo(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // رسالة إضافية
                Text(
                  'تفضل بشرب شاي العصر 🍵',
                  style: GoogleFonts.cairo(
                    fontSize: 22,
                    color: Colors.white70,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),

                // رسالة مؤقتة
                Text(
                  'سيتم إغلاق هذه الشاشة تلقائيًا',
                  style: GoogleFonts.cairo(
                    fontSize: 14,
                    color: Colors.white54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
