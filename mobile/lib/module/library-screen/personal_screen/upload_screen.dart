import 'package:flutter/material.dart';
import 'package:mobile/components/card/music_item.dart';
import 'package:mobile/components/title/screen_header.dart';
import 'package:mobile/components/upload-widget/upload_widget.dart';
import 'package:mobile/module/sign-in-screen/sign_in_screen.dart';
import 'package:mobile/provider/upload_provider.dart';
import 'package:mobile/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  void _handleLoginTap(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignInScreen()));
  }

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (userProvider.currentUser != null) {
      final uploadProvider =
          Provider.of<UploadProvider>(context, listen: false);
      uploadProvider.getAllUploadSong(userProvider.currentUser!.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UploadProvider>(builder: (context, uploadProvider, child) {
      return Scaffold(
          appBar: const ScreenHeader(
            title: "Tải lên",
          ),
          backgroundColor: const Color(0xFFDCD1B3),
          body: Consumer<UserProvider>(builder: (context, userProvider, child) {
            return SafeArea(
                child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height,
                    padding: const EdgeInsets.all(10.0),
                    child: userProvider.currentUser != null
                        ? Column(
                            children: [
                              FileUploadWidget(),
                              Container(
                                height: 580,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: GridView.count(
                                  scrollDirection: Axis.vertical,
                                  crossAxisCount: 1,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 15,
                                  padding: const EdgeInsets.all(2),
                                  childAspectRatio: 5,
                                  children: List.generate(
                                    uploadProvider.songs.length,
                                    (index) {
                                      final song = uploadProvider.songs[index];
                                      return MusicItem(
                                          songProvider: uploadProvider,
                                          song: song,
                                          add: true,
                                          index: index,
                                          playlist: uploadProvider.songs);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: RichText(
                              text: TextSpan(
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: <TextSpan>[
                                    const TextSpan(
                                      text: 'Bạn cần ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: 'đăng nhập',
                                      style: const TextStyle(
                                          color: Color(0xFFB2572B),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap =
                                            () => _handleLoginTap(context),
                                    ),
                                    const TextSpan(
                                      text: ' để sử dụng tính năng này.',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ]),
                            ))));
          }));
    });
  }
}
