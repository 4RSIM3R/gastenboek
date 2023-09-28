import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:next_starter/presentation/components/components.dart';

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
    // final user = await locator<SessionSource>().hasSession;
    // if (user) {
    //   locator<AppRouter>().replace(const HomeRoute());
    //   return;
    // }
    // locator<AppRouter>().replace(LoginRoute());
    locator<AppRouter>().replace(const HomeRoute());
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
