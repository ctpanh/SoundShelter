import 'package:flutter/material.dart';
import 'package:mobile/module/comment/comment_item.dart';

class CommentModal extends StatefulWidget {
  const CommentModal({super.key});

  @override
  State<CommentModal> createState() => _CommentModalState();
}

class _CommentModalState extends State<CommentModal>
    with TickerProviderStateMixin {
  final _textEditingController = TextEditingController();
  List<CommentItem> items = [
    CommentItem(
      accountName: "Tam",
      comment: "Hay quá",
      date: "15/06/2024",
    ),
    CommentItem(
      accountName: "Thủy",
      comment: "Tuyệt vời",
      date: "13/06/2024",
    ),
    CommentItem(
      accountName: "Phanh",
      comment: "Nên nghe",
      date: "10/06/2024",
    ),
  ];

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => Container(
              color: Theme.of(context).colorScheme.background,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${items.length} bình luận",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )),
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.close)),
                          ],
                        ),
                        const Divider(),
                        // input comment
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.account_circle_outlined,
                                size: 50,
                                color: Color(0xFFB2572B),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: TextField(
                                  maxLines: null,
                                  onSubmitted: (value) {},
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    hintText: 'Nhập bình luận',
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400]),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    fillColor: Colors.grey[200],
                                    filled: true,
                                  ),
                                  controller: _textEditingController,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    //comment detail
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: ListView.separated(
                          itemCount: items.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(
                            height: 5,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return CommentItem(
                              accountName: "Tam",
                              comment: "Hay quá",
                              date: "15/06/2024",
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        icon: const Icon(Icons.comment_outlined));
  }
}
