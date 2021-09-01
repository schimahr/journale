import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journalio/data/view_models/login_view_model.dart';
import 'package:journalio/ui/widgets/auth_widget.dart';
import 'package:journalio/ui/widgets/components/auth_button.dart';
import 'package:journalio/ui/widgets/components/auth_loading.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(builder: (context, viewModel, child) {
      return viewModel.isLoggingIn
          ? WillPopScope(
              onWillPop: () async => false,
              child: AuthLoading(),
            )
          : WillPopScope(
              onWillPop: () async {
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: AuthWidget(), type: PageTransitionType.fade));
                return true;
              },
              child: Scaffold(
                body: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0xFF6A8448),
                      Color(0xFF55693A),
                      Color(0xFF404F2B),
                      Color(0xFF364224)
                    ], stops: [
                      0.2,
                      0.4,
                      0.6,
                      0.8
                    ], begin: Alignment.bottomLeft, end: Alignment.topRight),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AppLocalizations.of(context)!.signInTitle,
                          style: TextStyle(
                              fontFamily: GoogleFonts.pacifico().fontFamily,
                              color: Colors.white,
                              fontSize: 30),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          controller: viewModel.emailController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: Colors.black45, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide:
                                  BorderSide(color: Colors.black45, width: 3.0),
                            ),
                            labelText: AppLocalizations.of(context)!.email,
                            prefixIcon: Icon(
                              FontAwesomeIcons.solidEnvelope,
                              color: Colors.white70,
                            ),
                            labelStyle: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold),
                            hintStyle: TextStyle(
                                color: Colors.white10,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          obscureText: viewModel.isObscure,
                          style: TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          controller: viewModel.passwordController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: Colors.black45, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide:
                                  BorderSide(color: Colors.black45, width: 3.0),
                            ),
                            labelText: AppLocalizations.of(context)!.password,
                            suffixIcon: IconButton(
                              icon: Icon(
                                  viewModel.isObscure
                                      ? FontAwesomeIcons.eye
                                      : FontAwesomeIcons.eyeSlash,
                                  color: Colors.white70),
                              onPressed: () {
                                viewModel.obscurePassword();
                              },
                            ),
                            prefixIcon: Icon(
                              FontAwesomeIcons.lock,
                              color: Colors.white70,
                            ),
                            labelStyle: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold),
                            hintStyle: TextStyle(
                                color: Colors.white10,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      AuthButton(
                        label: AppLocalizations.of(context)!.signIn,
                        icon: FontAwesomeIcons.signInAlt,
                        onTap: () async {
                          if (viewModel.emailController.text.isNotEmpty &&
                              viewModel.passwordController.text.isNotEmpty) {
                            viewModel.loggingIn();
                            bool signedIn = await viewModel.loginUser();
                            if (signedIn) {
                              Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    child: AuthWidget(),
                                    type: PageTransitionType.fade),
                              ).then(
                                (value) => viewModel.loggedIn(),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(AppLocalizations.of(context)!
                                      .signInSuccess),
                                ),
                              );
                            }
                            if (viewModel.incorrectPassword) {
                              viewModel.loggedIn();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(AppLocalizations.of(context)!
                                      .signInErrorPassword),
                                ),
                              );
                            }
                            if (viewModel.userDoesNotExist) {
                              viewModel.loggedIn();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(AppLocalizations.of(context)!
                                      .signInUserNotExists),
                                ),
                              );
                            }
                            if (viewModel.invalidEmail) {
                              viewModel.loggedIn();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(AppLocalizations.of(context)!
                                      .signInInvalidEmail),
                                ),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(AppLocalizations.of(context)!
                                    .signInMissingInputs),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
    });
  }
}
