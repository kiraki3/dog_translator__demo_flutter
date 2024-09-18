import 'package:dog_translator_demo_flutter/pages/pages.dart';
import 'package:dog_translator_demo_flutter/widgets/widgets.dart';
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
        backgroundColor: const Color.fromARGB(255, 101, 174, 243),
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
            CustomElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileRegisterPage(),
                  ),
                );
              },
              text: '프로필 입력하기',
            ),
          ],
        ),
      ),
    );
  }
}
