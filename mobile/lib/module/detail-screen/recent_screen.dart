import 'package:flutter/material.dart';
import 'package:mobile/components/card/music_item.dart';
import 'package:mobile/components/title/screen_header.dart';
import 'package:mobile/model/song_model.dart';
import 'package:mobile/provider/song_provider.dart';
import 'package:provider/provider.dart';

class RecentScreen extends StatefulWidget {
  final List<Song> songs;
  const RecentScreen({super.key, required this.songs});

  @override
  State<RecentScreen> createState() => _RecentScreenState();
}

class _RecentScreenState extends State<RecentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScreenHeader(
        title: "Nghe gần đây",
      ),
      backgroundColor: const Color(0xFFDCD1B3),
      body: Consumer<SongProvider>(
        builder: (context, songProvider, child) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: ListView.separated(
              padding: EdgeInsets.all(10.0),
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 10,
                );
              },
              scrollDirection: Axis.vertical,
              itemCount: widget.songs.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                final song = widget.songs[index];
                return MusicItem(
                    songProvider: songProvider,
                    song: song,
                    add: true,
                    index: index,
                    playlist: widget.songs);
              },
            ),
          );
        },
      ),
    );
  }
}
