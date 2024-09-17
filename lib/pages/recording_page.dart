import 'dart:io';

import 'package:dog_translator_demo_flutter/pages/pages.dart';
import 'package:flutter/material.dart';

class RecordingPage extends StatelessWidget {
  final File? image;
  final String puppyName;
  final String selectedBreed;

  const RecordingPage({
    this.image,
    super.key,
    required this.puppyName,
    required this.selectedBreed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('녹음하기')),
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
                children: [
                  Text('$puppyName 의 말을 들어보아요',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w400)),
                  const SizedBox(height: 30),
                  const Text('마이크를 탭하면 녹음이 시작됩니다.'),
                  const SizedBox(height: 8),
                  IconButton(
                    onPressed: () {},
                    icon: const ImageIcon(
                      AssetImage('assets/micimage.png'),
                      size: 100.0, // 아이콘 크기 조정
                      color: Colors.red, // 아이콘 색상 설정
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '발바닥을 탭하면 \n 분석한 결과를 확인할 수 있습니다.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AnalysisResultPage(),
                        ),
                      );
                    },
                    icon: const ImageIcon(
                      AssetImage('assets/stopbutton.png'),
                      size: 100.0, // 아이콘 크기 조정
                      color: Colors.black, // 아이콘 색상 설정
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
