import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:next_starter/presentation/components/components.dart';
import 'package:next_starter/utils/constant.dart';

import '../../common/extensions/extensions.dart';
import '../../injection.dart';
import '../routes/app_router.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await 1.delayedSeconds;
    if (supabase.auth.currentUser != null) {
      locator<AppRouter>().replace(const HomeRoute());
    } else {
      locator<AppRouter>().replace(LoginRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: BaseLogo(),
      ),
    );
  }
}
