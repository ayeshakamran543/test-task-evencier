import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A reusable bottom navigation bar built from a list of
/// [BottomNavItem]s, styled to follow [AppTheme]'s border and
/// selected/unselected nav colors.
class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.items,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final List<BottomNavItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const DecoratedBox(
          decoration: BoxDecoration(color: Color(0xFF404040)),
          child: SizedBox(height: 0.5, width: double.infinity),
        ),
        Padding(
          padding: EdgeInsets.only(top: 6.h),
          child: NavigationBar(
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected,
            destinations: [
              for (final item in items)
                NavigationDestination(
                  icon: _NavIcon(item.svgAsset),
                  label: item.label,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Describes a single destination in a [BottomNavBar].
class BottomNavItem {
  const BottomNavItem({required this.svgAsset, required this.label});

  final String svgAsset;
  final String label;
}

/// A bottom-nav SVG icon that picks up its color and size from the
/// ambient [IconTheme], so it follows [AppTheme]'s selected/unselected
/// nav bar styling exactly like a built-in [Icon] would.
class _NavIcon extends StatelessWidget {
  const _NavIcon(this.asset);

  final String asset;

  @override
  Widget build(BuildContext context) {
    final iconTheme = IconTheme.of(context);
    return SvgPicture.asset(
      asset,
      width: iconTheme.size,
      height: iconTheme.size,
      colorFilter: ColorFilter.mode(iconTheme.color!, BlendMode.srcIn),
    );
  }
}
