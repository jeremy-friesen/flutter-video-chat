class Message {
  //final Group group; 
  //final User sender; 
  final String text; 
  final bool isReacted; 
  var lastMessageTime;

  Message({this.text, this.isReacted, this.lastMessageTime});

}