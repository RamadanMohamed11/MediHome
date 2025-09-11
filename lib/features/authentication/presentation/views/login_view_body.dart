import 'package:flutter/material.dart';
import 'package:medihome/core/utils/assets_data.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          fillOverscroll: true,
          child: Column(
            children: [
              Container(
                height: 200,
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AssetsData.loginBackground),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.medication_liquid_rounded,
                    size: 35,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "MediHome",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 26),
              Expanded(
                flex: 3,
                child: Opacity(
                  opacity: 0.9,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    padding: const EdgeInsets.all(24),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.medication_liquid_rounded,
                          size: 45,
                          color: Colors.blue,
                        ),
                        SizedBox(height: 24),

                        Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Enter your email and password to log in",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        SizedBox(height: 24),
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                        Row(
                          children: [
                            Checkbox(value: false, onChanged: (value) {}),
                            Text(
                              "Remember me",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                            Spacer(),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(double.infinity, 50),
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(right: 12),
                                height: 2,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            Text(
                              "OR",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 12),
                                height: 2,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),

                        /* Gmail Login */
                        SizedBox(height: 24),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don’t have an account?",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
