import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final VideoPlayerController _controller;

  double time = 0;
  int maxTime = 0;
  double position = 0;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://user-images.githubusercontent.com/55622345/166254042-6574fb68-8f65-4991-8e0a-f4bc83cbb98b.mp4'))
          ..initialize().then((_) {
            setState(() {
              time = _controller.value.position.inMilliseconds / 1000;
              maxTime = _controller.value.duration.inSeconds;
              print("_controller value"); // VideoPlayerValue(duration: 0:00:21.334000, size: Size(720.0, 1490.0), position: 0:00:00.000000, caption: Caption(number: 0, start: 0:00:00.000000, end: 0:00:00.000000, text: ), captionOffset: 0:00:00.000000, buffered: [], isInitialized: true, isPlaying: false, isLooping: false, isBuffering: false, volume: 1.0, playbackSpeed: 1.0, errorDescription: null, isCompleted: false)
            });
            _controller.addListener(() {
              setState(() {
                time = _controller.value.position.inMilliseconds / 1000;
                position = switch(time / maxTime) {
                  > 1 => 1,
                  < 0 => 0,
                  _ => time / maxTime
                };
              });
          },);
    },);
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: _controller.value.isInitialized
            // 화면 비율 설정
            ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ) : Container(),
          ),
          Container(
            padding: const EdgeInsets.only(top: 16, right: 20, left: 20, bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(time.toTime, style: const TextStyle(
                  color: Colors.white
                ),),
                Text(maxTime.toTime, style: const TextStyle(
                  color: Colors.white
                ),),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            width: double.maxFinite,
            child: SliderTheme(
              data: SliderThemeData(
                overlayShape: SliderComponentShape.noOverlay,
                trackShape: CustomSlider()
                ),
              child: Slider(
                value: position,
                onChanged: (value) {
                  setState(() {
                    final _time = Duration(milliseconds: (value * maxTime * 1000).toInt());
                    _controller.seekTo(_time);
                  });
                },

              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            alignment: Alignment.center,
            child: IconButton(
              style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.white)),
              color: Colors.black,
              onPressed: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
              icon: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow,),
            ),
          )
        ],
      ),
    );
  }
}

extension DoubleExt on double {
  String get toTime {
    final minutes = this ~/ 60;
    final seconds = this % 60;
    return "${minutes.toStringAsFixed(0).padLeft(2,"0")}:${seconds.toStringAsFixed(0).padLeft(2,"0")}";
  }
}

extension IntExt on int {
  String get toTime {
    final minutes = this ~/ 60;
    final seconds = this % 60;
    return "${minutes.toString().padLeft(2,"0")}:${seconds.toString().padLeft(2,"0")}";
  }
}

/// create custom slider
/// https://stackoverflow.com/questions/65661119/flutter-remove-default-padding-in-slider
class CustomSlider extends RoundedRectSliderTrackShape {

  @override
  Rect getPreferredRect(
      {required RenderBox parentBox,
      Offset offset = Offset.zero,
      required SliderThemeData sliderTheme,
      bool isEnabled = false,
      bool isDiscrete = false}) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}