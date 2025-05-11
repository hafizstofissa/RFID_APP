import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({Key? key}) : super(key: key);

  @override
  _StudentsScreenState createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // قائمة الطلاب مع معلوماتهم
  final List<Map<String, dynamic>> students = [
    {
      'name': 'حافظ العيسى',
      'title': 'طالب هندسة معلوماتية',
      'image': 'assets/images/student1.jpg',
      'description':
          'طالب هندسة معلوماتية يلقب بأبو طلحة 60 لكثرت المواد التي رفعها بالستينات\n'
              'مهتم بتطوير تطبيقات الهاتف المحمول\n'
              'لديه شغف كبير بالبرمجة وتصميم الأنظمة المدمجة ويحب الغنم والخيل والحياة البرية ومن اقواله المؤثورة شلونكم ، آني جعد أستعمل الوتس',
      'contact': {'phone': '+352 681 598 957'}
    },
    {
      'name': 'عمار جيلو',
      'title': 'طالب هندسة معلوماتية',
      'image': 'assets/images/student2.jpg',
      'description':
          'طالب هندسة معلوماتية راقي يحب الشاي يسمع طرب قديم يشبه الزير ومن اقواله المؤثورة حطلها ليس وماعنا خبز\n'
              'متخصص في تطوير الأنظمة الذكية\n'
              'لديه مهارات متميزة في البرمجة وتحليل البيانات',
      'contact': {'phone': '+44 7310 642223'}
    }
  ];

  // قائمة المشرفين
  final List<Map<String, dynamic>> supervisors = [
    {
      'name': 'د. عبدالقادر غزال',
      'title': 'المشرف الأكاديمي',
      'image': 'assets/images/akaleir.jpg',
      'description': 'دكتور في قسم هندسة المعلوماتية بجامعة حلب\n'
          ' خبرة أكثر من 20 عامًا في مجال التدريس يحتاج الطالب ان يكون راضية عليه امه وابوه والامم جمعاء مشان ينجح المادة واحتمال ترسب ومن اقواله المؤثورة كن المسلم الذي تحب أن تراه وتتعامل معه',
      'contact': {'phone': '+963 123 456 789'}
    },
    {
      'name': 'م. محمد نور بدوي',
      'title': 'المشرف الفني',
      'image': 'assets/images/mohamdnor.jpg',
      'description': 'مهندس متخصص في UI UX \n'
          'خبرة في تصميم وتطوير التطبيقات الالكترونية\n'
          'مهتم بفعل الخير وراقي راقي لدرجة القبول ومن اقواله المؤثورة لا يستهيننّ أحدٌ منكم بنفسه، ولا يتركنّ حمل مسؤولية الأمّة لغيره، فالأيام تمضي، والمستقبل قريب، والعمر قصير، والأمة تنتظركم✌️',
      'contact': {'phone': '+90 531 508 45 95 '}
    }
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildPersonCard(Map<String, dynamic> person, bool isDarkMode) {
    return Card(
      elevation: 5,
      color: isDarkMode ? Color(0xFF2C2C2C) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(person['image']),
            ),
            SizedBox(height: 15),
            Text(
              person['name'],
              style: GoogleFonts.cairo(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 5),
            Text(
              person['title'],
              style: GoogleFonts.cairo(
                fontSize: 16,
                color: isDarkMode ? Colors.white70 : Colors.black87,
              ),
            ),
            SizedBox(height: 15),
            Text(
              person['description'],
              style: GoogleFonts.cairo(
                fontSize: 14,
                color: isDarkMode ? Colors.white70 : Colors.black87,
              ),
              textAlign: TextAlign.center,
              maxLines: null,
              overflow: TextOverflow.visible,
            ),
            SizedBox(height: 10),
            Text(
              'رقم الهاتف: ${person['contact']['phone']}',
              style: GoogleFonts.cairo(
                fontSize: 14,
                color: isDarkMode ? Colors.blue[200] : Colors.blue[800],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الطلاب والمشرفون',
          style: GoogleFonts.cairo(
            color: isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: isDarkMode ? Color(0xFF1A1A1A) : Colors.white,
        bottom: TabBar(
          controller: _tabController,
          labelColor: isDarkMode ? Colors.white : Colors.black,
          indicatorColor: isDarkMode ? Colors.blue[200] : Colors.blue,
          tabs: [
            Tab(
              child: Text(
                'الطلاب',
                style: GoogleFonts.cairo(),
              ),
            ),
            Tab(
              child: Text(
                'المشرفون',
                style: GoogleFonts.cairo(),
              ),
            ),
          ],
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
        child: TabBarView(
          controller: _tabController,
          children: [
            ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: students.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: _buildPersonCard(students[index], isDarkMode),
                );
              },
            ),
            ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: supervisors.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: _buildPersonCard(supervisors[index], isDarkMode),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
