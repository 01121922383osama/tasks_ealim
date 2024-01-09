import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Gettoken {
  static Future<String> getToken() async {
    String userDoc = FirebaseAuth.instance.currentUser!.uid;
    final userToken =
        await FirebaseFirestore.instance.collection('Users').doc(userDoc).get();
    final receiverToken = await userToken.data()!['token'];
    return receiverToken;
  }
}
