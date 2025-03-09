import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';

class RegisterOptionWidget extends StatelessWidget {
  const RegisterOptionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 16,
          ),
          children: [
            TextSpan(text: '${l10n.dontHaveAccount} '),
            WidgetSpan(
              child: GestureDetector(
                onTap: () {
                  // Navigate to registration page
                },
                child: Text(
                  l10n.registerHere,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
