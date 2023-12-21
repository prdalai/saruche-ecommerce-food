import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nibbles_ecommerce/application/cubits/kids/kids_cubit.dart';
import 'package:nibbles_ecommerce/configs/configs.dart';
import 'package:nibbles_ecommerce/core/constants/colors.dart';
import 'package:nibbles_ecommerce/core/constants/strings.dart';
import 'package:nibbles_ecommerce/models/kid.dart';
import 'package:nibbles_ecommerce/presentation/widgets/custom_elevated_button.dart';
import 'package:nibbles_ecommerce/presentation/widgets/custom_textformfield.dart';

import '../../core/validator/validator.dart';
import 'kids_components.dart';

class Step1 extends StatefulWidget {
  const Step1({super.key});

  @override
  State<Step1> createState() => _Step1State();
}

class _Step1State extends State<Step1> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final Validators _validators = Validators();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<KidsCubit>().getKids(FirebaseAuth.instance.currentUser!.uid);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _genderController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Space.all(1, 1.2),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<KidsCubit, KidsState>(
              builder: (context, state) {
                if (state is KidsLoaded) {
                  log(state.kids.toString());
                  return addStack(true);
                } else if (state is KidsError) {
                  log(state.errorMessage.toString());
                  return const SizedBox.shrink();
                } else {
                  log("Unkown");
                  return addStack(false);
                }
              },
            ),
            Space.yf(),
            customTextFormField(
                label: "Name*",
                controller: _nameController,
                validator: _validators.validateFirstName),
            Space.yf(1.3),
            customTextFormField(
                label: "Gender*",
                controller: _genderController,
                validator: _validators.validateGender),
            Space.yf(1.3),
            customTextFormField(
                label: "Age*",
                controller: _ageController,
                validator: _validators.validateAge),
            Space.yf(1.3),
            Row(
              children: [
                Expanded(
                    child: customTextFormField(
                        label: "Height*",
                        controller: _heightController,
                        validator: _validators.validateHeight)),
                Space.xf(2),
                Expanded(
                    child: customTextFormField(
                        label: "Weight*",
                        controller: _weightController,
                        validator: _validators.validateWeight)),
              ],
            ),
            Space.yf(3.3),
            BlocConsumer<KidsCubit, KidsState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Padding(
                  padding: Space.h!,
                  child: customElevatedButton(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<KidsCubit>().addKid(Kid(
                              gender: _genderController.text,
                              name: _nameController.text,
                              age: _ageController.text,
                              height: _heightController.text,
                              weight: _weightController.text));

                          if (state is KidsAddedSuccessfully) {
                            _genderController.clear();
                            _nameController.clear();
                            _ageController.clear();
                            _heightController.clear();
                            _weightController.clear();
                          }
                        }
                      },
                      text: (state is! KidsLoading)
                          ? "Add".toUpperCase()
                          : AppStrings.wait,
                      heightFraction: 20,
                      width: double.infinity,
                      color: AppColors.commonAmber),
                );
              },
            ),
            Space.yf(1.3),
          ],
        ),
      ),
    );
  }
}

class Step2 extends StatelessWidget {
  const Step2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class Step3 extends StatelessWidget {
  const Step3({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
