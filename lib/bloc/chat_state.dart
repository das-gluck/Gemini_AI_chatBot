part of 'chat_bloc.dart';

@immutable
sealed class ChatState{}

final class ChatInitial extends ChatState{}


class ChatSuccessState extends ChatState{
  final List<ChatMessageModel> message;
  ChatSuccessState({required this.message});
}