import 'package:flutter_tts/flutter_tts.dart';

class FlutterTtsMe{

  FlutterTtsMe({required this.setSpeechRate,required this.setVolume});
  double setSpeechRate;
  double setVolume;

 static FlutterTts  flutterTts = FlutterTts();

  Future<void> configureTts() async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setSpeechRate(setSpeechRate);
    await flutterTts.setVolume(setVolume);
    await flutterTts.setVolume(setVolume);

  }

   void speakText(String text) async {
    await flutterTts.speak(text);
  }

  void stopSpeaking() async {
    await flutterTts.stop();
  }

}
