class RFIDLog {
  final String uid;
  final DateTime timestamp;
  final bool isAuthorized;
  final String? holderName;

  RFIDLog({
    required this.uid,
    required this.timestamp,
    required this.isAuthorized,
    this.holderName
  });

  // تحويل السجل إلى خريطة (مفيد للتخزين)
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'timestamp': timestamp.toIso8601String(),
      'isAuthorized': isAuthorized,
      'holderName': holderName
    };
  }

  // إنشاء سجل من خريطة
  factory RFIDLog.fromMap(Map<String, dynamic> map) {
    return RFIDLog(
      uid: map['uid'],
      timestamp: DateTime.parse(map['timestamp']),
      isAuthorized: map['isAuthorized'],
      holderName: map['holderName']
    );
  }

  @override
  String toString() {
    return '''
    معرف البطاقة: $uid
    الوقت: $timestamp
    الحالة: ${isAuthorized ? 'مقبولة' : 'مرفوضة'}
    اسم الحامل: ${holderName ?? 'غير معروف'}
    ''';
  }
}

class RFIDLogManager {
  static final List<RFIDLog> _logs = [];

  // إضافة سجل جديد
  static void addLog(RFIDLog log) {
    _logs.add(log);
    // يمكن إضافة منطق تخزين في ملف أو قاعدة بيانات لاحقًا
  }

  // استرجاع جميع السجلات
  static List<RFIDLog> getAllLogs() {
    return List.unmodifiable(_logs);
  }

  // استرجاع السجلات المقبولة فقط
  static List<RFIDLog> getAuthorizedLogs() {
    return _logs.where((log) => log.isAuthorized).toList();
  }

  // استرجاع السجلات المرفوضة
  static List<RFIDLog> getRejectedLogs() {
    return _logs.where((log) => !log.isAuthorized).toList();
  }

  // مسح جميع السجلات
  static void clearLogs() {
    _logs.clear();
  }
}
