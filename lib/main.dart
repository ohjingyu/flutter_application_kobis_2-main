import 'package:flutter/material.dart';
import 'package:flutter_application_kobis_2/rank_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        //앱 자체 언어 설정 함으로써 캘린더를 한국어로 변경
        localizationsDelegates: [
          // 앱의 로컬라이제이션을 구성합니다.
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          // 앱에서 지원하는 언어 목록을 설정합니다.
          Locale('ko', 'KR'), // 한국어
          Locale('en', 'US'), // 영어
        ],
        home: RankPage());
  }
}
