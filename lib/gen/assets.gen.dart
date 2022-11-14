/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  AssetGenImage get timeIn => const AssetGenImage('assets/icons/Time Square.png');
  AssetGenImage get timeOut => const AssetGenImage('assets/icons/TimeO.png');
  AssetGenImage get timeCircle => const AssetGenImage('assets/icons/Time Circle.png');
  AssetGenImage get profile => const AssetGenImage('assets/icons/Profile.png');
  AssetGenImage get profileGreen => const AssetGenImage('assets/icons/Profile_green.png');
  AssetGenImage get home_grey => const AssetGenImage('assets/icons/Home_grey.png');
  AssetGenImage get home => const AssetGenImage('assets/icons/Home.png');
  AssetGenImage get editSquare => const AssetGenImage('assets/icons/Edit Square.png');
  AssetGenImage get documentGreen => const AssetGenImage('assets/icons/Document_green.png');
  AssetGenImage get document => const AssetGenImage('assets/icons/Document.png');
  AssetGenImage get notify => const AssetGenImage('assets/icons/Vector.png');
  AssetGenImage get close => const AssetGenImage('assets/icons/x.png');
  AssetGenImage get cameraGreen => const AssetGenImage('assets/icons/camera_green.png');
  AssetGenImage get edit => const AssetGenImage('assets/icons/Edit.png');
  AssetGenImage get message => const AssetGenImage('assets/icons/Message.png');
  AssetGenImage get call => const AssetGenImage('assets/icons/Call.png');
  AssetGenImage get wifi => const AssetGenImage('assets/icons/wifi.png');
  AssetGenImage get location => const AssetGenImage('assets/icons/Location.png');
  AssetGenImage get bag => const AssetGenImage('assets/icons/bag.png');
  AssetGenImage get search => const AssetGenImage('assets/icons/Search.png');
  AssetGenImage get identification => const AssetGenImage('assets/icons/identification.png');
  AssetGenImage get jobPosition => const AssetGenImage('assets/icons/jobPosition.png');
  AssetGenImage get back => const AssetGenImage('assets/icons/back.png');
  AssetGenImage get calender => const AssetGenImage('assets/icons/Calendar.png');
  AssetGenImage get cameraChat => const AssetGenImage('assets/icons/camera_chat.png');
  AssetGenImage get line => const AssetGenImage('assets/icons/line.png');
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  AssetGenImage get advertiserCardHeading =>
      const AssetGenImage('assets/images/advertiser_card_heading.png');
  AssetGenImage get groupCardHeading =>
      const AssetGenImage('assets/images/group_card_heading.png');
  AssetGenImage get headerIntro =>
      const AssetGenImage('assets/images/header_intro.png');
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.png');
  AssetGenImage get pickImage => const AssetGenImage('assets/images/pickImage.png');
  AssetGenImage get idCard => const AssetGenImage('assets/images/idCard.png');
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName) : super(assetName);

  Image image({
    Key? key,
    ImageFrameBuilder? frameBuilder,
    ImageLoadingBuilder? loadingBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => assetName;
}
