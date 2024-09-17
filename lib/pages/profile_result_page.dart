import 'dart:io';

import 'package:dog_translator_demo_flutter/pages/pages.dart';
import 'package:flutter/material.dart';

class ProfileResultPage extends StatelessWidget {
  final File? image;
  final String puppyName;
  final String selectedBreed;

  const ProfileResultPage({
    super.key,
    this.image,
    required this.puppyName,
    required this.selectedBreed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('강아지 종류')),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            image == null
                ? Image.asset(
                    'assets/puppy_logo.jpg', width: 200, // 기본 이미지의 크기 설정
                    height: 200,
                  ) // 기본 이미지
                : Image.file(
                    image!, width: 200, // 기본 이미지의 크기 설정
                    height: 200,
                  ), // 전달받은 이미지
            const SizedBox(height: 30),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '강아지 이름 ',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            puppyName,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '강아지 종류 ',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            selectedBreed,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileRegisterPage()));
              },
              child: const Text('프로필 다시 작성하기'),
            ),
            const SizedBox(height: 30),
            const Text(
              '프로필 작성이 완료됐다면, \n 음성 분석을 하러 가볼까요?',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RecordingPage(
                              puppyName: puppyName, // 강아지 이름 전달
                              selectedBreed: selectedBreed, // 강아지 종류 전달
                            )));
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue, // 텍스트 색상 설정
                padding: const EdgeInsets.symmetric(
                    horizontal: 30, vertical: 12), // 패딩 설정
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // 버튼 모서리 둥글기 설정
                ),
              ),
              child: const Text('녹음하러 가기'),
            ),
          ],
        ),
      ),
    );
  }
}
