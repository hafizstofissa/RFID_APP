import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_fonts/google_fonts.dart';

class CodeExplanationScreen extends StatefulWidget {
  const CodeExplanationScreen({super.key});

  @override
  _CodeExplanationScreenState createState() => _CodeExplanationScreenState();
}

class _CodeExplanationScreenState extends State<CodeExplanationScreen> {
  String _codeContent = '';
  String _codeExplanation = '';

  @override
  void initState() {
    super.initState();
    _loadCodeContent();
  }

  Future<void> _loadCodeContent() async {
    try {
      final code = await rootBundle.loadString('assets/code/rfid_code.c');
      final explanation =
          await rootBundle.loadString('assets/code/code_explanation.txt');

      setState(() {
        _codeContent = code;
        _codeExplanation = explanation;
      });
    } catch (e) {
      setState(() {
        _codeContent = 'فشل تحميل الكود';
        _codeExplanation = 'فشل تحميل الشرح';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الكود والشرح',
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
              // Code Section
              Text(
                'الكود المصدري',
                style: GoogleFonts.cairo(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.blue[200] : Colors.blue[800],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: isDarkMode ? Color(0xFF2C2C2C) : Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    _codeContent,
                    style: GoogleFonts.courierPrime(
                      fontSize: 14,
                      color: isDarkMode ? Colors.white70 : Colors.black87,
                    ),
                    textDirection: TextDirection.ltr,
                  ),
                ),
              ),

              // Code Explanation
              const SizedBox(height: 20),
              Text(
                'شرح الكود',
                style: GoogleFonts.cairo(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.blue[200] : Colors.blue[800],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _codeExplanation,
                style: GoogleFonts.cairo(
                  fontSize: 16,
                  color: isDarkMode ? Colors.white70 : Colors.black87,
                ),
                textAlign: TextAlign.justify,
                maxLines: null,
                overflow: TextOverflow.visible,
              ),

              // Examples
              const SizedBox(height: 20),
              Text(
                'أمثلة',
                style: GoogleFonts.cairo(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.blue[200] : Colors.blue[800],
                ),
              ),
              const SizedBox(height: 10),
              _buildExampleItem(
                'قراءة UID',
                'يتم استخدام دالة MFRC522_ReadUID() لاستخراج المعرف الفريد للوسيط.',
                isDarkMode,
              ),
              _buildExampleItem(
                'إرسال البيانات',
                'يتم نقل البيانات إلى التطبيق باستخدام وصلة USB',
                isDarkMode,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExampleItem(String title, String description, bool isDarkMode) {
    return Card(
      color: isDarkMode ? Color(0xFF2C2C2C) : Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        title: Text(
          title,
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.blue[200] : Colors.blue[700],
          ),
        ),
        subtitle: Text(
          description,
          style: GoogleFonts.cairo(
            color: isDarkMode ? Colors.white70 : Colors.black87,
          ),
        ),
      ),
    );
  }
}
