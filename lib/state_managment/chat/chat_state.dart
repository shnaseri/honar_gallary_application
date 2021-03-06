part of 'chat_cubit.dart';

@immutable
abstract class ChatState {
  const ChatState();
}

class ChatInitial extends ChatState {}

class ChatConnectingToServer extends ChatState {}

class ChatConnectToServer extends ChatState {
  final List<Message> messages;

  const ChatConnectToServer(this.messages) : super();
}

class ChatSendMessage extends ChatState {
  final Message message;

  const ChatSendMessage(this.message) : super();
}

class ChatErrorState extends ChatState {}
