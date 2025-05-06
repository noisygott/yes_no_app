import 'package:flutter/material.dart';

class MessageFieldBox extends StatefulWidget {
  final ValueChanged<String> onValue;

  const MessageFieldBox({super.key, required this.onValue});

  @override
  State<MessageFieldBox> createState() => _MessageFieldBoxState();
}

class _MessageFieldBoxState extends State<MessageFieldBox> {
  late TextEditingController texController;
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    texController = TextEditingController(); // Inicialización
    focusNode = FocusNode(); // Inicialización
  }

  @override
  void dispose() {
    texController.dispose(); // Liberar recursos
    focusNode.dispose(); // Liberar recursos
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final outlineInputBorder = UnderlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(40),
    );

    final inputDecoration = InputDecoration(
      hintText: 'End Your Message with a "?"',
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      filled: true,
      suffixIcon: IconButton(
        onPressed: () {
          final texValue = texController.text;
          texController.clear();
          widget.onValue(texValue);
          focusNode.requestFocus(); // Mantener el foco después de enviar
        },
        icon: const Icon(Icons.send_outlined),
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: TextFormField(
        focusNode: focusNode,
        controller: texController,
        decoration: inputDecoration,
        onFieldSubmitted: (value) {
          widget.onValue(value);
          texController.clear();
          focusNode.requestFocus(); // Mantener el foco después de enviar
        },
      ),
    );
  }
} //Fin class