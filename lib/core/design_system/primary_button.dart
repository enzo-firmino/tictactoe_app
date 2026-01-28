import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictactoe_app/core/design_system/colors.dart';

class PrimaryButton extends StatefulWidget {
  final IconData icon;
  final IconData? secondIcon;
  final String text;
  final VoidCallback onPressed;

  const PrimaryButton({super.key, required this.icon, this.secondIcon, required this.text, required this.onPressed});

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTapDown: (_) {
          setState(() {
            _isPressed = true;
          });
        },
        onTapUp: (_) {
          setState(() {
            _isPressed = false;
          });
          widget.onPressed();
        },
        onTapCancel: () {
          setState(() {
            _isPressed = false;
          });
        },
        child: AnimatedScale(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeInOut,
          scale: _isPressed ? 0.9 : 1.0,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
              boxShadow: _isPressed
                  ? null
                  : <BoxShadow>[
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.5),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FaIcon(widget.icon, color: Colors.white),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      widget.text,
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                  if (widget.secondIcon != null) FaIcon(widget.secondIcon!, color: Colors.white),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
