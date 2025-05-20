



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:ministry/src/core/providers/user_info_provider.dart';
import 'package:ministry/src/core/utils/shimmers.dart';
import 'package:ministry/src/core/widgets/common_widgets.dart';
import 'package:ministry/src/features/dashboard/presentation/ui/dashboard.dart';
import 'package:ministry/src/features/enquiry/application/controller/enquiry_controller.dart';
import 'package:ministry/src/features/enquiry/application/controller/enquiry_notifier.dart';
import 'package:ministry/src/features/enquiry/application/providers/enquiry_provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/gap_manager.dart';
import '../../domain/model/medical_agency_model.dart';

class EnquiryForm extends ConsumerWidget {
  final int provinceId;
  const EnquiryForm({required this.provinceId,super.key});

  @override
  Widget build(BuildContext context, ref) {


    final passportController = ref.watch(enquiryController).passportController;
    final enquiryState = ref.watch(enquiryNotifier);
    // final countriesAsyncValue = ref.watch(countriesProvider);
    final medicalAsyncValue = ref.watch(medicalAgenciesProvider(provinceId));
    final formKey = ref.watch(enquiryController).formKey;
    final nameController = ref.watch(enquiryController).nameController;
    final emailController = ref.watch(enquiryController).emailController;
    final phoneController = ref.watch(enquiryController).phoneController;
    final remarksController = ref.watch(enquiryController).remarksController;
    final dateController = ref.watch(enquiryController).dateController;
    final selectedDate = ref.watch(enquiryController).selectedDate;
    final selectedCountry = ref.watch(enquiryController).selectedCountryDynamic;
    final selectedCode = ref.watch(enquiryController).selectedCode;
    final selectedMedicalAgency = ref.watch(enquiryController).selectedMedical;

    return GestureDetector(
      onTap: ()=>FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: commonNavBar('Enquiry Form'),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    h10,
                    TextFormField(
                      controller: passportController,
                      decoration: InputDecoration(
                        labelText: "Passport No.",
                        prefixIcon: Icon(Icons.person,color: MyColors.primary,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: MyColors.primary),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: MyColors.primary),
                        ),
                      ),
                      validator: (value) {
                        if(value == null || value.trim().isEmpty){
                          return 'Passport is required.';
                        }
                        return null;
                      },
                      // inputFormatters: [
                      //   FilteringTextInputFormatter.digitsOnly
                      // ],
                    ),
                    h10,
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: "Full name",
                        prefixIcon: Icon(Icons.person,color: MyColors.primary,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: MyColors.primary),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: MyColors.primary),
                        ),
                      ),
                      validator: (value) {
                        if(value == null || value.trim().isEmpty){
                          return 'Name is required.';
                        }
                        return null;
                      },
                    ),
                    h10,
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: "E-mail",
                              prefixIcon: Icon(Icons.mail,color: MyColors.primary,),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: MyColors.primary),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: MyColors.primary),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Email is required.';
                              }

                              // Regular expression for email validation
                              final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

                              if (!emailRegex.hasMatch(value.trim())) {
                                return 'Enter a valid email address.';
                              }

                              return null;
                            },

                          ),
                        ),
                        w10,
                        Expanded(
                          child: TextFormField(
                            controller: phoneController,
                            decoration: InputDecoration(
                              labelText: "Mobile no.",
                              prefixIcon: Icon(Icons.phone,color: MyColors.primary,),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: MyColors.primary),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: MyColors.primary),
                              ),
                            ),
                            validator: (value) {
                              if(value == null || value.trim().isEmpty){
                                return 'Contact is required.';
                              }
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                      ],
                    ),
                    h10,
                    TextFormField(
                      controller: remarksController,
                      decoration: InputDecoration(
                        labelText: "Remarks",
                        prefixIcon: Icon(Icons.note,color: MyColors.primary,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: MyColors.primary),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: MyColors.primary),
                        ),
                      ),
                      maxLines: null,
                      validator: (value) {
                        if(value == null || value.trim().isEmpty){
                          return 'Remarks is required.';
                        }
                        return null;
                      },
                    ),
                    h10,
                    medicalAsyncValue.when(
                      data: (medicalAgencies) {
                        return DropdownSearch<MedicalAgencyModel>(
                          items: (filter, loadProps) => medicalAgencies, // List of MedicalAgencyModel
                          selectedItem: selectedMedicalAgency,
                          itemAsString: (MedicalAgencyModel agency) => agency.organizationname, // Display organization name
                          compareFn: (a, b) => a.code == b.code,
                          filterFn: (MedicalAgencyModel agency, String query) {
                            final lowerQuery = query.toLowerCase();
                            return agency.code.toLowerCase().contains(lowerQuery) ||
                                agency.organizationname.toLowerCase().contains(lowerQuery) ||
                                agency.fullAddress.toLowerCase().contains(lowerQuery);
                          },
                          decoratorProps: DropDownDecoratorProps(
                            decoration: InputDecoration(
                              labelText: "Select Medical Agency",
                              prefixIcon: Icon(Icons.account_balance_outlined,color: MyColors.primary,),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: MyColors.primary),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: MyColors.primary),
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            ref.read(enquiryController.notifier).selectMedicalAgency(value);
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          popupProps: PopupProps.menu(
                            showSearchBox: true, // Enables search
                            searchFieldProps: TextFieldProps(
                              decoration: InputDecoration(
                                hintText: "Search agency...",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: MyColors.primary),
                                ),
                              ),
                            ),
                            emptyBuilder: (context, searchEntry) => Center(child: Text('No available agency in this province.')),
                            itemBuilder: (context, item, isDisabled, isSelected) =>
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(item.organizationname,style: br1,),
                                      Text(item.fullAddress,style: br3,),
                                    ],
                                  ),
                                ),
                          ),
                          validator: (value) {
                            if(value == null){
                              return 'Please select a Medical Agency';
                            }
                            return null;
                          },
                        );
                      },
                      error: (error, stack) => Text('$error'),
                      loading: () => commonShimmer(height: 50, width: double.infinity),
                    ),
                    h10,
                    TextFormField(
                      controller: dateController,
                      readOnly: true,
                      onTap: () async {
                        DateTime? selectDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(Duration(days: 90)),
                            initialDate: DateTime.now(),
                        );

                        if(selectDate != null){
                          TimeOfDay? selectTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());

                          if(selectTime != null){
                            DateTime appointedDate = DateTime(selectDate.year, selectDate.month, selectDate.day, selectTime.hour, selectTime.minute);
                            dateController.text = DateFormat('yyyy-MM-dd HH:mm a').format(appointedDate);
                            ref.read(enquiryController.notifier).selectDate(appointedDate);
                          }
                        }

                      },
                      decoration: InputDecoration(
                        labelText: "Select Appointment date & time",
                        prefixIcon: Icon(Icons.watch_later_outlined,color: MyColors.primary,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: MyColors.primary),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: MyColors.primary),
                        ),
                      ),
                      validator: (value){
                        if(value == null || value.trim().isEmpty){
                          return 'Appointment date is required';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    h20,
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: MyColors.primary,
                                foregroundColor: MyColors.white
                              ),
                              onPressed: () async {
                                if(formKey.currentState!.validate()){
                                  final now = DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateTime.now().add(Duration(seconds: 50)));
                                  Map<String, dynamic> data = {
                                    "id": 0,
                                    "fullName": nameController.text.trim(),
                                    "contact": phoneController.text.trim(),
                                    "emailID": emailController.text.trim(),
                                    "appliedFor": selectedCountry['id'].toString(),
                                    "medicalAgency": selectedCode,
                                    "queries": remarksController.text.trim(),
                                    "passportNumber": passportController.text.trim(),
                                    "flag": "string",
                                    "entryDate": now,
                                    "appointmentDate": DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(selectedDate!),
                                    "extra1": "string"
                                  };
                                  await ref.read(enquiryNotifier.notifier).insertEnquiry(data: data).whenComplete(()=>Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Dashboard()), (route) => false,));

                                }
                              },
                              child: enquiryState.isLoading
                                  ? SpinKitDualRing(color: MyColors.white,size: 16,)
                                  : Text('Submit')
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: MyColors.red,
                                foregroundColor: MyColors.white
                              ),
                              onPressed: () {
                                ref.invalidate(enquiryController);
                              },
                              child: Text('Reset')
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
          ),
        ),
      ),
    );
  }
}
