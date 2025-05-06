import 'package:flutter/material.dart';
import 'package:yes_no_app/config/helpers/get_yes_no_answer.dart';
import 'package:yes_no_app/domain/entities/messages.dart';

class ChatProvider extends ChangeNotifier {
  final ScrollController chatScrollController = ScrollController();
  final getYesNoAnswer = GetYesNoAnswer();

  List<Messages> messagesList = [
    Messages(text: 'Hola ', fromWho: FromWho.mi, timesTamp: DateTime.now()),
    Messages(text: 'ya regresaste del trabajo?', fromWho: FromWho.mi, timesTamp: DateTime.now()),
  ];

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;

    final newMessage = Messages(text: text, fromWho: FromWho.mi, timesTamp: DateTime.now());
    messagesList.add(newMessage);

    if (text.endsWith("?")) {
      herReply();
    }

    notifyListeners();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      moveScrollToBottom();
    });
  }

  Future<void> herReply() async {
    final herMessage = await getYesNoAnswer.getAnswer();
    messagesList.add(herMessage);
    notifyListeners();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      moveScrollToBottom();
    });

  }

  void moveScrollToBottom() {
    chatScrollController.animateTo(
      chatScrollController.position.maxScrollExtent,

      ///la posicion
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,

      ///Que tipo de animacion quiero
    );
  }
}
