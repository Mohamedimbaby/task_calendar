import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../cubits/login/login_cubit.dart';
import 'social_login_button_widget.dart';

class SocialLoginsWidget extends StatelessWidget {
  const SocialLoginsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        Center(
          child: Text(
            l10n.orLoginWithAccount,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Google Login
        SocialLoginButtonWidget(
          icon: 'assets/images/google_icon.svg',
          text: l10n.continueWithGoogle,
          onPressed: () => context.read<LoginCubit>().loginWithGoogle(),
        ),
        const SizedBox(height: 16),

        // Facebook Login
        SocialLoginButtonWidget(
          icon: 'assets/images/facebook_icon.svg',
          text: l10n.continueWithFacebook,
          onPressed: () => context.read<LoginCubit>().loginWithFacebook(),
        ),
        const SizedBox(height: 16),

        // Apple Login
        SocialLoginButtonWidget(
          icon: 'assets/images/apple_icon.svg',
          text: l10n.continueWithApple,
          onPressed: () => context.read<LoginCubit>().loginWithApple(),
        ),
      ],
    );
  }
}
