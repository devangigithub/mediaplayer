import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediaplayer/screen/Audio_View.dart';
import 'package:mediaplayer/screen/Video_View.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Media Player',style: GoogleFonts.rancho(
            color: Colors.white
          ),),
          bottom: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.black,
              dividerColor: Colors.black,
              tabs:
          [
            Tab(
              icon: Icon(Icons.audiotrack),
              text: "Audio "
            ),
            Tab(
              text: "Video",
              icon: Icon(Icons.video_call_rounded),
            ),
          ]),
        ),

        body: TabBarView(children: [
           AudioView(),
           VideoListView(),
        ]),
      ),
    );
  }
}
