import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:rxdart/rxdart.dart';

class SpinPage extends StatefulWidget {
  const SpinPage({Key? key}) : super(key: key);

  @override
  _SpinPageState createState() => _SpinPageState();
}

class _SpinPageState extends State<SpinPage> {
  final selected = BehaviorSubject<int>();
  String rewards = "0";
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

  List<String> items = [
    "No",
    "Yes",
    "No",
    "Yes",
    "No",
    "Yes",
    "No",
    "Yes",
    "No",
    "Yes",
    "No",
    "Yes",
  ];

  @override
  void dispose() {
    selected.close();
    assetsAudioPlayer.dispose(); // Dispose of the audio player when the widget is disposed
    super.dispose();
  }

  Future<void> showSpinResultDialog(String result) async {
    // Load and play the sound for the result
    final soundUrl = 'assets/spin_result_sound.mp3'; // Update with your sound file path
    await assetsAudioPlayer.open(
      Audio(soundUrl),
      autoStart: true,
      showNotification: false,
    );

    await showDialog(
      context: context,
      barrierDismissible: false, // Prevent dialog dismissal on tap outside
      builder: (BuildContext context) {
        return AnimatedOpacity(
          opacity: 1.0, // Start with full opacity
          duration: Duration(seconds: 1), // Adjust the duration as needed
          child: AlertDialog(
            title: Text("Spin Result"),
            content: Text("You just won $result"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Spin Wheel"),
        backgroundColor: Colors.blue, // Customize the app bar color
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlue, Colors.blue], // Customize the background gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 300,
                child: FortuneWheel(
                  selected: selected.stream,
                  animateFirst: false,
                  items: [
                    for (int i = 0; i < items.length; i++) ...<FortuneItem>[
                      FortuneItem(child: Text(items[i])),
                    ],
                  ],
                  onAnimationEnd: () {
                    setState(() {
                      rewards = items[selected.value];
                    });
                    print(rewards);

                    // Show the result with sound effect and animation
                    showSpinResultDialog(rewards);

                    // Stop the sound when the animation ends
                    assetsAudioPlayer.stop();
                  },
                ),
              ),
              SizedBox(height: 20), // Add spacing between the wheel and button
              GestureDetector(
                onTap: () async {
                  setState(() {
                    selected.add(Fortune.randomInt(0, items.length - 1));
                  });

                  // Load and play the spin sound
                  final spinSoundUrl = 'assets/spin_sound.mp3'; // Update with your sound file path
                  await assetsAudioPlayer.open(
                    Audio(spinSoundUrl),
                    autoStart: true,
                    showNotification: false,
                  );
                },
                child: Container(
                  height: 60,
                  width: 160,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(30), // Add rounded corners
                  ),
                  child: Center(
                    child: Text(
                      "SPIN",
                      style: TextStyle(
                        color: Colors.white, // Customize the button text color
                        fontSize: 18, // Customize the button text size
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
