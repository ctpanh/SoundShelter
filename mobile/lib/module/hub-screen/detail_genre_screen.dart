import 'package:flutter/material.dart';
import 'package:mobile/components/card/custom_card.dart';
import 'package:mobile/components/title/screen_header.dart';
import 'package:mobile/provider/album_provider.dart';
import 'package:provider/provider.dart';

class DetailGenreScreen extends StatefulWidget {
  final int genreId;
  final String label;
  const DetailGenreScreen(
      {super.key, required this.genreId, required this.label});

  @override
  State<DetailGenreScreen> createState() => _DetailGenreScreenState();
}

class _DetailGenreScreenState extends State<DetailGenreScreen> {
  @override
  void initState() {
    super.initState();
    final albumProvider = Provider.of<AlbumProvider>(context, listen: false);
    albumProvider.getAlbumsByGenre(widget.genreId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScreenHeader(title: widget.label),
      extendBodyBehindAppBar: true,
      body: Consumer<AlbumProvider>(builder: (context, albumProvider, child) {
        return Container(
          padding: EdgeInsets.all(10),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.9,
            children: List.generate(
              albumProvider.albums.length,
              (index) {
                return CustomCard(
                    title: albumProvider.albums[index].title,
                    imgFilePath: albumProvider.albums[index].imageFilePath);
              },
            ),
          ),
        );
      }),
    );
  }
}
