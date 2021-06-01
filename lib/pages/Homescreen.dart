import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:avatar_glow/avatar_glow.dart';

class MyHomePage extends StatefulWidget {
  static const routeName = '/home';
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  stt.SpeechToText _speechToText = stt.SpeechToText();
  bool _isListening = false;
  String _command;
  double _confidence = 1.0;

  void listen() async{
    if(!_isListening){
      bool available = await _speechToText.initialize(
        onStatus: (val){print('status $val');
        if(val == 'notListening'){
          setState(() {
            _isListening = false;
            _speechToText.stop();
          });
        }
        },
        onError:(val) {
          setState(() {
            _isListening = false;
            _speechToText.stop();
          });
          print('error $val');
        }
      );
      if(available){
        setState(() {
          _isListening = true;
        });
        _speechToText.listen(
          listenFor: Duration(minutes: 20),
          pauseFor: Duration(minutes: 2),
          onResult: (val){
            setState(() {
              _command = val.recognizedWords;
              print(_command);
            });
          }
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SHRAVAN'),
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 35),
              child: Container(
                width: 450,
                height: 350,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.deepPurpleAccent),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'INSTRUCTIONS',
                        style: TextStyle(fontSize: 26, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'This is a Guiding app we will help you Use other apps step by step',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '1. All you need to do is click on start and give a coomand',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '2. The icon on the bottom left is a bot it will give you steps to use other app',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '3. After each step say NEXT and the bot will say next step',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
                      child: InkWell(
                        focusColor: Colors.white,
                        splashColor: Colors.deepPurpleAccent,
                        child: Container(child: Text('Click mic for awesomeness!'),),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton:  AvatarGlow(
          glowColor: Colors.redAccent,
          duration: const Duration(milliseconds: 1000),
          repeatPauseDuration: const Duration(milliseconds: 100),
          repeat: true,
          endRadius: 70.0,
          animate: _isListening,
          child: FloatingActionButton(
            child: FaIcon(
                FontAwesomeIcons.microphone
            ),
            onPressed: listen
          ),
        ));
  }
}
