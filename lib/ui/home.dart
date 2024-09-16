import 'package:ai_assestant/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';

class MyHomePage extends StatelessWidget {
  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Speech Test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Recognized words:',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Obx(() => Text(
                  _homeController.speechToText.isListening
                      ? _homeController.lastWords.value
                      : _homeController.speechEnabled.value
                          ? 'Tap the microphone to start listening...'
                          : 'Speech not available',
                )),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Obx(() => FloatingActionButton(
        onPressed: _homeController.speechToText.isNotListening
            ? _homeController.startListening
            : _homeController.stopListening,
        tooltip: 'Listen',
        child: Icon(_homeController.speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      )),
    );
  }
}

// To show an overlay floating button
void showFloatingButton() {
  showSimpleNotification(
    const Text("Floating Action"),
    leading: IconButton(
      icon: const Icon(Icons.mic),
      onPressed: () {
        // Trigger some action here
      },
    ),
    background: Colors.blue,
    autoDismiss: false,  // Set to false to make it persistent
  );
}