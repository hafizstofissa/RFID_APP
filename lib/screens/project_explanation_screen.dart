import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectExplanationScreen extends StatelessWidget {
  const ProjectExplanationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'شرح المشروع',
          style: GoogleFonts.cairo(
            color: isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: isDarkMode ? Color(0xFF1A1A1A) : Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDarkMode
              ? [Color(0xFF121212), Color(0xFF1E1E1E)]
              : [Color(0xFFF5F5F5), Color(0xFFE0E0E0)],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Project Introduction
              Text(
                'مقدمة المشروع',
                style: GoogleFonts.cairo(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.blue[200] : Colors.blue[800],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'مشروع نظام قراءة RFID هو حل مبتكر لتتبع وإدارة المعلومات باستخدام تقنية التعريف عن طريق الترددات الراديوية.',
                style: GoogleFonts.cairo(
                  fontSize: 16,
                  color: isDarkMode ? Colors.white70 : Colors.black87,
                ),
                textAlign: TextAlign.justify,
                maxLines: null,
                overflow: TextOverflow.visible,
              ),

              // Components
              const SizedBox(height: 20),
              Text(
                'المكونات الرئيسية',
                style: GoogleFonts.cairo(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.blue[200] : Colors.blue[800],
                ),
              ),
              const SizedBox(height: 10),
              _buildComponentItem('قارئ RFID (RC522)', isDarkMode),
              _buildComponentItem('متحكم ATmega2560', isDarkMode),
              _buildComponentItem('تطبيق Flutter', isDarkMode),

              // Working Method
              const SizedBox(height: 20),
              Text(
                'طريقة العمل',
                style: GoogleFonts.cairo(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.blue[200] : Colors.blue[800],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '1. يتم توصيل قارئ RFID بالمتحكم ATmega2560 عبر واجهة SPI.',
                style: GoogleFonts.cairo(
                  fontSize: 16,
                  color: isDarkMode ? Colors.white70 : Colors.black87,
                ),
              ),
              Text(
                '2. يقوم القارئ بقراءة معرف الوسيط (UID).',
                style: GoogleFonts.cairo(
                  fontSize: 16,
                  color: isDarkMode ? Colors.white70 : Colors.black87,
                ),
              ),
              Text(
                '3. يتم نقل البيانات إلى التطبيق عبر اتصال USB.',
                style: GoogleFonts.cairo(
                  fontSize: 16,
                  color: isDarkMode ? Colors.white70 : Colors.black87,
                ),
              ),

              // Challenges
              const SizedBox(height: 20),
              Text(
                'التحديات',
                style: GoogleFonts.cairo(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.blue[200] : Colors.blue[800],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'واجه الفريق تحديات في التواصل بين المكونات المختلفة، وتم حلها من خلال استخدام بروتوكولات اتصال موثوقة.',
                style: GoogleFonts.cairo(
                  fontSize: 16,
                  color: isDarkMode ? Colors.white70 : Colors.black87,
                ),
                textAlign: TextAlign.justify,
                maxLines: null,
                overflow: TextOverflow.visible,
              ),

              // Diagrams
              const SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    Text(
                      'مخطط نظام قراءة RFID',
                      style: GoogleFonts.cairo(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isDarkMode ? Colors.blue[200]! : Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          _buildConnectionStep('قارئ RFID (RC522)', Icons.nfc, isDarkMode),
                          Icon(Icons.arrow_downward, color: isDarkMode ? Colors.blue[200] : Colors.blue),
                          _buildConnectionStep('متحكم ATmega2560', Icons.memory, isDarkMode),
                          Icon(Icons.arrow_downward, color: isDarkMode ? Colors.blue[200] : Colors.blue),
                          _buildConnectionStep('اتصال USB', Icons.usb, isDarkMode),
                          Icon(Icons.arrow_downward, color: isDarkMode ? Colors.blue[200] : Colors.blue),
                          _buildConnectionStep('تطبيق Flutter', Icons.phone_android, isDarkMode),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildComponentItem(String text, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(
            Icons.check_circle, 
            color: isDarkMode ? Colors.green[200] : Colors.green,
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: GoogleFonts.cairo(
              fontSize: 16,
              color: isDarkMode ? Colors.white70 : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConnectionStep(String text, IconData icon, bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: isDarkMode ? Color(0xFF2C2C2C) : Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon, 
            color: isDarkMode ? Colors.blue[200] : Colors.blue,
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: GoogleFonts.cairo(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white70 : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
