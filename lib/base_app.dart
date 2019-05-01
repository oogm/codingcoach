import 'package:easycode/main.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
//import 'package:audioplayer/audioplayer.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import './audio_provider.dart';

class Introduction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.green, accentColor: Colors.green),
      home: BaseAppWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BaseAppWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BaseAppState();
  }
}

class BaseAppState extends State<BaseAppWidget> {
  static String url =
  'assets/audio/applause.mp3';
     // 'https://codingwithjoe.com/wp-content/uploads/2018/03/applause.mp3';
  AudioPlayer audioPlayer = new AudioPlayer();
   static AudioCache player = new AudioCache();
  AudioProvider audioProvider = new AudioProvider(url);
  
  VideoPlayerController _controller;  
  bool _isPlaying = false;
  List<String> _products = ['While (Codrilla is hungry) \n     Codrilla walks to banana'];
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/videos/lecture.mp4")
      ..addListener(() {
        final bool isPlaying = _controller.value.isPlaying;
        if (isPlaying != _isPlaying) {
          setState(() {
            _isPlaying = isPlaying;
          });
        }
      })
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    int counter = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Level 6: While Loops',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black.withOpacity(0.8),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
                mainAxisSize: MainAxisSize.min,
                children: _products
                    .map((element) => Card(
                          child: Column(
                            children: <Widget>[Image.asset('assets/Images/GorillaWhile.jpg'), Text(element)],
                          ),
                        ))
                    .toList()),
            SizedBox(
              height: 15,
            ),
            
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50.0,
                    margin: EdgeInsets.all(10.0),
                    child: RaisedButton(
                        onPressed: () {
                          if(counter == 0)
                          {
                            player.play('project.wav');
                            counter++;
                          }
                          
                        },
                        child: Text(
                          'Listen to Text',
                          style: new TextStyle(
                            fontSize: 40.0,
                          ),
                        ),
                        color: Colors.green),
                  ),
                ),
              ],
            ),            
            Card(
              child: RichText(
                textAlign: TextAlign.left,
                text: new TextSpan(
                  // Note: Styles for TextSpans must be explicitly defined.
                  // Child text spans will inherit styles from parent
                  style: new TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    new TextSpan(
                        text:
                            'Codrilla the Gorilla loves bananas. And he´s hungry. To let him find a banana, we have to help him navigating through the jungle to find bananas. Utilizing Actions from Level 3, we could simply guide him step by step.'),
                    // new TextSpan(
                    //   text: ' Eat Banana ',
                    //   style: new TextStyle(fontWeight: FontWeight.bold)),
                    new TextSpan(
                        text:
                            " However, This would require a lot of lines, as bananas are far away.  A while loop lets you effortlessly "),
                    new TextSpan(
                        text: 'repeat multiple actions ',
                        style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                    new TextSpan(
                      text: 'while ',
                      style: new TextStyle(fontWeight: FontWeight.bold),
                    ),
                    new TextSpan(text: "a certain "),
                    new TextSpan(
                        text: ' condition ', style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                    new TextSpan(text: "is met. For example, we can create a loop to make Codrilla"),
                    new TextSpan(
                        text: ' repetitively walk ',
                        style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                    new TextSpan(
                      text: 'while ',
                      style: new TextStyle(fontWeight: FontWeight.bold),
                    ),
                    new TextSpan(
                        text: 'he´s hungry. ', style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.red))
                  ],
                ),
              ),
            ),
            // child: Text("After a long day in the jungle Codzilla wakes up hungry. Luckily he thought ahead and collected a huge pile of bananas. One Banana certainly won't be enough for him. "
            // "A while loop repeats actions mulltiple times while a certain condition is met. This way we can help Codzilla without calling lots of actions manually.")),

            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50.0,
                    margin: EdgeInsets.all(10.0),
                    child: RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (c) => MyApp()),
                          );
                        },
                        child: Text(
                          'Play',
                          style: new TextStyle(
                            fontSize: 40.0,
                          ),
                        ),
                        color: Colors.green),
                  ),
                ),
              ],
            ),
            SizedBox(
              child: _controller.value.initialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : Container(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _controller.value.isPlaying ? _controller.pause : _controller.play,
        child: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
      ),
    );
  }
  //play() async {
    //                        //String localUrl = await audioProvider.load();
      //                      String localUrl = "assets/audio/applause.mp3";
        //                    int result = await audioPlayer.play("assets/audio/applause.mp3", isLocal: true);
                          //        }

                                   playLocal() async {
    int result = await audioPlayer.play('assets/audio/applause.mp3', isLocal: true);
  }



        
}
