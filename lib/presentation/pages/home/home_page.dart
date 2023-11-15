import 'package:adaptive_sizer/adaptive_sizer.dart';
import 'package:auto_route/annotations.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:next_starter/common/extensions/extensions.dart';
import 'package:next_starter/presentation/routes/app_router.dart';
import 'package:next_starter/presentation/theme/app_assets.dart';
import 'package:next_starter/presentation/theme/theme.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Widget> body = [
    MainPage(),
    Container(
      child: Center(
        child: Text('History'),
      ),
    ),
    Container(
      child: Center(
        child: Text('Setting'),
      ),
    ),
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
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        color: ColorTheme.primary2,
        animationDuration: Duration(milliseconds: 300),
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: [
          ImageIcon(
            AssetImage(AppAssets.icon_home),
            color: Colors.white,
          ),
          ImageIcon(
            AssetImage(AppAssets.icon_history),
            color: Colors.white,
          ),
          ImageIcon(
            AssetImage(AppAssets.icon_setting),
            color: Colors.white,
          ),
        ],
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(16),
      //   child: Column(
      //     children: [
      //       Row(
      //         children: [
      //           Expanded(
      //             child: InkWell(
      //               onTap: () {
      //                 context.route.push(const ScanRoute());
      //               },
      //               child: Container(
      //                 width: double.infinity,
      //                 padding: const EdgeInsets.all(16),
      //                 decoration: BoxDecoration(
      //                   color: Colors.blueAccent,
      //                   borderRadius: BorderRadius.circular(5),
      //                 ),
      //                 child: const Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Icon(Icons.book, color: Colors.white),
      //                     SizedBox(height: 32),
      //                     Text(
      //                       'Buku Tamu',
      //                       style: TextStyle(
      //                           color: Colors.white,
      //                           fontSize: 16,
      //                           fontWeight: FontWeight.w500),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           ),
      //           12.horizontalSpace,
      //           Expanded(
      //             child: Container(
      //               width: double.infinity,
      //               padding: const EdgeInsets.all(16),
      //               decoration: BoxDecoration(
      //                 color: Colors.blueAccent,
      //                 borderRadius: BorderRadius.circular(5),
      //               ),
      //               child: const Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Icon(Icons.schedule, color: Colors.white),
      //                   SizedBox(height: 32),
      //                   Text(
      //                     'Informasi Jadwal',
      //                     style: TextStyle(
      //                         color: Colors.white,
      //                         fontSize: 16,
      //                         fontWeight: FontWeight.w500),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //       12.verticalSpace,
      //       Row(
      //         children: [
      //           Expanded(
      //             child: Container(
      //               width: double.infinity,
      //               padding: const EdgeInsets.all(16),
      //               decoration: BoxDecoration(
      //                 color: Colors.blueAccent,
      //                 borderRadius: BorderRadius.circular(5),
      //               ),
      //               child: const Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Icon(Icons.info_outline, color: Colors.white),
      //                   SizedBox(height: 32),
      //                   Text(
      //                     'Tentang',
      //                     style: TextStyle(
      //                         color: Colors.white,
      //                         fontSize: 16,
      //                         fontWeight: FontWeight.w500),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ),
      //           12.horizontalSpace,
      //           Expanded(
      //             child: Container(
      //               width: double.infinity,
      //               padding: const EdgeInsets.all(16),
      //             ),
      //           ),
      //         ],
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(24, 48, 24, 0),
          alignment: Alignment.center,
          height: 80,
          child: Text(
            "Let's verify your identity",
            style: AppStyles.text24PxBold,
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(24, 0, 24, 48),
          alignment: Alignment.center,
          child: Text(
            'We are provide some ways to verify your identity. Your information will be encrypted and stored securely',
            style: AppStyles.text14PxMedium,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 24),
        ScanMenu(
          image: AppAssets.id_card,
          title: 'OCR Check',
        ),
        SizedBox(height: 24),
        ScanMenu(
          image: AppAssets.face_id,
          title: 'Liveness Check',
        ),
        SizedBox(height: 24),
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
        margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
        padding: EdgeInsets.all(24),
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
          SizedBox(width: 24),
          Expanded(
            child: Text(
              title,
              style: AppStyles.text12PxBold,
            ),
          ),
          ImageIcon(
            AssetImage(AppAssets.arrow_right),
            size: 24,
          )
        ]),
      ),
    );
  }
}
