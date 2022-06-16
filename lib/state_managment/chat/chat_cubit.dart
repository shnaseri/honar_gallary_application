import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:honar_api_v3/api.dart';
import 'package:honar_gallary/data_managment/chat/chat_repository.dart';
import 'package:honar_gallary/logic/consts.dart';
import 'package:meta/meta.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  User contact;
  late ChatRepository chatRepository;
  late WebSocketChannel channel;
  bool isWebSocketRunning = false;
  int retryLimit = 1;

  ChatCubit({required this.contact}) : super(ChatInitial()) {
    chatRepository = ChatRepository();
  }

  Future<void> fetchConnect(String chatCode) async {
    try {
      if (isWebSocketRunning) return; //chaech if its already running
      contact = contact;
      // await chatRepository.connectMMQT(contact.token);
      // List<Message> messages = await chatRepository.getMessages(contact.id);
      // emit(ChatConnectToServer(messages));
      var url =
          "ws://188.121.110.151:8000/socket/chat/$chatCode/?token=${(interfaceOfUser.authentications['Bearer'] as ApiKeyAuth).apiKey}";
      channel = WebSocketChannel.connect(Uri.parse(url));
      print(url);

      channel.stream.listen(
        (event) {
          print("-- listen response ");
          print(event);
        },
        onDone: () {
          print("Done");
          isWebSocketRunning = false;
        },
        onError: (err) {
          print(err);
          isWebSocketRunning = false;
          if (retryLimit > 0) {
            retryLimit--;
            fetchConnect(chatCode);
          }
        },
      );
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  void disconnectMq() {
    // chatRepository.disConnectMQTT();
  }

  Future<void> publishMessage(
      User user, String message, List<Message> oldMessages) async {
    try {
      print('---- Send Message ------');
      // emit(ChatSendMessage());
      Message newMessage = await chatRepository.pushMessage(user, message);
      var jsonEncode2 =
          jsonEncode({"message": newMessage.content, "type": "T"});
      print(jsonEncode2);
      channel.sink.add(jsonEncode2);

      // List<Message> messages = await chatRepository.getMessages(user.id);
      List<Message> messages = oldMessages.toList();
      messages.add(newMessage);
      print('---- End Send Message ------');
      emit(ChatConnectToServer(messages));
    } catch (error) {
      print(error);
      emit(ChatErrorState());
    }
  }

  functionForSubscribe(String message) async {
    // await chatRepository.getNewMessageAdd(contact, message, false);
    // List<Message> messages = await chatRepository.getMessages(contact.id);
    // emit(ChatConnectToServer(messages));
  }

  Future<void> deleteMessage(int index) async {
    try {
      // emit(ChatSendMessage());// await chatRepository.subscribeMessage(user);

      // await MessageRepository.messageRepository
      //     .deleteMessage(index, contact.id);
      // List<Message> messages = await chatRepository.getMessages(contact.id);
      // emit(ChatConnectToServer(messages));
    } catch (error) {
      rethrow;
    }
  }
}
