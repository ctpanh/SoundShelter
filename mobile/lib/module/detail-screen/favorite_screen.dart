import 'package:flutter/material.dart';
import 'package:mobile/components/card/big_square_card.dart';
import 'package:mobile/components/title/screen_header.dart';
import 'package:mobile/model/song_model.dart';
import 'package:mobile/module/song-screen/full_playing_view.dart';
import 'package:mobile/provider/song_provider.dart';
import 'package:mobile/provider/user_provider.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  final List<Song> songs;
  const FavoriteScreen({super.key, required this.songs});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScreenHeader(
        title: "Bài hát yêu thích",
      ),
      backgroundColor: const Color(0xFFDCD1B3),
      body: Consumer<SongProvider>(
        builder: (context, songProvider, child) {
          return Consumer<UserProvider>(
            builder: (context, userProvider, child) {
              return Container(
                padding: EdgeInsets.all(10),
                child: GridView.count(
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  children: List.generate(
                    widget.songs.length,
                    (index) {
                      final song = widget.songs[index];
                      return BigSquareCard(
                        onTap: () {
                          songProvider
                              .getRecommendation(userProvider.currentUser!.id);
                          songProvider.createHistory(
                              userProvider.currentUser!.id, song.id!);
                          songProvider.setPlayingSongs(widget.songs);
                          songProvider.currentSongIndex = index;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullPlayingView(),
                            ),
                          );
                        },
                        title: song.title,
                        subtitle: song.artist,
                        subtext: false,
                        imgFilePath: song.imageFilePath,
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
