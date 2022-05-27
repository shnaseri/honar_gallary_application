import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:petstore_api/api.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  User contact;

  ChatCubit({required this.contact}) : super(ChatInitial());

  Future<void> fetchConnect() async {
    try {
      contact = contact;
      // await chatRepository.connectMMQT(contact.token);
      // List<Message> messages = await chatRepository.getMessages(contact.id);
      // emit(ChatConnectToServer(messages));
    } catch (error) {
      rethrow;
    }
  }

  void disconnectMq() {
    // chatRepository.disConnectMQTT();
  }

  Future<void> publishMessage(User user, String message) async {
    try {
      // emit(ChatSendMessage());
      // await chatRepository.pushMessage(user, message);
      // await chatRepository.subscribeMessage(user);

      // List<Message> messages = await chatRepository.getMessages(user.id);
      // emit(ChatConnectToServer(messages));
    } catch (error) {
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
