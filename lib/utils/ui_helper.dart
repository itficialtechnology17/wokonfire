import 'package:flutter/material.dart';

const double _VerticalSpaceExtraSmall = 4.0;
const double _VerticalSpaceSmall = 8.0;
const double _VerticalSpaceMedium = 16.0;
const double _VerticalSpaceLarge = 24.0;
const double _VerticalSpaceExtraLarge = 48;

const double _HorizontalSpaceExtraSmall = 4;
const double _HorizontalSpaceSmall = 8.0;
const double _HorizontalSpaceMedium = 16.0;
const double _HorizontalSpaceLarge = 24.0;
const double _HorizontalSpaceExtraLarge = 48.0;

SizedBox verticalSpaceExtraSmall() => verticalSpace(_VerticalSpaceExtraSmall);
SizedBox verticalSpaceSmall() => verticalSpace(_VerticalSpaceSmall);
SizedBox verticalSpaceMedium() => verticalSpace(_VerticalSpaceMedium);
SizedBox verticalSpaceLarge() => verticalSpace(_VerticalSpaceLarge);
SizedBox verticalSpaceExtraLarge() => verticalSpace(_VerticalSpaceExtraLarge);

SizedBox verticalSpace(double height) => SizedBox(height: height);

SizedBox horizontalSpaceExtraSmall() =>
    horizontalSpace(_HorizontalSpaceExtraSmall);
SizedBox horizontalSpaceSmall() => horizontalSpace(_HorizontalSpaceSmall);
SizedBox horizontalSpaceMedium() => horizontalSpace(_HorizontalSpaceMedium);
SizedBox horizontalSpaceLarge() => horizontalSpace(_HorizontalSpaceLarge);
SizedBox horizontalSpaceExtraLarge() =>
    horizontalSpace(_HorizontalSpaceExtraLarge);

SizedBox horizontalSpace(double width) => SizedBox(width: width);
