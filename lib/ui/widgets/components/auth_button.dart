import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  const AuthButton(
      {Key? key, required this.label, required this.icon, required this.onTap})
      : super(key: key);

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 200,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: ListTile(
              trailing: Icon(
                icon,
                color: Colors.white,
              ),
              title: Text(
                label,
                style: Theme.of(context)
                    .textTheme
                    .button!
                    .copyWith(letterSpacing: 1.2, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
