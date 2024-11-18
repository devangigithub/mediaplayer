// //
// // import 'package:chewie/chewie.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:video_player/video_player.dart';
// //
// // class VideoView extends StatefulWidget {
// //   const VideoView({super.key});
// //
// //   @override
// //   State<VideoView> createState() => _VideoViewState();
// // }
// //
// // class _VideoViewState extends State<VideoView> {
// //   VideoPlayerController videoPlayerController =
// //   VideoPlayerController.networkUrl(Uri.parse(
// //       "https://rr4---sn-cvh76ner.googlevideo.com/videoplayback?expire=1731666259&ei=88w2Z6CqGYi0rtoP2fa22QU&ip=125.25.217.111&id=o-ALMc48FVbCA1H4qNBU6fTIzvLlWze3uO9D4zSq-cIVw4&itag=18&source=youtube&requiressl=yes&xpc=EgVo2aDSNQ%3D%3D&bui=AQn3pFQ1yQSnCOoNwywdSGJy0GSX0I7OedUruHUcZvsnoozu59tV6zrmwIAKn3EL-iFX9EcMJzQxfZhh&spc=qtApAQb8PHjjKHcqVeXAchA5VcpnkV7ZoLZ4-nYHVfX9Zb-8pzK_nr4pqrsvDzQ&vprv=1&c=MWEB&svpuc=1&mime=video%2Fmp4&ns=Jwgtjwrhq3rsFOebB2_zWPYQ&rqh=1&gir=yes&clen=3847344&ratebypass=yes&dur=122.717&lmt=1727675046429418&fexp=24350590,24350655,24350675,24350705,24350737,24350785,51299154,51312688,51326932,51331020&sefc=1&txp=6309224&n=H1pI7Mh-EUEbCA&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cxpc%2Cbui%2Cspc%2Cvprv%2Cc%2Csvpuc%2Cmime%2Cns%2Crqh%2Cgir%2Cclen%2Cratebypass%2Cdur%2Clmt&sig=AJfQdSswRQIgDymtggqJsN-WCzW4bucIDm6z2OhtdMKFE5FHrdasQuYCIQCqYPxYgCnVvW6PhCvBAcAJDZwwwdSqduIczpQ-srZ_yQ%3D%3D&title=MediaQuery.propertyOf%20(Technique%20of%20the%20Week)&rm=sn-uvu-2ins7e,sn-uvu-c33le7e,sn-30asd76&rrc=79,79,104&req_id=10ecccf4e4bda3ee&cmsv=e&rms=nxu,au&redirect_counter=3&cms_redirect=yes&ipbypass=yes&met=1731644665,&mh=9b&mip=103.177.194.55&mm=30&mn=sn-cvh76ner&ms=nxu&mt=1731643102&mv=u&mvi=4&pl=24&lsparams=ipbypass,met,mh,mip,mm,mn,ms,mv,mvi,pl,rms&lsig=AGluJ3MwRgIhAKYhipSE8CEuSFV83iOJbccf8l3EzGYI_bQH31WDmsEUAiEA7PiHCSGbN1C5EBtkY6nOra7SJYGtu41BOGecYi_NwnE%3D"));
// //   ChewieController? chewieController;
// //
// //   @override
// //   void initState() {
// //     videoPlayerController.initialize().then((value) {
// //       chewieController = ChewieController(
// //           videoPlayerController: videoPlayerController, autoPlay: true);
// //       setState(() {});
// //     });
// //     super.initState();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     if (chewieController != null)
// //       return SingleChildScrollView(
// //         child: Column(
// //           children: [
// //             Center(
// //               child: AspectRatio(
// //                 aspectRatio: videoPlayerController.value.aspectRatio ?? 1,
// //                 child: Chewie(controller: chewieController!),
// //               ),
// //             ),
// //           ],
// //         ),
// //       );
// //     return Center(child: CircularProgressIndicator());
// //   }
// // }
//
//
// import 'package:flutter/material.dart';
// import 'package:chewie/chewie.dart';
// import 'package:video_player/video_player.dart';
//
// class VideoListView extends StatefulWidget {
//   @override
//   _VideoListViewState createState() => _VideoListViewState();
// }
//
// class _VideoListViewState extends State<VideoListView> {
//   final List<Map<String, String>> videos = [
//     {
//       "name": "Lion",
//       "url": "assets/videos/lion.mp4",
//       "subtitle": "The King of the Jungle",
//       "image": 'assets/images/lion.jpg'
//     },
//     {
//       "name": "Elephant",
//       "url": "assets/videos/elephent.mp4",
//     "subtitle": "The Gentle Giant",
//       "image": 'assets/images/download(1).jfif'
//     },
//   ];
//
//   void playVideo(String url) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => VideoPlayerScreen(videoUrl: url),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Video List"),
//       ),
//       body: Column(
//         children: [
//
//           ListView.builder(
//             itemCount: videos.length,
//             itemBuilder: (context, index) {
//               final video = videos[index];
//               return ListTile(
//                 leading: Container(
//                   height: 100,
//                   width: 100,
//                   color: Colors.blue,
//                   child: Image.asset(
//                     video["image"]!,
//                     width: 100,
//                     height: 100,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 title: Text(video["name"]!),
//                 subtitle: Text(video["subtitle"]!),
//                 onTap: () => playVideo(video["url"]!),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class VideoPlayerScreen extends StatefulWidget {
//   final String videoUrl;
//
//   const VideoPlayerScreen({Key? key, required this.videoUrl}) : super(key: key);
//
//   @override
//   _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
// }
//
// class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
//   late VideoPlayerController _videoPlayerController;
//   ChewieController? _chewieController;
//
//   @override
//   void initState() {
//     super.initState();
//     _videoPlayerController = VideoPlayerController.network(widget.videoUrl)
//       ..initialize().then((_) {
//         setState(() {
//           _chewieController = ChewieController(
//             videoPlayerController: _videoPlayerController,
//             autoPlay: true,
//             looping: false,
//           );
//         });
//       });
//   }
//
//   @override
//   void dispose() {
//     _videoPlayerController.dispose();
//     _chewieController?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Video Player"),
//       ),
//       body: _chewieController != null
//           ? Center(
//         child: Chewie(controller: _chewieController!),
//       )
//           : Center(child: CircularProgressIndicator()),
//     );
//   }
// }
//
//
//
//


import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:carousel_slider/carousel_slider.dart';

class VideoListView extends StatefulWidget {
  @override
  _VideoListViewState createState() => _VideoListViewState();
}

class _VideoListViewState extends State<VideoListView> {
  final List<Map<String, String>> videos = [
    {
      "name": "Lion",
      "url": "assets/videos/lion.mp4",
      "subtitle": "The King of the Jungle",
      "image": 'assets/image/lion.jpg',
    },
    {
      "name": "Elephant",
      "url": "assets/videos/elephent.mp4",
      "subtitle": "The Gentle Giant",
      "image": 'assets/image/elephent.jpg',
    },
    {
      "name": "Panda",
      "url": "assets/videos/panda.mp4",
      "subtitle": "Is a bear species endemic to China",
      "image": 'assets/image/panda.jpg',
    },
    {
      "name": "Baby Seal",
      "url": "assets/videos/babyseal.mp4",
      "subtitle": "Northernmost Atlantic Ocean and Arctic Ocean.",
      "image": 'assets/image/babyseal.jpg',
    },
    {
      "name": "Giraffe",
      "url": "assets/videos/babygiraffe.mp4",
      "subtitle": "The giraffe is a large African hoofed mammal belonging to the genus Giraffa",
      "image": 'assets/image/babygiraffe.jpg',
    },
    {
      "name": "Black Leopard",
      "url": "assets/videos/Black Leopard.mp4",
      "subtitle": "A black panther is the melanistic colour variant of the leopard and the jaguar.",
      "image": 'assets/image/BlackLeopard.jpg',
    },
    {
      "name": "Eagle",
      "url": "assets/videos/Eagle.mp4",
      "subtitle": "Eagle is the common name for the golden eagle.",
      "image": 'assets/image/Eagle.jpg',
    },
    {
      "name": "Grumpiest Cat",
      "url": "assets/videos/Grumpiest Cat t.mp4",
      "subtitle": "Ribilik, is one of the most secretive small cats in India",
      "image": 'assets/image/Cat.jpg',
    },
    {
      "name": "Black Panthal",
      "url": "assets/videos/Black Panthal.mp4",
      "subtitle": "A black panther is the melanistic colour variant of the leopard  and the jaguar .",
      "image": 'assets/image/blackpanthal.jpg',
    },
    {
      "name": "KingFisher",
      "url": "assets/videos/KingFisher.mp4",
      "subtitle": " KingFisher found in Europe and the Americas.",
      "image": 'assets/image/KingFisher.jpg',
    },
    {
      "name": "Owl",
      "url": "assets/videos/Owl.mp4",
      "subtitle": "Owls are birds from the order Strigiformes,",
      "image": 'assets/image/owl.jpg',
    },

  ];

  void playVideo(String url) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPlayerScreen(videoUrl: url),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          CarouselSlider(
            items: videos.map((video) {
              return Container(
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Stack(
                    children: [
                      Image.asset(
                        video['image']!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Positioned(
                        bottom: 20,
                        left: 20,
                        child: Text(
                          video['name']!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                blurRadius: 5,
                                color: Colors.black87,
                                offset: Offset(1, 1),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              autoPlay: true,
              viewportFraction: 0.8,
              aspectRatio: 16 / 9,
              enlargeCenterPage: true,
              autoPlayInterval: Duration(seconds: 2),
              enlargeFactor: 0.2,
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: videos.length,
              itemBuilder: (context, index) {
                final video = videos[index];
                return ListTile(
                  leading: Container(
                    height: 100,
                    width: 100,
                    color: Colors.blue,
                    child: Image.asset(
                      video["image"]!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(video["name"]!,style: TextStyle(color: Colors.white),),
                  subtitle: Text(video["subtitle"]!,style: TextStyle(color: Colors.white)),
                  onTap: () => playVideo(video["url"]!),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerScreen({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          _chewieController = ChewieController(
            videoPlayerController: _videoPlayerController,
            autoPlay: true,
            looping: false,
          );
        });
      });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Player"),
      ),
      body: _chewieController != null
          ? Center(
        child: Chewie(controller: _chewieController!),
      )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
