
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediaplayer/screen/song_detail_view.dart';
import 'package:mediaplayer/ulist/global.dart';

class AudioView extends StatefulWidget {
  const AudioView({super.key});

  @override
  State<AudioView> createState() => _AudioViewState();
}

class _AudioViewState extends State<AudioView> {
  final AssetsAudioPlayer player = AssetsAudioPlayer.newPlayer();
  final TextEditingController searchController = TextEditingController();
  List<Audio> filteredAudios = [];
  List<String> artistList = [];
  List<Audio> favoriteSongs = [];
  String? selectedArtist;
  int currentSongIndex = 0;
  String? selectedAlbum;

  @override
  void initState() {
    super.initState();
    filteredAudios = audios;
    player.open(Playlist(audios: audios), autoStart: false);
    artistList = audios
        .map((audio) => audio.metas.artist ?? "Unknown Artist")
        .toSet()
        .toList();
    searchController.addListener(() {
      filterAudios(searchController.text);
    });
  }
  @override
  void dispose() {
    searchController.dispose();
    player.dispose();
    super.dispose();
  }
  
  void filterAudios(String query) {
    setState(() {
      filteredAudios = audios.where((audio) {
        final title = audio.metas.title?.toLowerCase() ?? '';
        final artist = audio.metas.artist?.toLowerCase() ?? '';
        final movie = audio.metas.album?.toLowerCase() ?? '';
        final searchQuery = query.toLowerCase();
        return title.contains(searchQuery) ||
            artist.contains(searchQuery) ||
            movie.contains(searchQuery) ;
      }).toList();

      player.open(Playlist(audios: filteredAudios), autoStart: false);
      currentSongIndex = 0;
    });
  }

  void filterByArtist(String artist) {
    setState(() {
      selectedArtist = artist;
      filteredAudios = audios.where((audio) {
        return audio.metas.artist == artist;
      }).toList();


      player.open(Playlist(audios: filteredAudios), autoStart: false);
      currentSongIndex = 0;
    });
  }

  List<String> getAlbums() {
    return audios
        .map((audio) => audio.metas.album ?? 'All')
        .toSet()
        .toList();
  }

  void filterByAlbum(String album) {
    setState(() {
      if (selectedAlbum == album) {
        selectedAlbum = null;
        filteredAudios = audios;
      } else {
        selectedAlbum = album;
        filteredAudios = audios.where((audio) {
          return audio.metas.album == album;
        }).toList();
      }

      player.open(Playlist(audios: filteredAudios), autoStart: false);
      currentSongIndex = 0;
    });
  }

  void playSingleAudio(Audio audio) {
    player.open(
      audio,
      showNotification: true,
      autoStart: true,
    );
  }

  void nextSong() {
    setState(() {
      if (currentSongIndex < filteredAudios.length - 1) {
        currentSongIndex++;
        player.open(
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
        player.open(
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
      backgroundColor: Colors.black,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[600]
            ),
            height: 120,
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    player.open(
                      filteredAudios[currentSongIndex],
                      showNotification: true,
                      autoStart: true,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SongView(
                          song: filteredAudios[currentSongIndex],
                          player: player,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    color:Colors.white24.withOpacity(0.2),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  filteredAudios[currentSongIndex].metas.image?.path??'',
                                  width: 90,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                                SizedBox(width: 20,),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Column(
                                children: [
                                  Text(
                                    filteredAudios[currentSongIndex].metas.title??'',
                                    style: TextStyle(
                                      fontSize: 18,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: previousSong,
                                        icon: Icon(Icons.skip_previous, color: Colors.white),
                                      ),
                                      StreamBuilder<bool>(
                                        stream: player.isPlaying,
                                        builder: (context, snapshot) {
                                          final isPlaying = snapshot.data ?? false;
                                          return IconButton(
                                            onPressed: player.playOrPause,
                                            icon: Icon(
                                              isPlaying ? Icons.pause : Icons.play_arrow,
                                              color: Colors.white,
                                            ),
                                          );
                                        },
                                      ),
                                      IconButton(
                                        onPressed: nextSong,
                                        icon: Icon(Icons.skip_next, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        StreamBuilder<Playing?>(
                          stream: player.current,
                          builder: (context, snapshot) {
                            final data = snapshot.data;
                            final audioDuration = data?.audio.duration;


                              return StreamBuilder<Duration>(
                                stream: player.currentPosition,
                                builder: (context, snapshot) {
                                  var currentDuration = snapshot.data ?? Duration.zero;
                                  final remainingDuration = audioDuration! - currentDuration;

                                  String formatDuration(Duration duration) {
                                    final minutes = duration.inMinutes;
                                    final seconds = duration.inSeconds % 60;
                                    return '$minutes:${seconds.toString().padLeft(2, '0')}';
                                  }

                                  return Column(
                                    children: [

                                      SliderTheme(
                                        data: SliderTheme.of(context).copyWith(
                                          thumbShape: SliderComponentShape.noThumb,
                                          overlayShape: SliderComponentShape.noOverlay,
                                          activeTrackColor: Colors.white,
                                          inactiveTrackColor: Colors.grey,
                                        ),
                                        child: Slider(
                                          value: currentDuration.inSeconds.toDouble(),
                                          min: 0,
                                          max: audioDuration.inSeconds.toDouble(),
                                          onChanged: (value) {
                                            player.seek(Duration(seconds: value.toInt()));
                                          },
                                        ),
                                      )

                                    ],
                                  );
                                },
                              );
                          },
                        )

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
       ),

      floatingActionButton: FloatingActionButton(

        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FavoritesPage(
                favoriteSongs: favoriteSongs,),
            ),
          );
        },
        child: Icon(Icons.favorite,color: Colors.red,),
        backgroundColor: Colors.white,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12,left: 12,right: 12,bottom: 10),
                child: TextFormField(
                  controller: searchController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,

                    hintText: 'Search by song, artist, or movie',
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              
              Text('Try somethig else',style: GoogleFonts.roboto(fontSize: 20,color: Colors.white),textAlign: TextAlign.start,),
              _buildAlbumGrid(),
              SizedBox(height: 10),
              Text('Artist you like',style: GoogleFonts.roboto(fontSize: 20,color: Colors.white),textAlign: TextAlign.start,),
              _buildArtistSection(),
              SizedBox(height: 10),
              Text('Recommended Stations',style: GoogleFonts.roboto(fontSize: 20,color: Colors.white),textAlign: TextAlign.start,),
              SizedBox(height: 10),
              _buildPlaylistList(),
              // _buildFavoritesList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildArtistSection() {
    return SizedBox(
      height: 60,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: artistList.length,
          itemBuilder: (context, index) {
            final artist = artistList[index];
            final isSelected = artist == selectedArtist;
            return GestureDetector(
              onTap: () => filterByArtist(artist),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: isSelected ? Colors.pink : Colors.white,
                ),
                child: Center(
                  child: Text(
                    artist,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPlaylistList() {
    return Container(
      height:700,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        itemCount: filteredAudios.length,
        itemBuilder: (context, index) {
          final audio = filteredAudios[index];
          final isFavorite = favoriteSongs.contains(audio);
          return GestureDetector(
            onTap: () {
              setState(() {
                currentSongIndex = index;
              });
              player.open(
                audio,
                showNotification: true,
                autoStart: true,
              );
            },
            child: Container(
              height: 100,
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // color: Colors.grey[700],
                color: Colors.white
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        audio.metas.image?.path ?? '',
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          audio.metas.title ?? "Unknown Title",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          audio.metas.artist ?? "Unknown Artist",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (isFavorite) {
                          favoriteSongs.remove(audio);
                        } else {
                          favoriteSongs.add(audio);
                        }
                      });
                    },
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAlbumGrid() {
    final albums = getAlbums();
    return SizedBox(
      height: 80,
      child: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: albums.length,
          itemBuilder: (context, index) {
            final album = albums[index];
            final isSelected = album == selectedAlbum;
            return GestureDetector(
              onTap: () => filterByAlbum(album),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  height: 200,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: isSelected ? Colors.pink : Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      album,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class FavoritesPage extends StatefulWidget {
  final List<Audio> favoriteSongs;

  FavoritesPage({required this.favoriteSongs});

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer();
  int _currentSongIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.favoriteSongs.isNotEmpty) {
      _openSong(widget.favoriteSongs[_currentSongIndex]);
    }
  }

  void _openSong(Audio audio) {
    _audioPlayer.open(
      audio,
      autoStart: true,
      showNotification: true,
    );
  }

  void _playOrPause() {
    _audioPlayer.playOrPause();
  }

  void _nextSong() {
    if (_currentSongIndex < widget.favoriteSongs.length - 1) {
      setState(() {
        _currentSongIndex++;
      });
      _openSong(widget.favoriteSongs[_currentSongIndex]);
    }
  }

  void _previousSong() {
    if (_currentSongIndex > 0) {
      setState(() {
        _currentSongIndex--;
      });
      _openSong(widget.favoriteSongs[_currentSongIndex]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(onPressed: (){Navigator.of(context).pop;}, icon:Icon(Icons.arrow_back,color: Colors.white,) ),
      ),
      body: Column(
        children: [

          Column(
            children: [
              Text('Liked Songs ',style: GoogleFonts.rancho(
                color: Colors.white,
                fontSize: 30,
              ),)
            ],
          ),
          Expanded(
            child: widget.favoriteSongs.isEmpty
                ? Center(
              child: const Text(
                "No favorite songs yet!",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              itemCount: widget.favoriteSongs.length,
              itemBuilder: (context, index) {
                final audio = widget.favoriteSongs[index];
                final isFavorite = true;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentSongIndex = index;
                    });
                    _openSong(audio);
                    //
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => SongView(audio: audio),
                    //   ),
                    // );
                  },
                  child: Container(
                    height: 100,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              audio.metas.image?.path ?? '',
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                audio.metas.title ?? "Unknown Title",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                audio.metas.artist ?? "Unknown Artist",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.roboto(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              // Logic to remove from favorites (if applicable)
                              widget.favoriteSongs.remove(audio);
                            });
                          },
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.skip_previous, color: Colors.white),
                onPressed: _previousSong,
              ),
              StreamBuilder<bool>(
                stream: _audioPlayer.isPlaying,
                builder: (context, snapshot) {
                  final isPlaying = snapshot.data ?? false;
                  return IconButton(
                    icon: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                    ),
                    onPressed: _playOrPause,
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.skip_next, color: Colors.white),
                onPressed: _nextSong,
              ),
            ],
          ),
          StreamBuilder<Duration>(
            stream: _audioPlayer.currentPosition,
            builder: (context, snapshot) {
              final currentPosition = snapshot.data ?? Duration.zero;
              final totalDuration = _audioPlayer.current.value?.audio.duration ?? Duration.zero;

              return Column(
                children: [
                  Slider(
                    value: currentPosition.inSeconds.toDouble(),
                    max: totalDuration.inSeconds.toDouble(),
                    onChanged: (value) {
                      _audioPlayer.seek(Duration(seconds: value.toInt()));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatDuration(currentPosition),
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          _formatDuration(totalDuration),
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),

        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
