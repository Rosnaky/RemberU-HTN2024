import "package:app/firebase/auth.dart";
import "package:app/pages/home_page.dart";
import "package:app/pages/login_page.dart";
import "package:app/pages/splash_page.dart";
import "package:app/provider/user_provider.dart";
import "package:app/utils/theme.dart";
import "package:app/widgets/text_field_input.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  static const routeName = "/register";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with TickerProviderStateMixin {
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  final TextEditingController firstNameTextEditingController =
      TextEditingController();
  final TextEditingController lastNameTextEditingController =
      TextEditingController();
  final TextEditingController confirmPasswordTextEditingController =
      TextEditingController();
  final TextEditingController displayNameEditingController =
      TextEditingController();

  late AnimationController progressController;

  bool _isLoading = false;
  int _step = 0;

  @override
  void initState() {
    super.initState();

    progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    progressController.repeat();
  }

  @override
  void dispose() {
    progressController.dispose();
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    confirmPasswordTextEditingController.dispose();
    firstNameTextEditingController.dispose();
    lastNameTextEditingController.dispose();
    displayNameEditingController.dispose();
    _step = 0;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) =>
                Navigator.pushNamedAndRemoveUntil(
                    context, HomePage.routeName, (route) => false));
          }
          return Scaffold(
            appBar: AppBar(),
            body: LayoutBuilder(builder: (context, constraints) {
              return SingleChildScrollView(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                      'assets/images/logo-slogan.png',
                      width: constraints.maxWidth * 0.95,
                      height: constraints.maxHeight * 0.22,
                      fit: BoxFit.contain,
                    ),
                  SizedBox(height: constraints.maxHeight * 0.02),
                  registerWidget(constraints),
                  
                  _step == 0
                      ? Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            width: constraints.maxWidth * 0.8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(255, 205, 230, 238),
                                ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10.0, 10, 10, 0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text("Already have an account?",
                                        style: theme.textTheme.displaySmall
                                            ?.copyWith(fontSize: 16)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12.0, 12, 12, 0),
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                                        backgroundColor: const Color.fromARGB(255, 109, 198, 225),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, LoginPage.routeName);
                                      },
                                      child: const SizedBox(
                                          width: 80,
                                          height: 30,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text("Login",
                                                style: const TextStyle(
                                                fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                  ),
                                  SizedBox(
                                      height: constraints.maxHeight * 0.03),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ));
            }),
          );
        });
  }

  Container registerWidget(BoxConstraints constraints) {
    switch (_step) {
      case 0:
        return registerEmailAndPassword(constraints);
      case 1:
        return registerName(constraints);
      default:
        return registerEmailAndPassword(constraints);
    }
  }

  Container registerEmailAndPassword(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 205, 230, 238),
        ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: SizedBox(
                width: constraints.maxWidth * 0.7,
                child: Column(
                  children: [
                    TextFieldInput(
                        textEditingController: emailTextEditingController,
                        hintText: "Email",
                        textInputType: TextInputType.emailAddress),
                    SizedBox(height: constraints.maxHeight * 0.02),
                    TextFieldInput(
                        textEditingController: passwordTextEditingController,
                        hintText: "Password",
                        isPassword: true,
                        textInputType: TextInputType.visiblePassword),
                    SizedBox(height: constraints.maxHeight * 0.02),
                    TextFieldInput(
                        textEditingController:
                            confirmPasswordTextEditingController,
                        hintText: "Confirm Password",
                        isPassword: true,
                        textInputType: TextInputType.visiblePassword),
                    SizedBox(height: constraints.maxHeight * 0.03),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                        backgroundColor: const Color.fromARGB(255, 109, 198, 225),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        if (passwordTextEditingController.text !=
                            confirmPasswordTextEditingController.text) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Passwords do not match"),
                              duration: Duration(seconds: 3),
                            ),
                          );
                          return;
                        }
                        setState(() {
                          _step = 1;
                        });
                      },
                      child: const SizedBox(
                          width: 80,
                          height: 30,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Next",
                                style: const TextStyle(
                                fontSize: 16,
                                ),
                              ),
                            ],
                          )),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.03),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container registerName(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: theme.colorScheme.primary),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: SizedBox(
                width: constraints.maxWidth * 0.7,
                child: Column(
                  children: [
                    TextFieldInput(
                        textEditingController: firstNameTextEditingController,
                        hintText: "First Name",
                        textInputType: TextInputType.emailAddress),
                    SizedBox(height: constraints.maxHeight * 0.02),
                    TextFieldInput(
                        textEditingController: lastNameTextEditingController,
                        hintText: "Last Name",
                        textInputType: TextInputType.visiblePassword),
                    SizedBox(height: constraints.maxHeight * 0.02),
                    TextFieldInput(
                        textEditingController: displayNameEditingController,
                        hintText: "Display Name",
                        textInputType: TextInputType.visiblePassword),
                    SizedBox(height: constraints.maxHeight * 0.02),
                    _isLoading
                        ? LinearProgressIndicator(
                            value: progressController.value)
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor:
                                        Theme.of(context).colorScheme.primary,
                                    backgroundColor:
                                        Theme.of(context).colorScheme.onPrimary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _step = 0;
                                    });
                                  },
                                  child: const SizedBox(
                                      width: 80,
                                      height: 30,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("Previous"),
                                        ],
                                      )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor:
                                        Theme.of(context).colorScheme.primary,
                                    backgroundColor:
                                        Theme.of(context).colorScheme.onPrimary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {
                                    // Register user
                                    register();
                                  },
                                  child: const SizedBox(
                                      width: 80,
                                      height: 30,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("Submit"),
                                        ],
                                      )),
                                ),
                              ),
                            ],
                          ),
                    SizedBox(height: constraints.maxHeight * 0.02),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  register() async {
    setState(() {
      _isLoading = true;
    });

    await Auth().register(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text,
        firstName: firstNameTextEditingController.text,
        lastName: lastNameTextEditingController.text,
        displayName: displayNameEditingController.text,
        friends: []).then((value) async {
      setState(() {
        _isLoading = false;
      });
      if (value == "Success") {
        await Provider.of<UserProvider>(context, listen: false).refreshUser();
        WidgetsBinding.instance.addPostFrameCallback(
            (_) => Navigator.pushNamed(context, SplashPage.routeName));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(value),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    });
  }
}
