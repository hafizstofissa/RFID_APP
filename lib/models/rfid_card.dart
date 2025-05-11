class RFIDCard {
  final String uid;
  final String holderName;
  final bool isAuthorized;
  final String department;
  final String year;
  final String imagePath;

  RFIDCard(
      {required this.uid,
      required this.holderName,
      this.isAuthorized = false,
      required this.department,
      required this.year,
      required this.imagePath});

  // قائمة البطاقات المعتمدة
  static List<RFIDCard> authorizedCards = [
    RFIDCard(
        uid: 'A1B2C3D4',
        holderName: 'حافظ العيسى',
        isAuthorized: true,
        department: 'هندسة الحاسبات',
        year: '2023',
        imagePath: 'assets/images/student1.jpg'),
    RFIDCard(
        uid: 'E5F6G7H8',
        holderName: 'عمار جيلو',
        isAuthorized: true,
        department: 'هندسة الإلكترونيات',
        year: '2022',
        imagePath: 'assets/images/student2.jpg')
  ];

  // التحقق من صحة البطاقة
  static bool validateCard(String scannedUid) {
    return authorizedCards
        .any((card) => card.uid == scannedUid && card.isAuthorized);
  }

  // البحث عن تفاصيل البطاقة
  static RFIDCard? findCard(String scannedUid) {
    try {
      return authorizedCards.firstWhere((card) => card.uid == scannedUid);
    } catch (e) {
      return null;
    }
  }
}
