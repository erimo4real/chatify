import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../logic/auth/auth_bloc.dart';
import '../../logic/auth/auth_event.dart';
import '../../logic/auth/auth_state.dart';
import '../widgets/custom_button.dart';
import '../widgets/text_input_field.dart';
import 'dart:io';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _register(BuildContext context) {
    if (_formKey.currentState!.validate() && _image != null) {
      String username = usernameController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String imagePath = _image!.path;

      context.read<AuthBloc>().add(RegisterRequested(username, email, password, imagePath));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select an image"), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Register", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    child: _image == null ? Icon(Icons.camera_alt, size: 40) : null,
                  ),
                ),
                SizedBox(height: 15),

                TextInputField(
                  controller: usernameController,
                  hintText: "Enter Username",
                  icon: Icons.person,
                  validator: (value) => value!.isEmpty ? "Username is required" : null,
                ),
                SizedBox(height: 15),

                TextInputField(
                  controller: emailController,
                  hintText: "Enter Email",
                  icon: Icons.email,
                  validator: (value) => value!.isEmpty ? "Email is required" : null,
                ),
                SizedBox(height: 15),

                TextInputField(
                  controller: passwordController,
                  hintText: "Enter Password",
                  icon: Icons.lock,
                  isPassword: true,
                  validator: (value) => value!.length < 6 ? "Password too short" : null,
                ),
                SizedBox(height: 20),

                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return CircularProgressIndicator();
                    }
                    return CustomButton(
                      text: "Register",
                      onPressed: () => _register(context),
                    );
                  },
                ),

                SizedBox(height: 10),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, "/login"),
                  child: Text("Already have an account? Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
