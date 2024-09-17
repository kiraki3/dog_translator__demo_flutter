import 'dart:io';
import 'package:dog_translator_demo_flutter/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class ProfileRegisterPage extends StatefulWidget {
  static ProfileRegisterPage builder(
          BuildContext context, GoRouterState state) =>
      const ProfileRegisterPage();
  const ProfileRegisterPage({super.key});

  @override
  State<ProfileRegisterPage> createState() => _ProfileRegisterPageState();
}

class _ProfileRegisterPageState extends State<ProfileRegisterPage> {
  File? _image; // 선택된 이미지를 저장할 변수
  final ImagePicker _picker = ImagePicker(); // 이미지 선택을 위한 ImagePicker 객체 생성
  final TextEditingController _puppyNameController =
      TextEditingController(); // 강아지 이름 입력 필드를 관리할 컨트롤러
  String _selectedBreed = '말티즈'; // 선택된 강아지 종류를 저장할 변수

// 이미지를 선택하는 비동기 메소드
  Future<void> _pickImage() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery); // 갤러리에서 이미지를 선택
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // 선택된 이미지 파일을 _image 변수에 저장
      });
    }
  }

  void _onNextPage() {
    if (_puppyNameController.text.isEmpty || _selectedBreed.isEmpty) {
      // 이름이 비어있거나 종이 선택되지 않았을 때
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('입력 오류'),
            content: const Text('이름과 강아지 종류를 모두 입력해 주세요.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('확인'),
              ),
            ],
          );
        },
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileResultPage(
            image: _image,
            selectedBreed: _selectedBreed,
            puppyName: _puppyNameController.text,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(bottom: 5.0),
          child: Text(
            '강아지 프로필 설정',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ), // 앱 바에 제목을 설정
      body: Container(
        padding: const EdgeInsets.all(24.0), // Padding과 동일한 역할
        child: Column(
          children: <Widget>[
            // const Text(
            //   '강아지 사진 등록',
            //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            // ),
            // const SizedBox(height: 20),
            _image == null
                ? Image.asset(
                    'assets/puppy_logo.jpg',
                    width: 200, // 기본 이미지의 크기 설정
                    height: 200,
                  )
                : Image.file(
                    _image!,
                    width: 200, // 선택된 이미지의 크기 설정
                    height: 200,
                  ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('사진 선택하기'),
            ),
            const SizedBox(height: 30),
            const Text(
              '강아지 프로필 입력',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Row의 중앙 정렬
              crossAxisAlignment: CrossAxisAlignment.center, // 수직 정렬
              children: <Widget>[
                const Text(
                  '강아지 이름',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 20), // Text와 TextField 사이의 간격
                SizedBox(
                  width: 200, // TextField의 고정된 너비 설정
                  child: TextField(
                    controller: _puppyNameController,
                    maxLines: 1,
                    textAlign: TextAlign.center, // 텍스트 필드 내 텍스트 중앙 정렬
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(), // 테두리 추가
                      labelText: '강아지 이름',
                      labelStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              '강아지 종류를 선택하세요',
              style: TextStyle(fontSize: 16),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(280, 10, 0, 30),
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  RadioListTile<String>(
                    title: const Text('말티즈'),
                    value: '말티즈',
                    groupValue: _selectedBreed,
                    onChanged: (value) {
                      setState(() {
                        _selectedBreed = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('포메라니언'),
                    value: '포메라니언',
                    groupValue: _selectedBreed,
                    onChanged: (value) {
                      setState(() {
                        _selectedBreed = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('요크셔테리어'),
                    value: '요크셔테리어',
                    groupValue: _selectedBreed,
                    onChanged: (value) {
                      setState(() {
                        _selectedBreed = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _onNextPage,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue, // 텍스트 색상 설정
                padding: const EdgeInsets.symmetric(
                    horizontal: 30, vertical: 12), // 패딩 설정
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // 버튼 모서리 둥글기 설정
                ),
              ),
              child: const Text('프로필 등록하기'),
            ),
          ],
        ),
      ),
    );
  }
}
