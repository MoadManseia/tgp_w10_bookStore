import 'dart:async';
import 'package:books_store/helpers/consts.dart';
import 'package:books_store/helpers/functions_helper.dart';
import 'package:books_store/main.dart';
import 'package:books_store/providers/auth_provider.dart';
import 'package:books_store/screens/auth_screens/author_register_screen.dart'; // Create this next
import 'package:books_store/widgets/cickables/clickable_text.dart';
import 'package:books_store/widgets/cickables/main_button.dart';
import 'package:books_store/widgets/dialogs/flush_bar.dart';
import 'package:books_store/widgets/inputs/text_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthorLoginScreen extends StatefulWidget {
  const AuthorLoginScreen({super.key});

  @override
  State<AuthorLoginScreen> createState() => _AuthorLoginScreenState();
}

class _AuthorLoginScreenState extends State<AuthorLoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController(
    text: kDebugMode ? "mohamed_author" : "",
  );
  TextEditingController passwordController = TextEditingController(
    text: kDebugMode ? "12345678" : "",
  );

  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authConsumer, _) {
        return Scaffold(
          appBar: AppBar(title: Text("Author Login")),
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: getSize(context).height * 0.1),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      child: Row(
                        children: [
                          Text("Login as Author", style: displayMedium),
                        ],
                      ),
                    ),

                    TextFieldWidget(
                      label: "Username",
                      controller: usernameController,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "username is required";
                        }
                        return null;
                      },
                    ),

                    TextFieldWidget(
                      obscureText: hidePassword,
                      suffixWidget: GestureDetector(
                        onTap: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        child: Icon(
                          Icons.remove_red_eye,
                          color: primaryColor,
                          size: 22,
                        ),
                      ),
                      label: "Password",
                      controller: passwordController,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "password is required!";
                        }
                        if (v.length < 8) {
                          return "password must be 8 chars least!";
                        }
                        return null;
                      },
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have author account?"),
                        ClickableText(
                          text: "Create Author Account",
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => AuthorRegisterScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: MainButton(
            busy: authConsumer.busy,
            onTap: () {
              if (formKey.currentState!.validate()) {
                authConsumer
                    .login({
                      "username": usernameController.text,
                      "password": passwordController.text,
                    })
                    .then((loginResponse) {
                      if (context.mounted) {
                        showCustomFlushBar(
                          context,
                          loginResponse.first ? "Success" : "Failed",
                          loginResponse.last,
                          loginResponse.first,
                        );
                      }
                      if (loginResponse.first) {
                        Timer(Duration(seconds: 3), () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => ScreenRouter(),
                            ),
                            (route) => false,
                          );
                        });
                      }
                    });
              }
            },
            title: "Login",
          ),
        );
      },
    );
  }
}
