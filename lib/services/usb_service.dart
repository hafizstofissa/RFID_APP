import 'dart:typed_data';
import 'package:usb_serial/usb_serial.dart';
import 'package:convert/convert.dart';
import '../models/rfid_card.dart';

class RFIDUsbService {
  UsbPort? _port;
  bool _isConnected = false;

  Future<bool> connect() async {
    try {
      List<UsbDevice> devices = await UsbSerial.listDevices();

      if (devices.isEmpty) {
        print('❌ لا توجد أجهزة USB متصلة');
        return false;
      }

      // اختيار الجهاز الأول
      UsbDevice selectedDevice = devices.first;

      _port = await selectedDevice.open();

      if (_port == null) {
        print('❌ فشل فتح المنفذ');
        return false;
      }

      // إعدادات المنفذ
      await _port!.setDTR(true);
      await _port!.setRTS(true);

      _port!.setPortParameters(
          9600, UsbPort.DATABITS_8, UsbPort.STOPBITS_1, UsbPort.PARITY_NONE);

      _isConnected = true;
      print('✅ تم الاتصال بالجهاز بنجاح');
      return true;
    } catch (e) {
      print('❌ خطأ في الاتصال: $e');
      return false;
    }
  }

  Stream<RFIDCard> listenToRFIDCards() {
    if (!_isConnected) throw Exception('❌ USB غير متصل');

    return _port!.inputStream!.map((Uint8List data) {
      // تحويل البيانات الواردة إلى UID
      String uid = hex.encode(data);
      RFIDCard? card = RFIDCard.findCard(uid);

      return card ??
          RFIDCard(
              uid: uid,
              isAuthorized: _checkAuthorization(uid),
              holderName: 'غير معروف',
              department: 'غير محدد',
              year: 'غير محدد',
              imagePath: 'assets/images/default_card.png');
    });
  }

  bool _checkAuthorization(String uid) {
    // استخدام طريقة التحقق من الفئة RFIDCard
    return RFIDCard.validateCard(uid);
  }

  void disconnect() {
    _port?.close();
    _isConnected = false;
    print('❌ تم قطع الاتصال');
  }
}

extension on UsbDevice {
  open() {}
}
