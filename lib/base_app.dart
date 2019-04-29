import 'package:easycode/main.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

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
  VideoPlayerController _controller;
  bool _isPlaying = false;
  List<String> _products = ['While (Codrilla is hungry) \n     Codrilla eats one more banana'];
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lecture 2: While Loops',
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
                            'Codzilla the Gorilla loves bananas. And he´s hungry. Just one banana surely will not be enough for him. Using what we´ve learned in Lecture 1, we could feed him, by simply calling the'),
                    new TextSpan(text: ' Eat Banana ', style: new TextStyle(fontWeight: FontWeight.bold)),
                    new TextSpan(
                        text:
                            "action multiple times. This would require writing a lot of lines, though, as Codzilla is really hungry.  A while loop lets you effortlessly "),
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
                    new TextSpan(text: "is met. For example, we can create a loop to make Codzilla"),
                    new TextSpan(
                        text: ' repetitively eat one banana ',
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
}
