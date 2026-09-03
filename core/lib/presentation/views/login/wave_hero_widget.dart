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

/// The height every full-width action button on the auth screens uses, so
/// they line up exactly. Also a comfortable touch target.
const double authButtonHeight = 48;

/// Maximum width of the auth screens' body content, so every control below
/// the hero shares one width at any window size (and the form does not
/// stretch across a wide desktop display).
const double authContentMaxWidth = 400;

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

/// Shared layout for the auth screens, mirroring bodhimail's
/// `WaveHeroScaffold`: a brand-green wave hero panel up top and a white body
/// below carrying a large [title] (not a conventional small AppBar title —
/// this replaces the app bar entirely here), an optional [subtitle], and
/// arbitrary [child] content, capped and centered at [authContentMaxWidth].
class WaveHeroScaffold extends StatelessWidget {
  const WaveHeroScaffold({
    required this.title,
    required this.child,
    this.subtitle,
    this.heroHeight = 260,
    super.key,
  });

  final String title;
  final String? subtitle;
  final Widget child;
  final double heroHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        WaveHeroWidget(height: heroHeight),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: authContentMaxWidth),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1B1B1B),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 6, bottom: 4),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 10),
                    Text(
                      subtitle!,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFF6B6B6B),
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  child,
                ],
              ),
            ),
          ),
        ),
      ],
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
