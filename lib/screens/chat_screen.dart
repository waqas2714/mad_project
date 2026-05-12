import 'dart:async';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final List<_ChatMessage> _messages = [];
  bool _isTyping = false;

  void _sendMessage() {
    if (_controller.text.isEmpty) return;
    
    _addMessage(_controller.text, true);
    _controller.clear();
    setState(() => _isTyping = true);

    Timer(Duration(milliseconds: 1500), () {
      _addMessage("Processing your request through the neural net...", false);
      setState(() => _isTyping = false);
    });
  }

  void _addMessage(String text, bool isUser) {
    // Setup for Animation 6: SlideTransition
    AnimationController animController = AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _ChatMessage message = _ChatMessage(text: text, isUser: isUser, animationController: animController);
    
    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();
  }

  @override
  void dispose() {
    for (var message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Neural Link AI")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true, // List builds from bottom up
              padding: EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) => _messages[index],
            ),
          ),
          if (_isTyping)
            Padding(
              padding: EdgeInsets.all(8.0),
              child: LinearProgressIndicator(color: Color(0xFF6C63FF), backgroundColor: Colors.transparent),
            ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(color: Colors.black26),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Input query...',
                      hintStyle: TextStyle(color: Colors.white54),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                FloatingActionButton(
                  mini: true,
                  backgroundColor: Color(0xFF6C63FF),
                  onPressed: _sendMessage,
                  child: Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;
  final AnimationController animationController;

  _ChatMessage({required this.text, required this.isUser, required this.animationController});

  @override
  Widget build(BuildContext context) {
    // Animation 6: SlideTransition + Fade for incoming messages
    return SlideTransition(
      position: Tween<Offset>(begin: Offset(0, 1), end: Offset.zero).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOutQuart)
      ),
      child: FadeTransition(
        opacity: animationController,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: isUser ? Color(0xFF6C63FF) : Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(isUser ? 20 : 0),
                bottomRight: Radius.circular(isUser ? 0 : 20),
              ),
            ),
            child: Text(text, style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
        ),
      ),
    );
  }
}