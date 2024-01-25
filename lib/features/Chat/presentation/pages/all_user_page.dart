import 'package:flutter/material.dart';

import '../../../../Core/Widgets/check_internet.dart';
import '../../../../Core/Widgets/custom_texts.dart';
import '../widgets/body_all_users_page.dart';

class AllUsersPage extends StatelessWidget {
  const AllUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChechInternetWidget(
      child: Scaffold(
        appBar: AppBar(
          title: const CustomTexts(text: 'All Users'),
        ),
        body: const BodyAllUsersPage(),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () async {
        //     await _sendMesage();
        //   },
        //   tooltip: 'Increment',
        //   child: const Icon(Icons.add),
        // ),
      ),
    );
  }
}

// Future _sendMesage() async {
//   try {
//     await http.post(
//       Uri.parse('https://fcm.googleapis.com/fcm/send'),
//       headers: <String, String>{
//         'Content-Type': 'application/json',
//         'Authorization':
//             'key=AAAAzqBg1ZM:APA91bFmFhNr3ocuTLzIeB2Wux2zpX2Bpg8F_NRp6mOmKorlI6VPUHTSXJo6rROKXxj2OQUwy8DeqtHDOjJl6KZtz3gK_gHw4kajiFwe4fylSUc5jvSGge0CpeJuFDpCKlTWHRqgy60p',
//       },
//       body: jsonEncode(<String, dynamic>{
//         "to":
//             'ci0QlCCCR5usvrUQ1FEyw-:APA91bHBlrf9NGNQ2ajCqiQQe-5kuhWOMhB-89OgVXCqLcoodpHRg859SeK4oAFYFTtXHC-CnRXsyB4i1_skD9ciq3vMZfdEhCIzheCBGN3GTztWydZnzQHZcK5R1prs_2LkhHqEGNmz',
//         'priority': 'high',
//         'notification': <String, dynamic>{
//           'body': 'السلام عليكم ورحمه الله',
//           'title': 'New Message !',
//         },
//       }),
//     );
//   } catch (e) {
//     if (kDebugMode) {
//       log(e.toString());
//     }
//   }
// }
