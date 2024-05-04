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
    final textStyle = Theme.of(context).textTheme;
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
                Text(
                  "Your handle:",
                  style: textStyle.bodyMedium,
                ),
                TextField(
                  controller: handleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    hintText: 'Please enter your handle',
                  ),
                  onTapOutside: (event) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "API KEY:",
                  style: textStyle.bodyMedium,
                ),
                PasswordTextField(
                    hintText: "Please enter your API Key",
                    controller: apiKeyController),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "API SECRET:",
                  style: textStyle.bodyMedium,
                ),
                PasswordTextField(
                    hintText: "Please Enter your API Secret",
                    controller: apiSecretController),
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      //save settings
                      ref.read(SecureStorageWriteProvider(handleController.text,
                          apiKeyController.text, apiSecretController.text));
                    },
                    child: Text(
                      "Save",
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                InkWell(
                  onTap: () {
                    final uri =
                        Uri.parse("https://codeforces.com/settings/api");
                    launchUrl(uri, mode: LaunchMode.inAppBrowserView);
                  },
                  child: Center(
                    child: Text(
                      "Generate API keys",
                      style: textStyle.bodyMedium?.copyWith(
                        color: AppColor.hyperlink,
                        decoration: TextDecoration.underline,
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
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
