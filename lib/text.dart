import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Voice extends StatefulWidget {
  @override
  State<Voice> createState() => _VoiceState();
}

class _VoiceState extends State<Voice> {
  bool startRecord = false;
  final SpeechToText speech = SpeechToText();
  bool isAvailable = false;
  String text = 'Press the mic button to start recording speech';

  @override
  void initState() {
make();
    super.initState();
  }
  make()async{
    isAvailable=  await speech.initialize();
    setState(() {

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Speech to Text")),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: AvatarGlow(

          animate: startRecord,
          glowColor:Colors.orange,
          child: GestureDetector(
            onTapDown: (value){
              setState(() {
                startRecord=true;
              });
              if(isAvailable){
                speech.listen(
                    onResult: (value){
                      setState(() {
                        text=value.recognizedWords;
                      });
                    }
                );
              }
            },
            onTapUp: (value){
              setState(() {

                startRecord=false;
              });
              speech.stop();
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: IconButton(
                icon: Icon(Icons.mic, color: Colors.white),
                iconSize: 50,
                onPressed: () {
            
            
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}