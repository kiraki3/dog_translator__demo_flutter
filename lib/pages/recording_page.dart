import 'dart:io';
import 'package:audioplayers/audioplayers.dart'; // Record 패키지
import 'package:record/record.dart';
import 'package:dog_translator_demo_flutter/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart'; // 권한 요청을 위한 패키지

class RecordingPage extends StatefulWidget {
  final File? image;
  final String puppyName;
  final String selectedBreed;

  const RecordingPage({
    super.key,
    this.image,
    required this.puppyName,
    required this.selectedBreed,
  });

  @override
  State<RecordingPage> createState() => _RecordingPageState();
}

class _RecordingPageState extends State<RecordingPage> {
  final Record audioRecorder = Record(); // Record 객체 생성
  final AudioPlayer audioPlayer = AudioPlayer(); // AudioPlayer 객체 생성
  bool isRecording = false;
  bool isPlaying = false;
  String? filePath;

  @override
  void dispose() {
    audioPlayer.dispose(); // AudioPlayer 리소스 해제
    super.dispose();
  }

  Future<void> startRecording() async {
    final directory = await getApplicationDocumentsDirectory();
    filePath = '${directory.path}/recording.aac';
    if (await audioRecorder.hasPermission()) {
      await audioRecorder.start(path: filePath); // 녹음 시작
      setState(() {
        isRecording = true;
      });
    }
  }

  Future<void> stopRecording() async {
    await audioRecorder.stop(); // 녹음 중지
    setState(() {
      isRecording = false;
    });
  }

  Future<void> playRecording() async {
    if (filePath != null && File(filePath!).existsSync()) {
      await audioPlayer.play(DeviceFileSource(filePath!)); // 로컬 파일 재생
      setState(() {
        isPlaying = true;
      });

      audioPlayer.onPlayerComplete.listen((event) {
        setState(() {
          isPlaying = false;
        });
      });
    }
  }

  Future<void> stopPlaying() async {
    await audioPlayer.stop(); // 재생 중지
    setState(() {
      isPlaying = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(bottom: 5.0),
          child: Text(
            '목소리 녹음 하기',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 101, 174, 243),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.image == null
                  ? Image.asset(
                      'assets/puppy_logo.jpg', width: 200, // 기본 이미지의 크기 설정
                      height: 200,
                    ) // 기본 이미지
                  : Image.file(
                      widget.image!, width: 200, // 전달받은 이미지
                      height: 200,
                    ),
              const SizedBox(height: 30),
              Text('${widget.puppyName} (이)의 말을 들어보아요.',
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w400)),
              const SizedBox(height: 30),
              const Text(
                '마이크를 탭하면 녹음이 시작됩니다.',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Image.asset(
                      isRecording
                          ? 'assets/recordstop.png'
                          : 'assets/micimage.png',
                      width: 80,
                      height: 80,
                    ),
                    onPressed: isRecording ? stopRecording : startRecording,
                  ),
                  const SizedBox(width: 15),
                  IconButton(
                    icon: Image.asset(
                      isRecording
                          ? 'assets/pausebutton.png'
                          : 'assets/playbutton.png',
                      width: 50,
                      height: 50,
                    ),
                    onPressed: isPlaying ? stopPlaying : playRecording,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text('녹음 완료 후 발바닥을 탭하면 \n 분석한 결과를 확인할 수 있습니다.',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center),
              const SizedBox(height: 30),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AnalysisResultPage(
                        image: widget.image,
                        puppyName: widget.puppyName,
                        selectedBreed: widget.selectedBreed,
                        audioFilePath: filePath ?? '', // 녹음 파일 경로 전달
                      ),
                    ),
                  );
                },
                icon: const ImageIcon(
                  AssetImage('assets/stopbutton.png'),
                  size: 100.0, // 아이콘 크기 조정
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
