import 'package:cflytics/providers/secure_storage_provider.dart';
import 'package:cflytics/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/constants.dart';


class SettingsScreen extends ConsumerWidget {

  const SettingsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final secureStorageRead = ref.watch(secureStorageReadProvider);
   
    return secureStorageRead.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
      data: (data) {
        final handle = data[Constants.handleKey] ?? "",
            apiKey = data[Constants.apiKeyKey] ?? "",
            apiSecret = data[Constants.apiSecretKey] ?? "";

        TextEditingController handleController =
        TextEditingController(text: handle),
            apiKeyController = TextEditingController(text: apiKey),
            apiSecretController = TextEditingController(text: apiSecret);

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
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
                      //save settings
                      ref.read(SecureStorageWriteProvider(handleController.text, apiKeyController.text, apiSecretController.text));
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
          ),
        );
      },
    );
  }
}


class PasswordTextField extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  const PasswordTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText = true,
  });

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
          border: const OutlineInputBorder(),
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
