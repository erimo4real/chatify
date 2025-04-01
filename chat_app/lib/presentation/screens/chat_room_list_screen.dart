import 'package:flutter/material.dart';

class ChatRoomListScreen extends StatelessWidget {
  
  final List<Map<String, dynamic>> chatRooms = [
    {"id": "1", "name": "General Chat"},
    {"id": "2", "name": "Flutter Devs"},
    {"id": "3", "name": "Node.js Developers"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Rooms"),
      ),
      body: ListView.builder(
        itemCount: chatRooms.length,
        itemBuilder: (context, index) {
          final chatRoom = chatRooms[index];

          return ListTile(
            title: Text(chatRoom['name']),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/chat',  // Navigate to Chat Screen
                arguments: chatRoom,  // Pass Chat Room Data
              );
            },
          );
        },
      ),
    );
  }
}
