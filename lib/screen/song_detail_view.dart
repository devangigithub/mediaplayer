import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class SongView extends StatefulWidget {
  final Audio song;
  final AssetsAudioPlayer player;

  const SongView({
    super.key,
    required this.song,
    required this.player,
  });

  @override
  _SongViewState createState() => _SongViewState();
}

class _SongViewState extends State<SongView> {
  late int currentSongIndex;
  late List<Audio> filteredAudios;
  late List<Audio> audios;

  @override
  void initState() {
    super.initState();
    currentSongIndex = 0;
    audios = [widget.song];
    filteredAudios = List.from(audios);
  }

  void playSingleAudio(Audio audio) {
    widget.player.open(
      audio,
      showNotification: true,
      autoStart: true,
    );
  }
  void nextSong() {
    setState(() {
      if (currentSongIndex < filteredAudios.length - 1) {
        currentSongIndex++;
        widget.player.open(
          filteredAudios[currentSongIndex],
          showNotification: true,
          autoStart: true,
        );
      }
    });
  }
  void previousSong() {
    setState(() {
      if (currentSongIndex > 0) {
        currentSongIndex--;
        widget.player.open(
          filteredAudios[currentSongIndex],
          showNotification: true,
          autoStart: true,
        );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
        title: Text(widget.song.metas.title ?? "Unknown Title"),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              widget.song.metas.image?.path ?? '',
              height: 250,
              width: 250,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            widget.song.metas.title ?? "Unknown Title",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            widget.song.metas.artist ?? "Unknown Artist",
            style: const TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: previousSong,
                icon: Icon(Icons.skip_previous,size: 30, color: Colors.white),
              ),
              StreamBuilder<bool>(
                stream: widget.player.isPlaying,
                builder: (context, snapshot) {
                  final isPlaying = snapshot.data ?? false;
                  return IconButton(
                    onPressed: widget.player.playOrPause,
                    icon: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,size: 50,
                    ),
                  );
                },
              ),
              IconButton(
                onPressed: nextSong,
                icon: Icon(Icons.skip_next,size: 30, color: Colors.white),
              ),
            ],
          ),
          StreamBuilder<Playing?>(
            stream: widget.player.current,
            builder: (context, snapshot) {
              final data = snapshot.data;
              final audioDuration = data?.audio.duration;

              if (audioDuration?.inSeconds != null) {
                return StreamBuilder<Duration>(
                  stream: widget.player.currentPosition,
                  builder: (context, snapshot) {
                    var currentDuration = snapshot.data ?? Duration.zero;
                    final remainingDuration = audioDuration! - currentDuration;

                    // Helper function to format Duration as minutes:seconds
                    String formatDuration(Duration duration) {
                      final minutes = duration.inMinutes;
                      final seconds = duration.inSeconds % 60;
                      return '$minutes:${seconds.toString().padLeft(2, '0')}';
                    }

                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Display current time in minutes:seconds
                            Text(
                              formatDuration(currentDuration),
                              style: TextStyle(color: Colors.white),
                            ),
                            // Progress Slider
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Expanded(
                                child: Slider(
                                  value: currentDuration.inSeconds.toDouble(),
                                  min: 0,
                                  max: audioDuration.inSeconds.toDouble(),
                                  onChanged: (value) {
                                    widget.player.seek(Duration(seconds: value.toInt()));
                                  },
                                ),
                              ),
                            ),
                            // Display remaining time in minutes:seconds
                            Text(
                              formatDuration(remainingDuration),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
}
