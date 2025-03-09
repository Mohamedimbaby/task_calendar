import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../cubits/login/login_cubit.dart';
import '../cubits/login/login_state.dart';
import '../widgets/login/header_widget.dart';
import '../widgets/login/login_form_widget.dart';
import '../widgets/login/social_logins_widget.dart';
import '../widgets/login/register_option_widget.dart';
import '../../core/theme/app_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status == LoginStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? l10n.loginFailed)),
            );
          } else if (state.status == LoginStatus.success) {
            // Handle successful login (navigation, etc.)
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  const HeaderWidget(),
                  const SizedBox(height: 40),
                  LoginFormWidget(
                    usernameController: _usernameController,
                    passwordController: _passwordController,
                    state: state,
                  ),
                  const SizedBox(height: 40),
                  const SocialLoginsWidget(),
                  const SizedBox(height: 24),
                  const RegisterOptionWidget(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
