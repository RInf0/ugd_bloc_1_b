import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ugd_bloc_1_b/bloc/form_submission_state.dart';
import 'package:ugd_bloc_1_b/bloc/register/register_bloc.dart';
import 'package:ugd_bloc_1_b/bloc/register/register_event.dart';
import 'package:ugd_bloc_1_b/bloc/register/register_state.dart';
import 'package:ugd_bloc_1_b/page/login_page.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  //* untuk validasi harus menggunakan GlobayKey
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController bornDateController = TextEditingController();

  // true => invisible at first
  bool isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterBloc>(
      create: (context) => RegisterBloc(),
      child: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state.formSubmissionState is SubmissionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Register Success"),
              ),
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const LoginView(),
              ),
            );
          }
          if (state.formSubmissionState is SubmissionFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text((state.formSubmissionState as SubmissionFailed)
                    .exception
                    .toString()),
              ),
            );
          }
        },
        child:
            BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              body: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // username
                      TextFormField(
                        autofocus: true,
                        controller: usernameController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: 'Username',
                        ),
                        validator: (value) =>
                            value == '' ? 'Please enter your username!' : null,
                      ),

                      // email
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          labelText: 'Email',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email!';
                          }
                          if (!value.contains('@')) {
                            return 'Please enter a valid email!';
                          }
                          return null;
                        },
                      ),

                      // password
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            onPressed: () {
                              context.read<RegisterBloc>().add(
                                    IsPasswordVisibleChanged(),
                                  );
                            },
                            icon: Icon(
                              state.isPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color:
                                  isPasswordVisible ? Colors.grey : Colors.blue,
                            ),
                          ),
                        ),
                        obscureText: state.isPasswordVisible,
                        validator: (value) =>
                            value == '' ? 'Please enter your password!' : null,
                      ),

                      // phone number
                      TextFormField(
                        controller: phoneNumberController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          labelText: 'Phone Number',
                        ),
                        validator: (value) => value == ''
                            ? 'Please enter your phone number!'
                            : null,
                      ),

                      // born date
                      TextFormField(
                        // hide keyboard ketika input date ditap
                        keyboardType: TextInputType.none,
                        readOnly: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your born date!';
                          }
                          return null;
                        },
                        controller: bornDateController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.calendar_today_outlined),
                          suffixIcon: Icon(
                            Icons.calendar_today,
                            color: Color.fromARGB(255, 7, 128, 227),
                          ),
                          labelText: "Born Date",
                        ),
                        onTap: () async {
                          DateTime? pickeddate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now());
                          if (pickeddate != null) {
                            bornDateController.text =
                                DateFormat('dd-MM-yyyy').format(pickeddate);
                          }
                        },
                      ),

                      const SizedBox(height: 30),

                      // button submit
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // validasi form
                            if (_formKey.currentState!.validate()) {
                              context.read<RegisterBloc>().add(
                                    FormSumitted(
                                        username: usernameController.text,
                                        password: passwordController.text,
                                        email: emailController.text,
                                        no: phoneNumberController.text),
                                  );
                              // Map<String, dynamic> formData = {};
                              // formData['username'] = usernameController.text;
                              // formData['password'] = passwordController.text;
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 16.0,
                            ),
                            child: state.formSubmissionState is FormSubmitting
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : Text('Register'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
