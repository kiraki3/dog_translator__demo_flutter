import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(bottom: 5.0),
          child: Text(
            'Dog Translator',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          const Positioned(
            top: 30,
            left: 80,
            right: 80,
            child: Image(
              image: AssetImage('assets/puppy_logo.jpg'),
              width: 200,
              height: 300,
            ),
          ),
          const Positioned(
            top: 350,
            left: 0,
            right: 0,
            child: Text(
              '안녕하세요 \n 강아지 번역기 입니다.',
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            top: 430,
            left: 100,
            right: 100,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton(
                onPressed: () {
                  // 버튼이 눌렸을 때의 동작
                },
                child: const Text(
                  '시작하기',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
      // child: Text(
      //     'Hello, Flutter!',
      //     style: TextStyle(fontSize: 24),
      //   ),
    );
  }
}
