import 'package:flutter/material.dart';
import 'package:rfid_reader_app/models/rfid_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import '../services/usb_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RFIDUsbService _usbService = RFIDUsbService();
  RFIDCard? _lastCard;
  bool _isReading = false;
  bool _isUsbConnected = false;

  void _connectToUsb() async {
    bool connected = await _usbService.connect();
    setState(() {
      _isUsbConnected = connected;
    });
    if (connected) {
      _usbService.listenToRFIDCards().listen((card) {
        setState(() {
          _lastCard = card;
          
          // إضافة رسالة منبثقة لحالة البطاقة
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                card.isAuthorized 
                  ? 'البطاقة مقبولة يا معلم' 
                  : 'البطاقة مرفوضة يا معلم',
                style: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: card.isAuthorized 
                ? Colors.green 
                : Colors.red,
              duration: Duration(seconds: 3),
            ),
          );
        });
      });
    }
  }

  void _startReading() async {
    setState(() {
      _isReading = true;
    });

    try {
      bool connected = await _usbService.connect();
      setState(() {
        _isUsbConnected = connected;
      });
      if (connected) {
        // يمكنك إضافة منطق إضافي للقراءة هنا إذا لزم الأمر
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'فشل الاتصال بقارئ RFID',
              style: GoogleFonts.cairo(),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'حدث خطأ أثناء القراءة: $e',
            style: GoogleFonts.cairo(),
          ),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isReading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _connectToUsb();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'نظام قراءة RFID',
          style: GoogleFonts.cairo(
            color: isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: isDarkMode ? Color(0xFF1A1A1A) : Colors.white,
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
          child: Column(
            children: [
              // شعار الجامعة
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: FadeIn(
                  child: Image.asset(
                    'assets/images/1.jpeg',
                    height: 120,
                    width: 120,
                  ),
                ),
              ),

              // معلومات النظام
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: isDarkMode ? Color(0xFF2C2C2C) : Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          'نظام إدارة بطاقات RFID',
                          style: GoogleFonts.cairo(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'نظام متكامل لإدارة وتتبع البطاقات الذكية',
                          style: GoogleFonts.cairo(
                            fontSize: 16,
                            color: isDarkMode ? Colors.white70 : Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              // حالة اتصال USB
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: isDarkMode ? Color(0xFF2C2C2C) : Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _isUsbConnected ? Icons.usb : Icons.usb_off,
                          color: _isUsbConnected 
                            ? (isDarkMode ? Colors.green[200] : Colors.green)
                            : (isDarkMode ? Colors.red[200] : Colors.red),
                        ),
                        SizedBox(width: 10),
                        Text(
                          _isUsbConnected ? 'متصل بوصلة USB' : 'غير متصل بوصلة USB',
                          style: GoogleFonts.cairo(
                            color: isDarkMode ? Colors.white70 : Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              // زر القراءة
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton.icon(
                  onPressed: _isReading || !_isUsbConnected ? null : _startReading,
                  icon: _isReading 
                    ? SizedBox(
                        width: 24, 
                        height: 24, 
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      )
                    : Icon(Icons.nfc, color: Colors.white),
                  label: Text(
                    _isReading 
                      ? 'جاري القراءة...' 
                      : (_isUsbConnected ? 'بدء القراءة' : 'اتصل بـ USB أولاً'),
                    style: GoogleFonts.cairo(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDarkMode 
                      ? Colors.blue[800] 
                      : Colors.blue[600],
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              // معلومات البطاقة
              Center(
                child: _lastCard != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'آخر بطاقة تم قراءتها',
                            style: GoogleFonts.cairo(
                              color: isDarkMode ? Colors.white : Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'معرف البطاقة: ${_lastCard!.uid}',
                            style: GoogleFonts.cairo(
                              color: isDarkMode ? Colors.white70 : Colors.black87,
                              fontSize: 16,
                            ),
                            maxLines: null,
                            overflow: TextOverflow.visible,
                          ),
                          SizedBox(height: 10),
                          Text(
                            _lastCard!.isAuthorized
                                ? 'البطاقة مقبولة يا معلم'
                                : 'البطاقة مرفوضة يا معلم',
                            style: GoogleFonts.cairo(
                              color: _lastCard!.isAuthorized
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: null,
                            overflow: TextOverflow.visible,
                          ),
                        ],
                      )
                    : Text(
                        'لم يتم قراءة أي بطاقة بعد',
                        style: GoogleFonts.cairo(
                          color: isDarkMode ? Colors.white70 : Colors.black87,
                        ),
                      ),
              ),

              // معلومات إضافية
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'تم تطوير النظام بواسطة فريق هندسة المعلوماتية',
                  style: GoogleFonts.cairo(
                    fontSize: 14,
                    color: isDarkMode ? Colors.white54 : Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usbService.disconnect();
    super.dispose();
  }
}
