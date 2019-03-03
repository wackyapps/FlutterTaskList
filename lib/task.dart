import 'dart:ui';
import 'package:flutter/material.dart';

class Task{

  final String taskname, subtask, tasktime;

  final Color status;

  Task(this.taskname, this.subtask, this.tasktime, this.status);
}