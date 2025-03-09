import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task_1/core/di/di.dart';
import 'package:task_1/presentation/cubits/calendar/calendar_cubit.dart';
import 'package:task_1/presentation/cubits/events/events_cubit.dart';
import 'package:task_1/presentation/pages/calendar_page.dart';
import '../../../core/theme/app_colors.dart';
import '../../cubits/login/login_cubit.dart';
import '../../cubits/login/login_state.dart';

class LoginFormWidget extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final LoginState state;

  const LoginFormWidget({
    super.key,
    required this.usernameController,
    required this.passwordController,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final loginCubit = context.read<LoginCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Username/Email Field
        Text(
          l10n.usernameEmail,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: usernameController,
          onChanged: (value) => loginCubit.usernameChanged(value),
          decoration: InputDecoration(
              hintText: l10n.enterUsernameOrEmail,
              filled: true,
              fillColor: AppColors.inputBackground,
              enabledBorder: UnderlineInputBorder(
                borderSide: const BorderSide(color: AppColors.neutral200),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: const BorderSide(color: AppColors.black),
              )),
        ),
        const SizedBox(height: 24),

        // Password Field
        Text(
          l10n.password,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: passwordController,
          onChanged: (value) => loginCubit.passwordChanged(value),
          obscureText: !state.isPasswordVisible,
          decoration: InputDecoration(
            hintText: l10n.enterPassword,
            filled: true,
            fillColor: AppColors.inputBackground,
            enabledBorder: UnderlineInputBorder(
              borderSide: const BorderSide(color: AppColors.neutral200),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: const BorderSide(color: AppColors.black),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                state.isPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: () {
                context.read<LoginCubit>().togglePasswordVisibility();
              },
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Forgot Password
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              // Navigate to forgot password screen
            },
            child: Text(
              l10n.forgotPassword,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Login Button
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed:
                (state.status == LoginStatus.loading || !state.isFormValid)
                    ? null
                    : () {
                        Navigator.push(context, MaterialPageRoute(builder: (c)=> MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (_) => getIt<CalendarCubit>(),
                              ),
                              BlocProvider(
                                create: (_) => getIt<EventsCubit>(),
                              ),
                            ],
                            child: CalendarPage())));
                      },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryDark,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              disabledBackgroundColor: AppColors.neutral300,
            ),
            child: state.status == LoginStatus.loading
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(
                    l10n.login,
                    style:  TextStyle(
                        fontSize: 16,
                        color: (state.status == LoginStatus.loading || !state.isFormValid)? Colors.white : Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
          ),
        ),
      ],
    );
  }
}
