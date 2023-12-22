import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:next_starter/common/extensions/extensions.dart';
import 'package:next_starter/presentation/layouts/home/history/home_history_layout.dart';
import 'package:next_starter/presentation/layouts/home/main/home_main_layout.dart';
import 'package:next_starter/presentation/layouts/home/setting/home_setting_layout.dart';
import 'package:next_starter/presentation/routes/app_router.dart';
import 'package:next_starter/presentation/theme/app_assets.dart';
import 'package:next_starter/presentation/theme/theme.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Widget> body = [
    const HomeMainLayout(),
    const HomeHistoryLayout(),
    const HomeSettingLayout(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Gastenboek',
          style: AppStyles.text18PxSemiBold,
        ),
      ),
      body: body[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        unselectedItemColor: ColorTheme.textGrey,
        currentIndex: _currentIndex,
        onTap: (val) {
          setState(() => _currentIndex = val);
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.clock), label: 'History'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.settings), label: 'Setting'),
        ],
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(24, 48, 24, 0),
          alignment: Alignment.center,
          height: 80,
          child: Text(
            "Let's verify your identity",
            style: AppStyles.text24PxBold,
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(24, 0, 24, 48),
          alignment: Alignment.center,
          child: Text(
            'We are provide some ways to verify your identity. Your information will be encrypted and stored securely',
            style: AppStyles.text14PxMedium,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 24),
        const ScanMenu(
          image: AppAssets.id_card,
          title: 'OCR Check',
        ),
        const SizedBox(height: 24),
        const ScanMenu(
          image: AppAssets.face_id,
          title: 'Liveness Check',
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class ScanMenu extends StatelessWidget {
  const ScanMenu({
    super.key,
    required this.image,
    required this.title,
  });
  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.route.push(const ScanRoute());
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(24, 0, 24, 0),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: ColorTheme.primary2.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: ColorTheme.primary2,
            width: 2,
          ),
        ),
        child: Row(children: [
          Image.asset(image, height: 57),
          const SizedBox(width: 24),
          Expanded(
            child: Text(
              title,
              style: AppStyles.text12PxBold,
            ),
          ),
          const ImageIcon(
            AssetImage(AppAssets.arrow_right),
            size: 24,
          )
        ]),
      ),
    );
  }
}
