import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_ai/repo/chat_repo.dart';

import '../models/chat_message_model.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent,ChatState>{
  ChatBloc() : super(ChatSuccessState(message: [])) {
    on<ChatGenerateNewTextMessage>(chatGenerateNewTextMessage);
  }



  List<ChatMessageModel> messages = [];
  bool generating = false;

  FutureOr<void> chatGenerateNewTextMessage(
      ChatGenerateNewTextMessage event, Emitter<ChatState> emit) async{
    messages.add(ChatMessageModel(role: "user", parts: [
      ChatPartsModel(text: event.inputMessage)
    ]));
    emit(ChatSuccessState(message: messages));
    generating = true;
    String generatedText = await ChatRepo.chatTextGenerationRepo(messages);
    if(generatedText.length>0){
      messages.add(ChatMessageModel(role: 'model', parts: [ChatPartsModel(text: generatedText)]));
      emit(ChatSuccessState(message: messages));
    }
    generating = false;

  }






}