import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/rfid_log.dart';

class RFIDLogsScreen extends StatefulWidget {
  const RFIDLogsScreen({super.key});

  @override
  _RFIDLogsScreenState createState() => _RFIDLogsScreenState();
}

class _RFIDLogsScreenState extends State<RFIDLogsScreen> {
  List<RFIDLog> _logs = [];
  bool _showOnlyAuthorized = false;

  @override
  void initState() {
    super.initState();
    _loadLogs();
  }

  void _loadLogs() {
    setState(() {
      _logs = _showOnlyAuthorized 
        ? RFIDLogManager.getAuthorizedLogs() 
        : RFIDLogManager.getAllLogs();
    });
  }

  void _showClearLogsDialog() {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isDarkMode ? Color(0xFF1A1A1A) : Colors.white,
          title: Text(
            'مسح السجلات',
            style: GoogleFonts.cairo(
              color: isDarkMode ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          content: Text(
            'هل أنت متأكد من مسح جميع السجلات؟',
            style: GoogleFonts.cairo(
              color: isDarkMode ? Colors.white70 : Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                RFIDLogManager.clearLogs();
                _loadLogs();
                Navigator.of(context).pop();
              },
              child: Text(
                'نعم',
                style: GoogleFonts.cairo(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'إلغاء',
                style: GoogleFonts.cairo(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'سجل قراءات RFID',
          style: GoogleFonts.cairo(
            color: isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: isDarkMode ? Color(0xFF1A1A1A) : Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              Icons.clear_all,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            tooltip: 'مسح السجلات',
            onPressed: _showClearLogsDialog,
          )
        ],
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
        child: Column(
          children: [
            SwitchListTile(
              title: Text(
                'عرض البطاقات المقبولة فقط',
                style: GoogleFonts.cairo(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              value: _showOnlyAuthorized,
              onChanged: (bool value) {
                setState(() {
                  _showOnlyAuthorized = value;
                  _loadLogs();
                });
              },
              activeColor: isDarkMode ? Colors.blue[200] : Colors.blue,
            ),
            Expanded(
              child: _logs.isEmpty
                ? Center(
                    child: Text(
                      'لا توجد سجلات',
                      style: GoogleFonts.cairo(
                        color: isDarkMode ? Colors.white70 : Colors.black87,
                        fontSize: 18,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: _logs.length,
                    itemBuilder: (context, index) {
                      final log = _logs[_logs.length - 1 - index]; // عكس الترتيب
                      return Card(
                        color: isDarkMode 
                          ? (log.isAuthorized ? Colors.green[900] : Colors.red[900]) 
                          : (log.isAuthorized ? Colors.green[100] : Colors.red[100]),
                        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: ListTile(
                          title: Text(
                            log.holderName ?? 'بطاقة مجهولة',
                            style: GoogleFonts.cairo(
                              color: isDarkMode ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'معرف البطاقة: ${log.uid}',
                                style: GoogleFonts.cairo(
                                  color: isDarkMode ? Colors.white70 : Colors.black87,
                                ),
                              ),
                              Text(
                                'الوقت: ${_formatDateTime(log.timestamp)}',
                                style: GoogleFonts.cairo(
                                  color: isDarkMode ? Colors.white70 : Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          trailing: Icon(
                            log.isAuthorized ? Icons.check_circle : Icons.cancel,
                            color: log.isAuthorized ? Colors.green : Colors.red,
                          ),
                        ),
                      );
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}/${dateTime.month}/${dateTime.day} ${dateTime.hour}:${dateTime.minute}';
  }
}
