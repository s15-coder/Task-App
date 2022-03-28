import 'package:flutter/material.dart';

extension CustomColorScheme on ColorScheme {
  Color get colorTaskCard => brightness == Brightness.light
      ? Colors.white
      : const Color.fromRGBO(96, 96, 96, 1);

  // Color get colorTextProgressDialog => brightness == Brightness.light
  //     ? const Color(0xFF000000)
  //     : const Color(0xFFFFFFFF);

  // Color get colorTextAppBar => brightness == Brightness.light
  //     ? const Color(0xFF000000)
  //     : const Color(0xFF000000);

  // Color get colorTitleTextCarnet => brightness == Brightness.light
  //     ? const Color(0xB3000000)
  //     : const Color(0xB3FFFFFF);

  // Color get colorSubTitleTextCarnet => brightness == Brightness.light
  //     ? const Color(0xFF000000)
  //     : const Color(0xFFFFFFFF);

  // Color get colorTextGeneralDialogs => brightness == Brightness.light
  //     ? const Color(0xFF838383)
  //     : const Color(0xFFFFFFFF);

  // Color get colorBgContainerInfoMapDetail => brightness == Brightness.light
  //     ? const Color(0xFFF8FAFF)
  //     : const Color(0xFF303030);

  // Color get colorIconBackDetail => brightness == Brightness.dark
  //     ? const Color(0xFFFFFFFF)
  //     : const Color(0xFF000000);

  // Color get oppositeColor => brightness == Brightness.dark
  //     ? const Color(0xFFFFFFFF)
  //     : const Color(0xFF000000);

  // Color get sameColor => brightness == Brightness.dark
  //     ? const Color(0xFF000000)
  //     : const Color(0xFFFFFFFF);

  // Color get alwaysWhite => Persist.whiteLogin;

  // Color get alwaysBlack => Persist.blackLogin;

  // Color get filterColorItems => brightness == Brightness.light
  //     ? const Color(0xFF000000)
  //     : const Color(0xFFFFFFFF);

  // Color get blueBlackAndWhite =>
  //     brightness == Brightness.dark ? Colors.white : Persist.blueBlack;

  // Color get baseColorLoading => brightness == Brightness.light
  //     ? Colors.grey[300]
  //     : const Color(0xFF7A7979);

  // Color get highlightColorLoading => brightness == Brightness.light
  //     ? Colors.grey[100]
  //     : const Color(0xFF7A7979).withOpacity(.7);
  // Color get whiteAndDarkGrey => brightness == Brightness.light
  //     ? Colors.white
  //     : const Color.fromRGBO(81, 81, 81, 1);
  // Color get darkGreyAndWhite =>
  //     brightness == Brightness.light ? Colors.grey[700] : Colors.white;

  // Color get profileCardColor => brightness == Brightness.light
  //     ? const Color(0xFFFFFFFF)
  //     : const Color(0xFF424242);

  // BoxShadow get boxShadowGeneric => brightness == Brightness.light
  //     ? const BoxShadow(
  //         color: Colors.black26,
  //         spreadRadius: 0.2,
  //         blurRadius: 2,
  //       )
  //     : const BoxShadow(
  //         color: Colors.grey,
  //         spreadRadius: 0.2,
  //         blurRadius: 2,
  //       );
  // Color get textColorGeneric => brightness == Brightness.light
  //     ? const Color(0xFF838383)
  //     : const Color(0xFFFFFFFF);
  // Color get buttonAuthText =>
  //     brightness == Brightness.light ? Persist.blackLogin : Persist.yellow;
  // Color get buttonAuthBorder =>
  //     brightness == Brightness.light ? Persist.blackLogin : Persist.yellow;
  // Color get buttonAuthPrimary =>
  //     brightness == Brightness.light ? Persist.greyInput : Colors.transparent;
  // Color get forgotPassword =>
  //     brightness == Brightness.light ? Persist.blackLogin : Persist.yellow;
  // Color get labels =>
  //     brightness == Brightness.light ? Persist.blackLogin : Persist.yellow;
  // Color get fills => brightness == Brightness.light
  //     ? const Color(0xFFEEEEEE)
  //     : Colors.grey[800];
  // Color get iconsTextField =>
  //     brightness == Brightness.light ? Persist.blackLogin : Persist.yellow;
  // Color get textTitle =>
  //     brightness == Brightness.light ? Persist.blackLogin : Persist.whiteLogin;
  // Color get iconTextfield =>
  //     brightness == Brightness.light ? Persist.blackLogin : Persist.greyInput;
  // Color get textColor =>
  //     brightness == Brightness.light ? Persist.blackLogin : Persist.whiteLogin;
  // Color get textColorOposite =>
  //     brightness == Brightness.light ? Persist.whiteLogin : Persist.blackLogin;
  // Color get container1Color =>
  //     brightness == Brightness.light ? Persist.whiteLogin : Colors.grey[800];
  // Color get container2Color =>
  //     brightness == Brightness.light ? Persist.whiteLogin : Colors.grey[900];
  // Color get textColor2 => brightness == Brightness.light
  //     ? const Color.fromRGBO(131, 131, 131, 1)
  //     : Persist.whiteLogin;
  // Color get subtextColor2 =>
  //     brightness == Brightness.light ? Colors.grey : Colors.white54;
  // Color get colortext =>
  //     brightness == Brightness.light ? Colors.grey : Colors.white;
  // Color get colortext2 =>
  //     brightness == Brightness.light ? Colors.grey[350] : Persist.blackLogin;
  // Color get greyblue => brightness == Brightness.light
  //     ? Persist.blueButtom
  //     : Persist.blueButtom /*Colors.grey[400]*/;
  // Color getProductCardBackground(BuildContext context) =>
  //     brightness == Brightness.light
  //         ? Theme.of(context).scaffoldBackgroundColor
  //         : Theme.of(context).cardColor /*Colors.grey[400]*/;
  // Color get colorBgMapDetail => brightness == Brightness.light
  //     ? const Color(0xFFFFFFFF)
  //     : const Color(0xFF212121);

  // Color get colorTextInfoMapDetail => brightness == Brightness.light
  //     ? const Color(0xFF212121)
  //     : const Color(0xFFFFFFFF);

  // Color get textFieldBackgound => brightness == Brightness.light
  //     ? const Color(0xFFF8FAFF)
  //     : const Color(0xFF484444);
  // Color get buttonCancelBackground => brightness == Brightness.light
  //     ? const Color(0xFFF0F0F0)
  //     : const Color(0xFFF0F0F0);

  // Color get buttonImageColor => brightness == Brightness.light
  //     ? const Color(0xFF222222)
  //     : const Color(0xFF222222);

  // Color get backgroundImageColor => brightness == Brightness.light
  //     ? const Color(0xFF303030)
  //     : const Color(0xFF303030);

  // Color get backgroundColor => brightness == Brightness.light
  //     ? const Color(0xFFFFFFFF)
  //     : const Color(0xFF333333);

  // Color get iconColorGeneric => brightness == Brightness.light
  //     ? const Color(0xFF495057)
  //     : const Color(0xFFFFFFFF);

  // Color get cardGreyColor => brightness == Brightness.light
  //     ? const Color(0xFFFFFFFF)
  //     : const Color(0xFFF48444);
}
