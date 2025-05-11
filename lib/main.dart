import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';

import 'screens/home_screen.dart';
import 'screens/students_screen.dart';
import 'screens/project_explanation_screen.dart';
import 'screens/code_explanation_screen.dart';
import 'theme/al_jazeera_colors.dart';

void main() {
  // تأكد من دعم التوجيه العربي
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const RFIDReaderApp());
}

class RFIDReaderApp extends StatelessWidget {
  const RFIDReaderApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'نظام قراءة RFID',
      debugShowCheckedModeBanner: false,

      // دعم اللغة العربية
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', ''), // الدعم الكامل للغة العربية
      ],
      locale: const Locale('ar', ''),

      // استخدام اتجاه النص من اليمين لليسار
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },

      // تطبيق تصميم الجزيرة
      theme: AlJazeeraColors.createTheme(context),

      home: const RootApp(),
    );
  }
}

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int _selectedIndex = 0;

  // الشاشات الرئيسية
  static final List<Widget> _screens = [
    const HomeScreen(),
    const StudentsScreen(),
    const ProjectExplanationScreen(),
    const CodeExplanationScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 30, 60, 40),
        unselectedItemColor: Color.fromARGB(255, 30, 60, 40),
        selectedItemColor: Color.fromARGB(255, 30, 60, 40),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        elevation: 10,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded, size: 26),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_rounded, size: 26),
            label: 'الطلاب',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description_rounded, size: 26),
            label: 'المشروع',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.code_rounded, size: 26),
            label: 'الكود',
          ),
        ],
      ),
    );
  }
}
