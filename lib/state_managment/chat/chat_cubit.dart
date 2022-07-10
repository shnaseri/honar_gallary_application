import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:honar_api_v18/api.dart';
import 'package:honar_gallary/data_managment/chat/chat_repository.dart';
import 'package:honar_gallary/data_managment/core/upload_networkservice.dart';
import 'package:honar_gallary/logic/consts.dart';
import 'package:honar_gallary/logic/general_values.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ArtGalleryRead200ResponseOwner contact;
  late ChatRepository chatRepository;
  late WebSocketChannel channel;
  bool isWebSocketRunning = false;
  int retryLimit = 1;
  late ChatApi chatApi;
  late CoreApi coreApi;
  late List<Message> messages;

  ChatCubit({required this.contact}) : super(ChatInitial()) {
    chatRepository = ChatRepository();
    chatApi = ChatApi(interfaceOfUser);
    messages = [];
    coreApi = CoreApi(interfaceOfUser);
  }

  Future<void> fetchConnect(String chatCode) async {
    try {
      print(chatCode);
      emit(ChatConnectingToServer());
      if (isWebSocketRunning) return; //chaech if its already running
      try {
        messages = (await chatApi.chatGetAllChatMessagesList(chatCode))!;
        messages = messages.reversed.toList();
      } catch (e) {
        messages = [];
      }
      print(messages);

      contact = contact;
      // await chatRepository.connectMMQT(contact.token);
      // List<Message> messages = await chatRepository.getMessages(contact.id);
      // emit(ChatConnectToServer(messages));
      var url =
          "ws://188.121.110.151:8000/socket/chat/$chatCode/?token=${(interfaceOfUser.authentication as HttpBearerAuth).accessToken}";
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
      emit(ChatErrorState());
      rethrow;
    }
  }

  void disconnectMq() {
    // chatRepository.disConnectMQTT();
  }

  Future<void> publishMessage(
      ArtGalleryRead200ResponseOwner user, String message) async {
    try {
      print('---- Send Message ------');
      // emit(ChatSendMessage());
      Message newMessage = await chatRepository.pushMessage(user, message);
      var jsonEncode2 =
          jsonEncode({"message": newMessage.content, "type": "T"});
      print(jsonEncode2);
      channel.sink.add(jsonEncode2);
      print('---- End Send Message ------');
      messages = [...messages, newMessage];

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

  void listenImage(String event) {
    // I/flutter (24364): {"type": "T", "message": "slmmmm mm", "id": 9, "sender_id": 21, "time": "2022-06-17T05:56:19.0Z"}

    try {
      dynamic jsonRes = json.decode(event);
      print(jsonRes["sender_id"]);
      print((ConfigGeneralValues.getInstance().userId));
      print(jsonRes["sender_id"] == (ConfigGeneralValues.getInstance().userId));
      if (jsonRes["sender_id"] == (ConfigGeneralValues.getInstance().userId) &&
          jsonRes["type"] == "T") return;
      var baseimage = (interfaceOfUser.basePath
              .substring(0, interfaceOfUser.basePath.length - 4) +
          jsonRes["message"]);
      print(baseimage);
      var message = Message(
          id: jsonRes['id'],
          content: jsonRes["type"] != "P" ? jsonRes["message"] : baseimage,
          type: jsonRes["type"],
          isUserSender: jsonRes["sender_id"] ==
              (ConfigGeneralValues.getInstance().userId),
          createdAt: DateTime.parse(jsonRes["time"]));
      Message newMessage = message;
      print('---- End Send Message ------');
      messages = [...messages, newMessage];
      emit(ChatConnectToServer(messages));
    } catch (e) {
      print(e);
    }
  }

  void changeState(List<Message> messages) {
    emit(ChatConnectToServer(messages));
  }

  Future<int?> uploadImage(File file) async {
    try {
      Map output = await UploadNetworkService().uploadImage(file);
      print(output);
      int imageId = output['id'];
      var jsonEncode2 = jsonEncode({"message": imageId, "type": "P"});
      print(jsonEncode2);
      channel.sink.add(jsonEncode2);
      print('---- End Send Message ------');
      return imageId;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future uploadVideo(File fileSelected) async {
    try {
      CoreContentUpdate200Response? response = await coreApi.coreContentUpdate(
          await http.MultipartFile.fromPath('file', fileSelected.path));
      print(response!.contentId);
      int videoId = response.contentId!;
      var jsonEncode2 = jsonEncode({"message": videoId, "type": "V"});
      channel.sink.add(jsonEncode2);
    } catch (e) {}
  }
}
