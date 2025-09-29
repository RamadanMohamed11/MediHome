import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medihome/core/utils/app_router.dart';
import 'package:medihome/core/widgets/custom_button.dart';
import 'package:medihome/features/add_medication/presentation/views/widgets/dose_numbers_text_form_field.dart';
import 'package:medihome/features/add_medication/presentation/views/widgets/medication_name_text_form_field.dart';
import 'package:medihome/generated/l10n.dart';
import 'package:shimmer/shimmer.dart';

class AddMedicationViewBody extends StatefulWidget {
  const AddMedicationViewBody({super.key});

  @override
  State<AddMedicationViewBody> createState() => _AddMedicationViewBodyState();
}

class _AddMedicationViewBodyState extends State<AddMedicationViewBody> {
  late TextEditingController nameController;
  late TextEditingController currentStockController;
  late TextEditingController pillsPerDoseController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    currentStockController = TextEditingController();
    pillsPerDoseController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 30),
              Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.blue,
                period: Duration(seconds: 5),
                child: Text(
                  S.of(context).addMedication,
                  style: TextStyle(fontSize: 24),
                ),
              ),
              SizedBox(height: 20),
              MedicationNameTextFormField(
                nameController: nameController,
                onSavedMethod: nameOnSavedMethod,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: DoseNumbersTextFormField(
                      currentStockController: currentStockController,
                      onSavedMethod: currentStockOnSavedMethod,
                      onIncrement: () =>
                          _incrementStock(currentStockController),
                      onDecrement: () =>
                          _decrementStock(currentStockController),
                      hintText: S.of(context).currentStock,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: DoseNumbersTextFormField(
                      currentStockController: pillsPerDoseController,
                      onSavedMethod: currentStockOnSavedMethod,
                      onIncrement: () =>
                          _incrementStock(pillsPerDoseController),
                      onDecrement: () =>
                          _decrementStock(pillsPerDoseController),
                      hintText: S.of(context).pillsPerDose,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: CustomButton(
                      buttonText: S.of(context).addMedication,
                      onPressed: () {},
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextButton(
                      child: Text(
                        S.of(context).share,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                        }
                        GoRouter.of(context).push(AppRouter.kShareEmails);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _incrementStock(TextEditingController controller) {
    int currentValue = int.tryParse(controller.text) ?? 0;
    currentValue++;
    controller.text = currentValue.toString();
  }

  void _decrementStock(TextEditingController controller) {
    int currentValue = int.tryParse(controller.text) ?? 0;
    if (currentValue > 0) {
      currentValue--;
      controller.text = currentValue.toString();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    currentStockController.dispose();
    pillsPerDoseController.dispose();
    super.dispose();
  }

  void nameOnSavedMethod(String? value) {}
  void currentStockOnSavedMethod(String? value) {}
}
