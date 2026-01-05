import 'dart:async';
import 'package:books_store/helpers/consts.dart';
import 'package:books_store/helpers/functions_helper.dart';
import 'package:books_store/providers/auth_provider.dart';
import 'package:books_store/widgets/cickables/clickable_text.dart';
import 'package:books_store/widgets/cickables/main_button.dart';
import 'package:books_store/widgets/dialogs/flush_bar.dart';
import 'package:books_store/widgets/inputs/text_field_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthorRegisterScreen extends StatefulWidget {
  const AuthorRegisterScreen({super.key});

  @override
  State<AuthorRegisterScreen> createState() => _AuthorRegisterScreenState();
}

class _AuthorRegisterScreenState extends State<AuthorRegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController(
    text: kDebugMode ? "mohamed_author" : "",
  );

  TextEditingController passwordController = TextEditingController(
    text: kDebugMode ? "12345678" : "",
  );

  TextEditingController nameController = TextEditingController(
    text: kDebugMode ? "Mohammed Author" : "",
  );

  TextEditingController phoneController = TextEditingController(
    text: kDebugMode ? "0926175513" : "",
  );
  TextEditingController addressController = TextEditingController(
    text: kDebugMode ? "Benghzai" : "",
  );
  TextEditingController emailController = TextEditingController(
    text: kDebugMode ? "mohamed.author@gmail.com" : "",
  );

  TextEditingController bioController = TextEditingController(
    text: kDebugMode ? "I am an author." : "",
  );
  TextEditingController countryController = TextEditingController(
    text: kDebugMode ? "Libya" : "",
  );

  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authConsumer, _) {
        return Scaffold(
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
                          Expanded(
                            child: Text(
                              "Create author account to publish Books",
                              style: displayMedium,
                            ),
                          ),
                        ],
                      ),
                    ),

                    TextFieldWidget(
                      label: "Name",
                      controller: nameController,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Name is required";
                        }
                        return null;
                      },
                    ),

                    TextFieldWidget(
                      label: "Email",
                      controller: emailController,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Email is required";
                        }
                        return null;
                      },
                    ),

                    TextFieldWidget(
                      label: "Phone",
                      controller: phoneController,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Phone is required";
                        }
                        return null;
                      },
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
                      label: "Address",
                      controller: addressController,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Address is required";
                        }
                        return null;
                      },
                    ),

                    TextFieldWidget(
                      label: "Country",
                      controller: countryController,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Country is required";
                        }
                        return null;
                      },
                    ),

                    TextFieldWidget(
                      label: "Bio",
                      controller: bioController,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Bio is required";
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
                        Text("Already have account?"),
                        ClickableText(
                          text: "Login",
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 50),

                    MainButton(
                      busy: authConsumer.busy,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          authConsumer
                              .registerAuthor({
                                "name": nameController.text,
                                "username": usernameController.text,
                                "password": passwordController.text,
                                "phone_number": phoneController.text,
                                "address": addressController.text,
                                "email": emailController.text,
                                "bio": bioController.text,
                                "country": countryController.text,
                              })
                              .then((signUp) {
                                if (context.mounted) {
                                  showCustomFlushBar(
                                    context,
                                    signUp.first ? "Success" : "Failed",
                                    signUp.last,
                                    signUp.first,
                                  );
                                }

                                if (signUp.first) {
                                  Timer(Duration(seconds: 3), () {
                                    Navigator.pop(context);
                                  });
                                }
                              });
                        }
                      },
                      title: "Create Author Account",
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
