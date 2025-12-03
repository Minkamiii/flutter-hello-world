
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/enumerator/type.dart';

mixin BaseAdaptiveLayout {
  double get mobileBreakpoint => 600;
  double get tabletBreakpoint => 900;

  Widget buildLandscapeMobile(BuildContext context, Size size){
    return const SizedBox();
  }

  Widget buildPortraitMobile(BuildContext context, Size size){
    return const SizedBox();
  }

  Widget buildLandscapeTablet(BuildContext context, Size size){
    return const SizedBox();
  }

  Widget buildPortraitTablet(BuildContext context, Size size){
    return const SizedBox();
  }

  Widget buildLandscapeDesktop(BuildContext context, Size size){
    return const SizedBox();
  }
  
  Widget buildPortraitDesktop(BuildContext context, Size size){
    return const SizedBox();
  }

  Widget _buildAdaptiveLayout(
    BuildContext context,
    DeviceType deviceType,
    Orientation orientation,
    Size size
  ) {
    switch(deviceType){
      case DeviceType.mobile:
        return orientation == Orientation.landscape 
        ? buildLandscapeMobile(context, size) 
        : buildPortraitMobile(context, size);
      case DeviceType.tablet:
        return orientation == Orientation.landscape 
        ? buildLandscapeTablet(context, size) 
        : buildPortraitTablet(context, size);
      case DeviceType.desktop:
        return orientation == Orientation.landscape 
        ? buildLandscapeDesktop(context, size) 
        : buildPortraitDesktop(context, size);
    }
  }

  DeviceType _getDeviceType(double width){
    if(width < mobileBreakpoint) return DeviceType.mobile;
    if(width < tabletBreakpoint) return DeviceType.tablet;
    return DeviceType.desktop;
  }

  @protected
  @nonVirtual
  Widget adaptiveLayout(BuildContext context){
    return LayoutBuilder(
      builder: (context, constraints){
        final deviceType = _getDeviceType(constraints.maxWidth);
        final orientation = MediaQuery.of(context).orientation;
        final size = Size(constraints.maxWidth, constraints.maxHeight);

        return _buildAdaptiveLayout(context, deviceType, orientation, size);
      }
    );
  }
}