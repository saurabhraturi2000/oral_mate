import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oral_mate/controller/auth_controller.dart';
import 'package:oral_mate/pages/login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  //Controller
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Register",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                Obx(() => CircleAvatar(
                      radius: 64,
                      backgroundImage:
                          AuthController.instance.isProfilePicPathSet.value ==
                                  true
                              ? FileImage(AuthController.instance.profilePhoto!)
                                  as ImageProvider
                              : const NetworkImage(
                                  "http://www.gravatar.com/avatar/?d=mp"),
                      backgroundColor: Colors.black,
                    )),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    onPressed: () => AuthController.instance.pickImage(),
                    icon: const Icon(Icons.add_a_photo),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: "Username",
                  prefixIcon: const Icon(Icons.person)),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: "Email",
                  prefixIcon: const Icon(Icons.email)),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: "Password",
                prefixIcon: const Icon(
                  Icons.lock,
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  AuthController.instance.register(
                    _usernameController.text.trim(),
                    _emailController.text.trim(),
                    _passwordController.text.trim(),
                    AuthController.instance.profilePhoto,
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(fontSize: 20),
                )),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text("have a account?"),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => Get.to(() => const LoginPage()),
                child: const Text(
                  "SignIn",
                  style: TextStyle(color: Colors.blue),
                ),
              )
            ])
          ],
        ),
      ),
    );
  }
}
