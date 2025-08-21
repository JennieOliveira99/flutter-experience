import 'package:cinebox/ui/core/themes/resources.dart';
import 'package:cinebox/ui/core/widgets/loader_messages.dart';
import 'package:cinebox/ui/splash/commands/check_user_logged_command.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: depend_on_referenced_packages

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with LoaderAndMessage {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(checkUserLoggedCommandProvider.notifier).execute();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(checkUserLoggedCommandProvider, (_, next) {
      next.whenOrNull(
        loading: () => showLoader(),
        data: (data) {
          final path = switch (data) {
            true => '/home',
            false => '/login',
            _ => '',
          };

          if (path.isNotEmpty && context.mounted) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              path,
              (route) => false,
            );
          }
        },
        error: (error, stackTrace) {
          if (context.mounted) {
            hideLoader();
            showErrorSnackBar('Erro ao verificar Login');
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/login',
              (route) => false,
            );
          }
        },
      );
    });
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            R.ASSETS_IMAGES_BG_LOGIN_PNG,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            constraints: BoxConstraints.expand(),
            color: Colors.black.withAlpha(120),
          ),
          Center(
            child: Image.asset(R.ASSETS_IMAGES_LOGO_PNG),
          ),
        ],
      ),
    );
  }
}
