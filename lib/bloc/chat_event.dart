part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent{}


class ChatGenerateNewTextMessage extends ChatEvent{
  final String inputMessage;

  ChatGenerateNewTextMessage({required this.inputMessage});
}