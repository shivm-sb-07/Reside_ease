import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Future<List<String>> getChatHistory(String userId) async {
  //   print('Fetching message documents for user ID: $userId');
  //   QuerySnapshot querySnapshot = await _firestore.collection('messages')
  //       .where('senderId', isEqualTo: userId)
  //       .get();
  //   print('Fetched message documents: ${querySnapshot.docs.length}');
  //   for (var doc in querySnapshot.docs) {
  //     print('Document data: ${doc.data()}');
  //   }

  //   List<String> chatHistory = [];
  //   for (var doc in querySnapshot.docs) {
  //     // The 'receiverId' field contains the other user's name
  //     String otherUserName = doc['receiverId'];

  //     // Fetch the user document from Firestore where the 'name' field is equal to the other user's name
  //     QuerySnapshot userQuerySnapshot = await _firestore.collection('users')
  //         .where('name', isEqualTo: otherUserName)
  //         .get();

  //     // Check if a user document was found
  //     if (userQuerySnapshot.docs.isNotEmpty) {
  //       // Add the other user's name to the chat history
  //       chatHistory.add(otherUserName);
  //       chatHistory = chatHistory.toSet().toList();
  //     } else {
  //       print('User document does not exist for user name: $otherUserName');
  //     }
  //   }

  //   return chatHistory;
  // }
  // above code works



  // experimental code below
  Future<List<String>> getChatHistory(String userId) async {
    print('Fetching message documents for user ID: $userId');
    QuerySnapshot querySnapshot = await _firestore.collection('messages')
        .where('senderId', isEqualTo: userId)
        .get();
    print('Fetched message documents: ${querySnapshot.docs.length}');
    for (var doc in querySnapshot.docs) {
      print('Document data: ${doc.data()}');
    }

    List<String> chatHistory = [];
    for (var doc in querySnapshot.docs) {
      // The 'receiverId' field contains the other user's name
      String otherUserName = doc['receiverId'];

      // Fetch the user document from Firestore where the 'name' field is equal to the other user's name
      QuerySnapshot userQuerySnapshot = await _firestore.collection('users')
          .where('name', isEqualTo: otherUserName)
          .get();

      // Check if a user document was found
      if (userQuerySnapshot.docs.isNotEmpty) {
        // Add the other user's name to the chat history
        chatHistory.add(otherUserName);
        chatHistory = chatHistory.toSet().toList();
      } else {
        print('User document does not exist for user name: $otherUserName');
      }
    }

    return chatHistory;
  }
}