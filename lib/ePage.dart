import 'package:flutter/material.dart';

// ignore: camel_case_types
abstract class ePage extends StatelessWidget {
  const ePage(this.leading, this.title);

  final Widget leading;
  final String title;
}