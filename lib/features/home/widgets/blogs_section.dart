import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_typography.dart';

class _Blog {
  const _Blog(this.title, this.background);

  final String title;
  final String background;
}

const _blogs = [
  _Blog("Why People Don't Progress", 'assets/pngs/blogs_bg1.png'),
  _Blog('Is Diet Really Important?', 'assets/pngs/blogs_bg2.png'),
];

/// Horizontally scrolling blog teaser cards shown on the home screen.
class BlogsSection extends StatelessWidget {
  const BlogsSection({super.key, this.onTap});

  final ValueChanged<String>? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _blogs.length,
        separatorBuilder: (_, _) => SizedBox(width: 12.w),
        itemBuilder: (context, index) =>
            _BlogCard(blog: _blogs[index], onTap: onTap),
      ),
    );
  }
}

class _BlogCard extends StatelessWidget {
  const _BlogCard({required this.blog, this.onTap});

  final _Blog blog;
  final ValueChanged<String>? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(8.r),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap == null ? null : () => onTap!(blog.title),
        child: Container(
          width: 190.w,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(blog.background),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.55),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 12.w,
                right: 30.w,
                bottom: 21.h,
                child: Text(
                  blog.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.b2b(
                    context,
                  ).copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
