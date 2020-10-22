import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getting_started/message.dart';

class ChatView extends StatefulWidget {
  ChatView({Key key, this.title, @required this.messages}) : super(key: key);

  final String title;
  final List<Message> messages;

  @override
  ChatViewState createState() => ChatViewState();
}

class ChatViewState extends State<ChatView> {
  List<Widget> messagesBox = [];
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
    return Scaffold(
      body: ListView.builder(
          controller: _scrollController,
          itemCount: widget.messages.length,
          itemBuilder: (context, idx) {
            DateFormat format = DateFormat('yyyy-MM-dd KK:mm a');
            return Card(
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.chat),
                        title: Stack(
                          children: <Widget>[
                            Text(
                              widget.messages[idx].username,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Text(
                                format.format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      widget.messages[idx].createdAt),
                                ),
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        subtitle: Text(widget.messages[idx].value),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
