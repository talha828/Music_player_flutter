
import 'package:flutter/material.dart';
import 'package:audioplayer/audioplayer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String name="My Music";
  AudioPlayer audioPlugin = AudioPlayer();
  double value = 10.0;
  FilePickerResult result;
  String filepath;
  bool check = false;
  PlatformFile file;
  String totalDuration='00:00';
  String current='00:00';
  Duration duration;
  Duration position;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    audioPlugin.onAudioPositionChanged.listen((Duration duration) {
      setState(() {
       current=duration.toString().split(".")[0];
       position=duration;
      });
    });
    audioPlugin.onPlayerStateChanged.listen((Duration){
     setState(() {
       if (Duration == AudioPlayerState.PLAYING) {
         setState(() { totalDuration = audioPlugin.duration.toString().split(".")[0];
         duration=audioPlugin.duration;
         });
       }
     });
     });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Color(0xFF1D222E),
            title: Center(
              child: Text(
                'Music',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w300),
              ),
            ),
            actions: [
              Padding(
                  padding: EdgeInsets.all(10),
                  child: GestureDetector(
                      onTap: () async {
                        setState(() async {
                          FilePickerResult path =
                              await FilePicker.platform.pickFiles();
                         file = path.files.first;
                          name=file.name;
                        });
                      },
                      child: Icon(
                        FontAwesomeIcons.listAlt,
                        size: 30,
                      ))),
            ],
          ),
          backgroundColor: Color(0xFF1D222E),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                shape: CircleBorder(),
                elevation: 10,
                child: CircleAvatar(
                  radius: 140,
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF1D222E),
                  child: Image.asset(
                    "assets/headphones.png",
                    scale: 3,
                    color: Colors.white,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.share,
                        color: Colors.white,
                      ),
                      onPressed: () {}),
                  Column(
                    children: [
                      SingleChildScrollView(
                        child: Row(
                          children: [
                            Container(
                              width: 200,
                              height: 40,
                              child: Text(
                                name,
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "Talha Iqbal",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )
                    ],
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        // int result = await audioPlayer.play(result, isLocal: true);
                      })
                ],
              ),
              Row(
                children:[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(totalDuration,style: TextStyle(color: Colors.white),),
                  ),
                  Expanded(
                    child: Slider(
                      min: 00,
                      max:duration?.inMilliseconds?.toDouble()??0.0,
                      value: position?.inMilliseconds?.toDouble() ?? 0.0,
                      activeColor: Colors.white,
                      inactiveColor: Color(0xFF2D322E),
                      onChanged: (value) {
                        setState(() {
                          return audioPlugin.seek((value / 1000).roundToDouble());
                        });
                      }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(current,style: TextStyle(color: Colors.white),),
                  ),
             ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.skip_previous_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed:() async {
                        setState(() async {
                          FilePickerResult path =
                          await FilePicker.platform.pickFiles();
                          file = path.files.first;
                          name=file.name;
                        });
                      },),
                  GestureDetector(
                    onTap: ()  {
                      print(check);
                      if(check ==true){
                        setState(() {
                          check = false;
                        });
                      }
                      else{
                      setState(() {
                        check=true;
                      });
                      }
                          print(check);
                      if (check == true) {
                         audioPlugin.play(file.path, isLocal: true);
                      } else {
                        audioPlugin.pause();
                      }
                    },
                    child: Card(
                      shape: CircleBorder(),
                      elevation: 10,
                      child: CircleAvatar(
                          radius: 30,
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0xFF1D222E),
                          child: Center(
                              child: Icon(check?Icons.pause:Icons.play_arrow_outlined,size: 40,color: Colors.white,),
                          ))),
                    ),
                  IconButton(
                      icon: Icon(
                        Icons.skip_next_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed:() async {
                        setState(() async {
                          FilePickerResult path =
                          await FilePicker.platform.pickFiles();
                          file = path.files.first;
                          name=file.name;
                        });
                      },),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
