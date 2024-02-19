import 'package:cflytics/utils/colors.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController userID = TextEditingController(),
      apiKEY = TextEditingController(),
      apiSECRET = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Your handle:",
            style: TextStyle(
              fontSize: 18
            ),
          ),
          TextField(
            controller: userID,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'tourist',
            ),
            onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
          ),
          const SizedBox(height: 10,),

          const Text(
            "API KEY:",
            style: TextStyle(
                fontSize: 18
            ),
          ),
          TextField(
            controller: userID,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: '0x0000000000000000',
            ),
            onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
          ),
          const SizedBox(height: 10,),

          const Text(
            "API SECRET:",
            style: TextStyle(
                fontSize: 18
            ),
          ),
          TextField(
            controller: userID,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: '0x0000000000000000',
            ),
            onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
          ),
          const SizedBox(height: 10,),

          Center(
            child: TextButton(
              onPressed: () {  },

              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(AppColor.primary),
                foregroundColor: MaterialStatePropertyAll(AppColor.secondary),
              ),
              child: const Text("Save"),
            ),
          )
        ],
      ),
    );
  }
}
