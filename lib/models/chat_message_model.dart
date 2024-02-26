

import 'dart:convert';

class ChatMessageModel{

  final String role;
  final List<ChatPartsModel> parts;
  ChatMessageModel({required this.role, required this.parts});

  Map<String,dynamic> toMap() {
    return {
      'role' : role,
      'parts' : parts.map((x) => x.toMap()).toList(),
    };
  }

  factory ChatMessageModel.fromMap(Map<String,dynamic> map){
    return ChatMessageModel(
        role: map['role'] ?? '',
        parts: List<ChatPartsModel>.from(
            map['parts']?.map((x) => ChatPartsModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());
  factory ChatMessageModel.fromJson(String source) => ChatMessageModel.fromMap(jsonDecode(source));


}

class ChatPartsModel{
  final String text;
  ChatPartsModel({required this.text});

  Map<String, dynamic> toMap() {
    return {
      'text': text,
    };
  }

  String toJson() => json.encode(toMap());

  factory ChatPartsModel.fromMap(String source) {
    Map<String, dynamic> map = json.decode(source);
    return ChatPartsModel(
      text: map['text'],
    );
  }

}