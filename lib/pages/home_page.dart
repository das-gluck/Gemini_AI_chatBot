import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:space_ai/bloc/chat_bloc.dart';
import 'package:space_ai/models/chat_message_model.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    TextEditingController controller = TextEditingController();
    final ChatBloc chatBloc = ChatBloc();

    return Scaffold(
      body: BlocConsumer<ChatBloc,ChatState>(
          bloc: chatBloc,
          listener: (context,state){},
          builder: (context,state){
            switch(state.runtimeType){
              case ChatSuccessState:
                List<ChatMessageModel> messages = (state as ChatSuccessState).message;
                return Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      opacity: 1.8,
                      image: AssetImage("assets/space2.jpeg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                        height: 100,
                        //color: Colors.red,
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Space Bot",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 29),),
                            // CircleAvatar(
                            //   radius: 20,
                            //   backgroundColor: Colors.white,
                            //   child: CircleAvatar(
                            //     radius: 18,
                            //     backgroundColor: Colors.black,
                            //     child: Center(
                            //       child: Icon(Icons.image_search,color: Colors.white,),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: ListView.builder(
                            itemCount: messages.length,
                            itemBuilder: (context,index){
                              return Container(
                                margin: const EdgeInsets.only(bottom: 12,left: 16,right: 16),
                                padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.amber.withOpacity(0.8) ,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(messages[index].role == "user"?"**User**":"**Bot**",
                                      style: TextStyle(
                                        fontSize: 19,
                                        color: messages[index].role == "user"?Colors.indigo:Colors.indigo
                                      ),),
                                      const SizedBox(height: 12,),
                                      Text(messages[index].parts.first.text,style: const TextStyle(height: 1.2,color: Colors.black,fontSize: 19),),
                                    ],
                                  )
                              );
                        },
                      ),),
                      if(chatBloc.generating) Row(
                        children: [
                          Container(
                            height: 90,
                            width: 100,
                            child: Lottie.asset('assets/loader2.json'),
                          ),
                          const SizedBox(width: 40,),
                          const Text("Loading . . . ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: controller,
                                style: const TextStyle(color: Colors.black,fontSize: 18),
                                cursorColor: Theme.of(context).primaryColor,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "Ask Something to Space Bot",
                                  hintStyle: TextStyle(color: Colors.grey.shade400,fontSize: 18),
                                  focusedBorder:OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor
                                      ),
                                      borderRadius: BorderRadius.circular(100)
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12,),
                            InkWell(
                              onTap: (){
                                if(controller.text.isNotEmpty){
                                  String text = controller.text;
                                  controller.clear();
                                  chatBloc.add(ChatGenerateNewTextMessage(inputMessage: text));
                                }
                              },
                              child: CircleAvatar(
                                radius: 32,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Theme.of(context).primaryColor,
                                  child: const Center(
                                    child: Icon(Icons.send,color: Colors.white,),
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                );
              default:
                return const SizedBox();

            }
        },
      ),
    );
  }
}
