import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ChangeEvent {}

class GetUserNameEvent extends ChangeEvent {}