import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journalio/data/view_models/register_view_model.dart';
import 'package:journalio/ui/widgets/components/auth_button.dart';
import 'package:journalio/ui/widgets/auth_widget.dart';
import 'package:journalio/ui/widgets/components/auth_loading.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterViewModel>(builder: (context, viewModel, child) {
      return viewModel.isRegistering
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
                          AppLocalizations.of(context)!.registerTitle,
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
                          controller: viewModel.displayNameController,
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
                            labelText:
                                AppLocalizations.of(context)!.displayName,
                            labelStyle: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold),
                            hintStyle: TextStyle(
                                color: Colors.white10,
                                fontWeight: FontWeight.bold),
                            prefixIcon: Icon(
                              FontAwesomeIcons.userTag,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          controller: viewModel.emailController,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    BorderSide(color: Colors.black45, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                    color: Colors.black45, width: 3.0),
                              ),
                              labelText: AppLocalizations.of(context)!.email,
                              labelStyle: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold),
                              hintStyle: TextStyle(
                                  color: Colors.white10,
                                  fontWeight: FontWeight.bold),
                              prefixIcon: Icon(FontAwesomeIcons.solidEnvelope,
                                  color: Colors.white70)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          controller: viewModel.passwordController,
                          obscureText: viewModel.isObscure,
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
                          ),
                        ),
                      ),
                      AuthButton(
                        label: AppLocalizations.of(context)!.register,
                        icon: FontAwesomeIcons.idCardAlt,
                        onTap: () async {
                          if (viewModel.passwordController.text.isNotEmpty &&
                              viewModel.emailController.text.isNotEmpty &&
                              viewModel.displayNameController.text.isNotEmpty) {
                            viewModel.registering();
                            bool registered = await viewModel.registerUser();
                            if (registered) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(AppLocalizations.of(context)!
                                      .registerSuccess),
                                ),
                              );

                              Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    child: AuthWidget(),
                                    type: PageTransitionType.fade),
                              ).then((value) => viewModel.registered());
                            }
                            if (viewModel.emailAlreadyUsed) {
                              viewModel.registered();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(AppLocalizations.of(context)!
                                      .emailAlreadyUsed),
                                ),
                              );
                            }
                            if (viewModel.weakPassword) {
                              viewModel.registered();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(AppLocalizations.of(context)!
                                      .signUpWeakPassword),
                                ),
                              );
                            }
                            if (viewModel.invalidEmail) {
                              viewModel.registered();
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
                      )
                    ],
                  ),
                ),
              ),
            );
    });
  }
}
