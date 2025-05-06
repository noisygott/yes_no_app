import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/domain/entities/messages.dart';
import 'package:yes_no_app/presentation/providers/chat_provider.dart';
import 'package:yes_no_app/presentation/widgets/Chat/her_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/Chat/my_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/shared/message_field_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              'https://imgs.search.brave.com/TcOLZwIndzV1NH0XPrhSZ02v_wP78Bb_T4fIIHFA7uk/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9oaXBz/LmhlYXJzdGFwcHMu/Y29tL2htZy1wcm9k/L2ltYWdlcy9zY2Fy/bGV0dC1qb2hhbnNz/b24tNjdkMzM1Zjcy/NjI2NS5qcGc_Y3Jv/cD0xLjAweHc6MS4w/MHhoOzAsMCZyZXNp/emU9NjQwOio',
            ),
          ),
        ),
        title: Text('Mi Amor'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: _ChatView(),
      ),
    );
  }
}

class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      left: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Expanded(
              child: Consumer<ChatProvider>(
                builder: (context, chatProvider, child) {
                  return ListView.builder(
                    controller: chatProvider.chatScrollController,
                    itemCount: chatProvider.messagesList.length,
                    itemBuilder: (context, index) {
                      final message = chatProvider.messagesList[index];
                      return (message.fromWho == FromWho.mi)
                          ? MyMessageBubble(message: message)
                          : HerMessageBubble(message: message,);
                    },
                  );
                },
              ),
            ),

            ///Caja de Texto de mensajes
            MessageFieldBox(
              //onValue:(value) => chatProvider.sendMessage(value),
              onValue: chatProvider.sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
