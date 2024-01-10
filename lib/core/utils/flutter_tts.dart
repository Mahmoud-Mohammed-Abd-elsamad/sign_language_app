import 'package:flutter_tts/flutter_tts.dart';

class FlutterTtsMe{



 static FlutterTts  flutterTts = FlutterTts();

  static Future<void> configureTts({required double setSpeechRate, required double setVolume}) async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setSpeechRate(setSpeechRate);
    await flutterTts.setVolume(setVolume);

  }

   void speakText(String text) async {

      await  flutterTts.speak(text);
  }

  void stopSpeaking() async {
    await flutterTts.stop();
  }

}
