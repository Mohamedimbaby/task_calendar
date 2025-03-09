import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/theme/app_colors.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconList = [
      "assets/images/home.svg",
      "assets/images/file.svg",
      "assets/images/calendar.svg",
      "assets/images/profile.svg",
    ];

    return AnimatedBottomNavigationBar.builder(
      itemCount: iconList.length,
      tabBuilder: (int index, bool isActive) {
        final color = isActive ? AppColors.black : Colors.grey;
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            index == iconList.length-1 ?
                Image.asset("assets/images/profile.png", width: 24, height: 24)
                :
            SvgPicture.asset(
              iconList[index],
              colorFilter:  ColorFilter.mode(color, BlendMode.srcIn),
            ),
          ],
        );
      },
      backgroundColor: AppColors.white,
      activeIndex: currentIndex,
      splashColor: AppColors.black,
      notchSmoothness: NotchSmoothness.softEdge,
      gapLocation: GapLocation.center,
      leftCornerRadius: 32,
      rightCornerRadius: 32,
      onTap: onTap,
      shadow: const BoxShadow(
        offset: Offset(0, 1),
        blurRadius: 12,
        spreadRadius: 0.5,
        color: Colors.black12,
      ),
    );
  }
}
