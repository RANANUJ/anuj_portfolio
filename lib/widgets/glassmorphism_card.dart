import 'package:flutter/material.dart';
import 'dart:ui' as ui;

/// A widget that creates a glassmorphism effect with frosted glass appearance
/// This component uses backdrop filters and semi-transparent colors for modern UI
class GlassmorphismCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final double blurSigma;
  final Color backgroundColor;
  final double borderRadius;
  final Border? border;
  final BoxShadow? shadow;
  final Gradient? gradient;

  const GlassmorphismCard({
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.blurSigma = 10.0,
    this.backgroundColor = const Color(0x1AFFFFFF),
    this.borderRadius = 20.0,
    this.border,
    this.shadow,
    this.gradient,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: Container(
          decoration: BoxDecoration(
            gradient: gradient ??
                LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    backgroundColor,
                    backgroundColor.withValues(alpha: 0.1),
                  ],
                ),
            borderRadius: BorderRadius.circular(borderRadius),
            border: border ??
                Border.all(
                  color: Colors.white.withValues(alpha: 0.2),
                  width: 1.5,
                ),
            boxShadow: shadow != null ? [shadow!] : [],
          ),
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}

/// A customizable glassmorphism container that can wrap any widget
class GlassmorphismContainer extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final EdgeInsets padding;
  final double blurSigma;
  final Color backgroundColor;
  final double borderRadius;
  final VoidCallback? onTap;

  const GlassmorphismContainer({
    required this.child,
    this.width = double.infinity,
    this.height = double.infinity,
    this.padding = const EdgeInsets.all(16),
    this.blurSigma = 15.0,
    this.backgroundColor = const Color(0x0DFFFFFF),
    this.borderRadius = 25.0,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  backgroundColor.withValues(alpha: 0.15),
                  backgroundColor.withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.25),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Padding(
              padding: padding,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
