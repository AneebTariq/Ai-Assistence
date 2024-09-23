import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';

import '../controllers/home_controller.dart';

class MyHomePage extends StatelessWidget {
  final HomeController _homeController = Get.put(HomeController());

  MyHomePage({super.key});

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
                // Wrap only this part with Obx since it depends on reactive variables
                child: Obx(() => Text(
                  _homeController.isListening.value
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
      // Wrap the floatingActionButton with Obx
      floatingActionButton: Obx(() => FloatingActionButton(
        onPressed: _homeController.isListening.value
            ? _homeController.stopListening
            : _homeController.startListening,
        tooltip: 'Listen',
        child: Icon(_homeController.isListening.value ? Icons.mic : Icons.mic_off),
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