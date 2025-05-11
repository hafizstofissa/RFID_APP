import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rfid_reader_app/models/rfid_card.dart';
import '../services/usb_service.dart';

class CardReaderScreen extends StatefulWidget {
  const CardReaderScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CardReaderScreenState createState() => _CardReaderScreenState();
}

class _CardReaderScreenState extends State<CardReaderScreen> {
  final RFIDUsbService _usbService = RFIDUsbService();
  bool _isConnected = false;

  @override
  void initState() {
    super.initState();
    _connectToUsb();
  }

  void _connectToUsb() async {
    bool connected = await _usbService.connect();
    if (connected) {
      _usbService.listenToRFIDCards().listen((RFIDCard card) {
        setState(() {
          _showCardDetailsDialog(card);
        });
      });
      setState(() {
        _isConnected = true;
      });
    } else {
      _showErrorDialog('فشل الاتصال بقارئ RFID');
    }
  }

  Widget _showCardDetailsDialog(RFIDCard card) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return AlertDialog(
      backgroundColor: isDarkMode ? Color(0xFF1A1A1A) : Colors.white,
      title: Text(
        'تفاصيل البطاقة',
        style: GoogleFonts.cairo(
          color: isDarkMode ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'معرف البطاقة: ${card.uid}',
              style: GoogleFonts.cairo(
                color: isDarkMode ? Colors.white70 : Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              card.isAuthorized
                  ? 'البطاقة مقبولة يا معلم'
                  : ' البطاقة مرفوضة يا معلم',
              style: GoogleFonts.cairo(
                color: card.isAuthorized ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
              maxLines: null,
              overflow: TextOverflow.visible,
            ),
            const SizedBox(height: 10),
            // إضافة المزيد من التفاصيل إذا لزم الأمر
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'إغلاق',
            style: GoogleFonts.cairo(
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('خطأ'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('حسنًا'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('قارئ RFID'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _isConnected ? Icons.usb_rounded : Icons.usb_off_rounded,
              size: 100,
              color: _isConnected ? Colors.green : Colors.red,
            ),
            const SizedBox(height: 20),
            Text(
              _isConnected ? 'متصل بقارئ RFID' : 'غير متصل بقارئ RFID',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: _isConnected ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _connectToUsb,
              child: const Text('إعادة الاتصال'),
            ),
          ],
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
