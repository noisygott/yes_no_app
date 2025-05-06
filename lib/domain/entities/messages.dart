import 'package:intl/intl.dart';

enum FromWho { mi, hers }

class Messages {
  final String text;
  final String? imageUrl;
  final FromWho fromWho;
  final String timesTamp;

  Messages({
    required this.text, 
    this.imageUrl, 
    required this.fromWho, 
    required DateTime timesTamp
  }) : timesTamp = DateFormat('hh:mm a').format(timesTamp);
}
