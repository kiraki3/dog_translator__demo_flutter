import 'dart:io';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:dog_translator_demo_flutter/pages/pages.dart';
import 'package:dog_translator_demo_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AnalysisResultPage extends StatefulWidget {
  final File? image;
  final String puppyName;
  final String selectedBreed;
  final String audioFilePath;

  const AnalysisResultPage({
    super.key,
    this.image,
    required this.puppyName,
    required this.selectedBreed,
    required this.audioFilePath,
  });

  @override
  State<AnalysisResultPage> createState() => _AnalysisResultPageState();
}

class _AnalysisResultPageState extends State<AnalysisResultPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> startPlaying() async {
    File audioFile = File(widget.audioFilePath);

    if (await audioFile.exists()) {
      await _audioPlayer.play(DeviceFileSource(audioFile.path));
      if (mounted) {
        // 위젯이 화면에 여전히 있는지 확인
        setState(() {
          isPlaying = true;
        });
      }
      _audioPlayer.onPlayerComplete.listen((event) {
        if (mounted) {
          // 위젯이 화면에 여전히 있는지 확인
          setState(() {
            isPlaying = false;
          });
        }
      });
    } else {
      if (mounted) {
        // 위젯이 화면에 여전히 있는지 확인
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('오디오 파일이 존재하지 않습니다.')),
        );
      }
    }
  }

  Future<void> stopPlaying() async {
    await _audioPlayer.stop();
    setState(() {
      isPlaying = false;
    });
  }

  // 메시지 리스트
  final List<String> messages = [
    "와, 당신은 정말 대단해요!",
    "오늘도 잘 지내고 있네요.",
    "항상 행복하세요!",
    "당신의 사랑이 필요해요.",
    "당신과 함께 하는 시간이 좋아요.",
    "물 좀 주세요, 목이 너무 말라요!",
    "산책 가고 싶어요, 신나게 뛰어놀고 싶어요!",
    "지금 놀아주세요, 저도 재미있게 놀고 싶어요!",
    "햇볕 쬐고 싶어요, 밖으로 나가고 싶어요!",
    "편안한 자리를 찾아주세요, 좀 쉬고 싶어요!",
    "산책은 언제 갈까요? 기다리고 있어요!",
    "저도 간식으로 하루를 시작하고 싶어요!",
    "물어볼게 있어요, 잘 들어주세요!",
    "목욕하고 싶어요."
  ];

  String randomMessage = "분석 결과를 클릭하여 확인하세요!"; // 초기 메시지

  // 무작위 메시지 생성 함수
  void generateRandomMessage() {
    final random = Random();
    setState(() {
      randomMessage = messages[random.nextInt(messages.length)];
    });
  }

  @override
  void initState() {
    super.initState();
    // 페이지가 로드될 때 무작위 메시지를 생성
    generateRandomMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Text(
            '${widget.puppyName}의 목소리 분석결과',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 101, 174, 243),
      ), // 앱 바에 제목을 설정
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            widget.image == null
                ? Image.asset(
                    'assets/puppy_logo.jpg', width: 200, // 기본 이미지의 크기 설정
                    height: 200,
                  ) // 기본 이미지
                : Image.file(
                    widget.image!, width: 200, // 기본 이미지의 크기 설정
                    height: 200,
                  ), // 전달받은 이미지
            const SizedBox(height: 25),
            IconButton(
              icon: Image.asset(
                isPlaying ? 'assets/pausebutton.png' : 'assets/playbutton.png',
                width: 60,
                height: 60,
              ),
              onPressed: isPlaying ? stopPlaying : startPlaying,
            ),
            const SizedBox(height: 25),
            const Text(
              '목소리를 분석해본 결과, \n 당신의 강아지는 다음과 같은 말을 하고 있어요!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 25),
            Text(
              randomMessage,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                backgroundColor: Colors.yellow,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecordingPage(
                      image: widget.image,
                      puppyName: widget.puppyName,
                      selectedBreed: widget.selectedBreed,
                    ),
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
                '뒤로 가기',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(height: 24),
            CustomElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              },
              text: '홈으로',
            ),
          ],
        ),
      ),
    );
  }
}
