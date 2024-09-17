import 'package:dog_translator_demo_flutter/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfileRequestPage extends ConsumerWidget {
  static ProfileRequestPage builder(
          BuildContext context, GoRouterState state) =>
      const ProfileRequestPage();
  const ProfileRequestPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(bottom: 5.0),
          child: Text(
            '강아지 프로필 등록하기',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          children: [
            const Image(
              image: AssetImage('assets/puppy_logo.jpg'),
              width: 200,
              height: 300,
            ),
            const SizedBox(height: 10),
            const Text(
              '정확도를 높이기 위해서는 \n 우리집 강아지를 소개해주세요.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileRegisterPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue, // 버튼 배경색 설정
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 12), // 패딩 설정
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // 버튼 모서리 둥글기 설정
                ),
                fixedSize: const Size(150, 50),
              ),
              child: const Text(
                '프로필 입력하기',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
