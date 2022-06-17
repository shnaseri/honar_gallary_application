import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:honar_api_v10/api.dart';
import 'package:honar_gallary/data_managment/chat/chat_repository.dart';
import 'package:honar_gallary/logic/consts.dart';
import 'package:honar_gallary/logic/general_values.dart';
import 'package:meta/meta.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  User contact;
  late ChatRepository chatRepository;
  late WebSocketChannel channel;
  bool isWebSocketRunning = false;
  int retryLimit = 1;
  late ChatApi chatApi;

  ChatCubit({required this.contact}) : super(ChatInitial()) {
    chatRepository = ChatRepository();
    chatApi = ChatApi(interfaceOfUser);
  }

  Future<void> fetchConnect(String chatCode) async {
    try {
      if (isWebSocketRunning) return; //chaech if its already running
      List<Message> messages =
          await chatApi.chatGetAllChatMessagesList(chatCode);
      messages = messages.reversed.toList();
      print(messages);

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
          listenImage(event);
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
      emit(ChatConnectToServer(messages));
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  void disconnectMq() {
    // chatRepository.disConnectMQTT();
  }

  Future<void> publishMessage(User user, String message) async {
    try {
      print('---- Send Message ------');
      // emit(ChatSendMessage());
      Message newMessage = await chatRepository.pushMessage(user, message);
      var jsonEncode2 =
          jsonEncode({"message": newMessage.content, "type": "T"});
      print(jsonEncode2);
      channel.sink.add(jsonEncode2);
      print('---- End Send Message ------');
      emit(ChatSendMessage(newMessage));
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

  void listenImage(String event) {
    // I/flutter (24364): {"type": "T", "message": "slmmmm mm", "id": 9, "sender_id": 21, "time": "2022-06-17T05:56:19.0Z"}

    try {
      dynamic jsonRes = json.decode(event);
      print(jsonRes["sender_id"]);
      print((ConfigGeneralValues.configGeneralValues?.userId));
      print(jsonRes["sender_id"] ==
          (ConfigGeneralValues.configGeneralValues?.userId));
      if (jsonRes["sender_id"] ==
          (ConfigGeneralValues.configGeneralValues?.userId)) return;
      Message newMessage = Message(
          id: jsonRes['id'],
          content: jsonRes["message"],
          type: "text",
          isUserSender: jsonRes["sender_id"] ==
              (ConfigGeneralValues.configGeneralValues?.userId),
          createdAt: DateTime.parse(jsonRes["time"]));
      print('---- End Send Message ------');
      emit(ChatSendMessage(newMessage));
    } catch (e) {}
  }

  void changeState(List<Message> messages) {
    emit(ChatConnectToServer(messages));
  }
}
