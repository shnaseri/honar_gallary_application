import 'package:bloc/bloc.dart';
import 'package:honar_api_v3/api.dart';
import 'package:honar_gallary/data_managment/chat/chat_repository.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  User contact;
  late ChatRepository chatRepository;

  ChatCubit({required this.contact}) : super(ChatInitial()) {
    chatRepository = ChatRepository();
  }

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

  Future<void> publishMessage(
      User user, String message, List<Message> oldMessages) async {
    try {
      // emit(ChatSendMessage());
      Message newMessage = await chatRepository.pushMessage(user, message);
      // await chatRepository.subscribeMessage(user);

      // List<Message> messages = await chatRepository.getMessages(user.id);
      List<Message> messages = oldMessages.toList();
      messages.add(newMessage);
      emit(ChatConnectToServer(messages));
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
