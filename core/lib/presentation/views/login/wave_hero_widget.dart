import 'package:core/presentation/extensions/color_extension.dart';
import 'package:flutter/material.dart';

/// Clips a wave shape along the bottom edge — a shallow S-curve. Ported
/// from bodhimail's `WaveHeroScaffold` (`../bodhimail/app/lib/shared/widgets/wave_hero_scaffold.dart`)
/// to bring its auth-screen hero treatment to tmail-flutter's login screen.
class _WaveBottomClipper extends CustomClipper<Path> {
  const _WaveBottomClipper();

  @override
  Path getClip(Size size) {
    final path = Path()..lineTo(0, size.height * 0.78);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height,
      size.width * 0.5,
      size.height * 0.86,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.72,
      size.width,
      size.height * 0.92,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

/// Brand-green wave hero panel — a diagonal gradient with a few soft,
/// oversized translucent circles — matching bodhimail's auth screens.
class WaveHeroWidget extends StatelessWidget {
  const WaveHeroWidget({super.key, this.height = 200, this.child});

  final double height;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: const _WaveBottomClipper(),
      child: Container(
        height: height,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF2C6112), AppColor.primaryColor],
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -60,
              right: -50,
              child: _HeroCircle(
                diameter: 220,
                color: Colors.white.withValues(alpha: 0.10),
              ),
            ),
            Positioned(
              bottom: -40,
              left: -30,
              child: _HeroCircle(
                diameter: 140,
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
            Positioned(
              top: height * 0.28,
              right: 30,
              child: _HeroCircle(
                diameter: 64,
                color: Colors.white.withValues(alpha: 0.14),
              ),
            ),
            if (child != null) child!,
          ],
        ),
      ),
    );
  }
}

class _HeroCircle extends StatelessWidget {
  const _HeroCircle({required this.diameter, required this.color});

  final double diameter;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}
