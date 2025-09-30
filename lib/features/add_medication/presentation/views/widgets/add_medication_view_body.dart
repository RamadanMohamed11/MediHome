import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medihome/core/utils/app_router.dart';
import 'package:medihome/core/widgets/custom_button.dart';
import 'package:medihome/features/add_medication/presentation/views/widgets/dose_numbers_text_form_field.dart';
import 'package:medihome/features/add_medication/presentation/views/widgets/medication_name_text_form_field.dart';
import 'package:medihome/generated/l10n.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class DateTimePickerWidget extends StatelessWidget {
  const DateTimePickerWidget({
    super.key,
    required this.selectedDateRange,
    required this.onPressed,
  });

  final PickerDateRange? selectedDateRange;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    String rangeText;
    if (selectedDateRange == null) {
      rangeText = S.of(context).selectDateRange;
    } else {
      rangeText =
          '${DateFormat('dd/MM/yyyy').format(selectedDateRange!.startDate!)} -'
          ' ${DateFormat('dd/MM/yyyy').format(selectedDateRange!.endDate ?? selectedDateRange!.startDate!)}';
    }

    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.calendar_today, color: Colors.white70),
      label: Text(rangeText, style: const TextStyle(color: Colors.white)),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        side: const BorderSide(color: Colors.white54),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

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
  Color selectedColor = Colors.red;
  final List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.cyan,
    Colors.indigo,
    Colors.lime,
  ];
  PickerDateRange? _selectedDateRange;

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

              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: DateTimePickerWidget(
                      selectedDateRange: _selectedDateRange,
                      onPressed: _pickDateRange,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                S.of(context).selectTheColor,
                style: TextStyle(fontSize: 20, color: Colors.white70),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: colors.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedColor = colors[index];
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        margin: index != colors.length - 1
                            ? EdgeInsets.only(right: 5)
                            : EdgeInsets.zero,
                        decoration: BoxDecoration(
                          color: selectedColor == colors[index]
                              ? Colors.white
                              : Color(0xff080E1C),
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          margin: EdgeInsets.all(2),
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: colors[index],
                            shape: BoxShape.circle,
                          ),
                          child: selectedColor == colors[index]
                              ? Icon(Icons.check, color: Colors.white)
                              : SizedBox(),
                        ),
                      ),
                    );
                  },
                ),
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

  Future<void> _pickDateRange() async {
    final PickerDateRange? pickedDateRange = await showDialog<PickerDateRange>(
      context: context,
      builder: (BuildContext context) {
        PickerDateRange? tempRange;
        return AlertDialog(
          content: SizedBox(
            height: 350,
            width: 350,
            child: SfDateRangePicker(
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                if (args.value is PickerDateRange) {
                  tempRange = args.value;
                }
              },
              selectionMode: DateRangePickerSelectionMode.range,
              initialSelectedRange: _selectedDateRange,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(S.of(context).cancel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(S.of(context).ok),
              onPressed: () {
                Navigator.of(context).pop(tempRange);
              },
            ),
          ],
        );
      },
    );

    if (pickedDateRange != null) {
      setState(() {
        _selectedDateRange = pickedDateRange;
      });
    }
  }
}
