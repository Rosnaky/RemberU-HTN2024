import "package:app/firebase/auth.dart";
import "package:app/pages/home_page.dart";
import "package:app/pages/register_page.dart";
import "package:app/provider/user_provider.dart";
import "package:app/utils/theme.dart";
import "package:app/widgets/text_field_input.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const routeName = "/login";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  bool _isLoading = false;

  late AnimationController progressController;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    progressController.dispose();
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    super.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });

    await Auth()
        .login(
            email: emailTextEditingController.text,
            password: passwordTextEditingController.text)
        .then((value) async {
      if (value == "Success") {
        await Provider.of<UserProvider>(context, listen: false).refreshUser();
        WidgetsBinding.instance.addPostFrameCallback((_) =>
            Navigator.pushNamedAndRemoveUntil(
                context, HomePage.routeName, (route) => false));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(value),
        ));
      }
    });

    setState(() {
      _isLoading = false;
    });
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
          return loginPage();
        });
  }

  Scaffold loginPage() {
    return Scaffold(
      appBar: AppBar(),
      body: LayoutBuilder(builder: (context, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
                      'assets/images/logo-slogan.png',
                      width: constraints.maxWidth * 0.95,
                      height: constraints.maxHeight * 0.22,
                      fit: BoxFit.contain,
                    ),
            SizedBox(height: constraints.maxHeight * 0.02),
            loginCredentials(constraints),
            SizedBox(height: constraints.maxHeight * 0.02),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: constraints.maxWidth * 0.8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 205, 230, 238),
                    ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 10, 10, 0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text("Don't have an account?",
                            style: theme.textTheme.displaySmall
                                ?.copyWith(fontSize: 16)),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 12, 12, 0),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor:
                                const Color.fromARGB(255, 255, 255, 255),
                            backgroundColor:
                                const Color.fromARGB(255, 109, 198, 225),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RegisterPage.routeName);
                          },
                          child: const SizedBox(
                              width: 80,
                              height: 30,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Register",
                                    style: const TextStyle(
                                    fontSize: 16,
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight * 0.03),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Container loginCredentials(BoxConstraints constraints) {
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
                    SizedBox(height: constraints.maxHeight * 0.03),
                    _isLoading
                        ? LinearProgressIndicator(
                            value: progressController.value)
                        : TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: 
                                  const Color.fromARGB(255, 255, 255, 255),
                              backgroundColor:
                                  const Color.fromARGB(255, 109, 198, 225),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () => loginUser(),
                            child: const SizedBox(
                                width: 80,
                                height: 30,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Login",
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
}
