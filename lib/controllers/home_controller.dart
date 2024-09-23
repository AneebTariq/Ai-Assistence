import 'package:ai_assestant/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

class HomeController extends GetxController {
  final SpeechToText speechToText = SpeechToText();
  RxBool speechEnabled =false.obs;
  RxString lastWords = ''.obs;
  RxBool isListening = false.obs;

  @override
  void onInit() {
    super.onInit();
    initSpeech();
    startForegroundService();
     WidgetsBinding.instance.addPostFrameCallback((_) {
    showFloatingButton(); // Show floating button when the home screen is loaded
  });
  }

  void startForegroundService() {
    FlutterForegroundTask.startService(
      notificationTitle: 'AI Assistant',
      notificationText: 'Listening for your command...',
    );
  }

  void initSpeech() async {
    speechEnabled.value = await speechToText.initialize();
  }

  void startListening() async {
    if (!isListening.value) {
      await speechToText.listen(onResult: onSpeechResult);
      isListening.value = true;
    }
  }

  void stopListening() async {
    await speechToText.stop();
    isListening.value = false;
  }

  void onSpeechResult(SpeechRecognitionResult result) {
  if (result.recognizedWords.toLowerCase() == "start") {
    lastWords.value = "Listening for commands...";
    startListening();
  } else if (result.recognizedWords.toLowerCase() == "stop listening") {
    lastWords.value= "Stop";
    stopListening();
  } else {
    lastWords.value = result.recognizedWords;
  }
}
}
