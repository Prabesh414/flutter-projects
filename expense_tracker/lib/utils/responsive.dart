import 'package:flutter/material.dart';

/// Responsive breakpoints for different device sizes
class ResponsiveBreakpoints {
  // Mobile breakpoints
  static const double mobileSmall = 320;
  static const double mobileMedium = 375;
  static const double mobileLarge = 412;

  // Tablet breakpoints
  static const double tabletPortrait = 600;
  static const double tabletLandscape = 900;
  static const double desktop = 1440;

  /// Determines device type based on screen width
  static DeviceType getDeviceType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    if (width >= desktop) {
      return DeviceType.desktop;
    } else if (width >= tabletLandscape ||
        (width >= tabletPortrait && !isLandscape)) {
      return DeviceType.tablet;
    } else {
      return DeviceType.mobile;
    }
  }

  /// Determines if device is in landscape mode
  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }
}

enum DeviceType { mobile, tablet, desktop }

/// Responsive spacing utilities
class ResponsiveSpacing {
  static double _getResponsiveValue(
    BuildContext context, {
    required double mobileValue,
    required double tabletValue,
    required double desktopValue,
  }) {
    final deviceType = ResponsiveBreakpoints.getDeviceType(context);

    return switch (deviceType) {
      DeviceType.mobile => mobileValue,
      DeviceType.tablet => tabletValue,
      DeviceType.desktop => desktopValue,
    };
  }

  static double horizontal(BuildContext context) {
    return _getResponsiveValue(
      context,
      mobileValue: 12,
      tabletValue: 16,
      desktopValue: 24,
    );
  }

  static double vertical(BuildContext context) {
    return _getResponsiveValue(
      context,
      mobileValue: 12,
      tabletValue: 16,
      desktopValue: 24,
    );
  }

  static double extraSmall(BuildContext context) {
    return _getResponsiveValue(
      context,
      mobileValue: 4,
      tabletValue: 6,
      desktopValue: 8,
    );
  }

  static double small(BuildContext context) {
    return _getResponsiveValue(
      context,
      mobileValue: 8,
      tabletValue: 12,
      desktopValue: 16,
    );
  }

  static double medium(BuildContext context) {
    return _getResponsiveValue(
      context,
      mobileValue: 12,
      tabletValue: 16,
      desktopValue: 20,
    );
  }

  static double large(BuildContext context) {
    return _getResponsiveValue(
      context,
      mobileValue: 16,
      tabletValue: 24,
      desktopValue: 32,
    );
  }
}

/// Responsive font sizes
class ResponsiveFontSizes {
  static double _getResponsiveValue(
    BuildContext context, {
    required double mobileValue,
    required double tabletValue,
    required double desktopValue,
  }) {
    final deviceType = ResponsiveBreakpoints.getDeviceType(context);

    return switch (deviceType) {
      DeviceType.mobile => mobileValue,
      DeviceType.tablet => tabletValue,
      DeviceType.desktop => desktopValue,
    };
  }

  static double small(BuildContext context) {
    return _getResponsiveValue(
      context,
      mobileValue: 12,
      tabletValue: 14,
      desktopValue: 16,
    );
  }

  static double body(BuildContext context) {
    return _getResponsiveValue(
      context,
      mobileValue: 14,
      tabletValue: 16,
      desktopValue: 18,
    );
  }

  static double title(BuildContext context) {
    return _getResponsiveValue(
      context,
      mobileValue: 16,
      tabletValue: 18,
      desktopValue: 22,
    );
  }

  static double heading(BuildContext context) {
    return _getResponsiveValue(
      context,
      mobileValue: 18,
      tabletValue: 22,
      desktopValue: 28,
    );
  }
}
