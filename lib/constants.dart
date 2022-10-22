import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:oral_mate/controller/auth_controller.dart';

//colors
const backgroundColor = Colors.white;
var buttonColor = Colors.black;
const backgoundColor = Colors.grey;
const scaffoldColor = Color(0xFFFAFAFF);

//firebase
var auth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var fireStore = FirebaseFirestore.instance;

//controller
var authController = AuthController.instance;
