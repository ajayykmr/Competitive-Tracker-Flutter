import 'package:cflytics/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/constants.dart';

const storage = FlutterSecureStorage();

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: storage.readAll(),
      builder: (context, snapshot) {
        String? handle = snapshot.data?[Constants.handleKey];
        String? apiKey = snapshot.data?[Constants.apiKeyKey];
        String? apiSecret = snapshot.data?[Constants.apiSecretKey];

        return SettingsWidget(
            handle: handle, apiKey: apiKey, apiSecret: apiSecret);
      },
    );
  }
}

class SettingsWidget extends StatefulWidget {
  final String? handle;
  final String? apiKey;
  final String? apiSecret;

  const SettingsWidget({
    this.handle,
    this.apiKey,
    this.apiSecret,
    super.key,
  });

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  @override
  Widget build(BuildContext context) {
    TextEditingController handleController =
            TextEditingController(text: widget.handle),
        apiKeyController = TextEditingController(text: widget.apiKey),
        apiSecretController = TextEditingController(text: widget.apiSecret);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Your handle:",
            style: TextStyle(fontSize: 18),
          ),
          TextField(
            controller: handleController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Please enter your handle',
            ),
            onTapOutside: (event) =>
                FocusManager.instance.primaryFocus?.unfocus(),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "API KEY:",
            style: TextStyle(fontSize: 18),
          ),
          PasswordTextField(hintText: "Please enter your API Key", controller: apiKeyController),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "API SECRET:",
            style: TextStyle(fontSize: 18),
          ),
          PasswordTextField(
              hintText: "Please Enter your API Secret",
              controller: apiSecretController),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: TextButton(
              onPressed: () {
                saveSettings(handleController.text, apiKeyController.text,
                    apiSecretController.text);
              },
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(AppColor.primary),
                foregroundColor: MaterialStatePropertyAll(AppColor.secondary),
              ),
              child: const Text(
                "Save",
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              final uri = Uri.parse("https://codeforces.com/settings/api");
              launchUrl(uri, mode: LaunchMode.inAppBrowserView);
            },
            child: const Center(
              child: Text(
                "Generate API keys",
                style: TextStyle(
                  color: AppColor.primary,
                  fontSize: 16,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void saveSettings(String? handle, String? apiKey, String? apiSecret) async {
    await storage.write(key: Constants.handleKey, value: handle);
    await storage.write(key: Constants.apiKeyKey, value: apiKey);
    await storage.write(key: Constants.apiSecretKey, value: apiSecret);

    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Done")));
    }
  }
}

class PasswordTextField extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  const PasswordTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.obscureText = true,
  }) : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(

        enableSuggestions: false,
        autocorrect: false,
        controller: widget.controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: widget.hintText,
          suffixIcon: IconButton(
            icon: Icon(
              _isObscure ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            },
          ),
        ),
        obscureText: _isObscure,
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus());
  }
}
