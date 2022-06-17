import 'package:honar_api_v13/api.dart';

import 'chat_networkService.dart';

class ChatRepository {
  late ChatNetworkService chatNetworkService;

  // late MqttServerClient client;
  ChatRepository() {
    chatNetworkService = ChatNetworkService();
  }

  connectMMQT(String userToken) async {
    try {
      // client  = (await chatNetworkService.connectMQTT(otpToken,userToken)) ?? client;
    } catch (error) {
      rethrow;
    }
  }

  disConnectMQTT() {
    // client.disconnect();
  }

  pushMessage(User user, String messageText) async {
    try {
      // String otpToken = GeneralValues.generalValues.token;
      // await chatNetworkService.pushMessageToServer(otpToken,user.token,messageText);
      Message message = await getNewMessageAdd(user, messageText, true);
      return message;
    } catch (error) {
      rethrow;
    }
  }

  Future<Message> getNewMessageAdd(
      User user, String messageText, bool own) async {
    var message = Message(
        content: messageText,
        isUserSender: own,
        type: "text",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now());
    return message;
  }

  getMessages(int id) {
    // return MessageRepository.messageRepository.getMessagesById(id);
  }

  subscribeMessage(String message) async {
    try {
      // todoSubscribe(message);
    } catch (error) {
      rethrow;
    }
  }
}
