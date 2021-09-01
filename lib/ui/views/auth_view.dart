import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:journalio/data/view_models/login_view_model.dart';
import 'package:journalio/data/view_models/register_view_model.dart';
import 'package:journalio/ui/views/login_view.dart';
import 'package:journalio/ui/views/register_view.dart';
import 'package:journalio/ui/widgets/components/auth_button.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class AuthView extends StatefulWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  _AuthViewState createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  @override
  Widget build(BuildContext context) {
    final login = Provider.of<LoginViewModel>(context, listen: true);
    final registration = Provider.of<RegisterViewModel>(context, listen: true);
    return Scaffold(
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 120.0),
              child: SvgPicture.asset('assets/splash_graphics.svg'),
            ),
            AuthButton(
              label: AppLocalizations.of(context)!.signIn,
              icon: FontAwesomeIcons.signInAlt,
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  PageTransition(
                      child: LoginView(), type: PageTransitionType.fade),
                ).then((value) => login.clearTextEditingControllers());
              },
            ),
            AuthButton(
              label: AppLocalizations.of(context)!.registration,
              icon: FontAwesomeIcons.idCardAlt,
              onTap: () {
                Navigator.pushReplacement(
                        context,
                        PageTransition(
                            child: RegisterView(),
                            type: PageTransitionType.fade))
                    .then(
                        (value) => registration.clearTextEditingControllers());
              },
            ),
          ],
        ),
      ),
    );
  }
}
