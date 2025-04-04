



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:ministry/src/core/utils/shimmers.dart';
import 'package:ministry/src/core/widgets/common_widgets.dart';
import 'package:ministry/src/features/enquiry/application/controller/enquiry_controller.dart';
import 'package:ministry/src/features/enquiry/application/controller/enquiry_notifier.dart';
import 'package:ministry/src/features/enquiry/application/providers/enquiry_provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/gap_manager.dart';
import '../../domain/model/medical_agency_model.dart';

class EnquiryForm extends ConsumerWidget {
  const EnquiryForm({super.key});

  @override
  Widget build(BuildContext context, ref) {


    final enquiryState = ref.watch(enquiryNotifier);
    final countriesAsyncValue = ref.watch(countriesProvider);
    final medicalAsyncValue = ref.watch(medicalAgenciesProvider);
    final formKey = ref.watch(enquiryController).formKey;
    final nameController = ref.watch(enquiryController).nameController;
    final emailController = ref.watch(enquiryController).emailController;
    final phoneController = ref.watch(enquiryController).phoneController;
    final remarksController = ref.watch(enquiryController).remarksController;
    final selectedCountry = ref.watch(enquiryController).selectedCountry;
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
                    countriesAsyncValue.when(
                        data: (countries){
                          return DropdownSearch<String>(
                            items: (filter, loadProps) => countries, // List of countries as <String>
                            selectedItem: selectedCountry,
                            decoratorProps: DropDownDecoratorProps(
                              decoration: InputDecoration(
                                labelText: "Apply for",
                                prefixIcon: Icon(Icons.pin_drop,color: MyColors.primary,),
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
                              ref.read(enquiryController.notifier).selectCountry(value);
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            popupProps: PopupProps.menu(
                              showSearchBox: true, // Enables the search feature
                              searchFieldProps: TextFieldProps(
                                decoration: InputDecoration(
                                  hintText: "Search country...",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: MyColors.primary),
                                  ),
                                ),
                              ),
                            ),
                            validator: (value) {
                              if(value == null){
                                return 'Please select a country you apply for';
                              }
                              return null;
                            },
                          );
                        },
                        error: (error,stack)=>h10,
                        loading: ()=>commonShimmer(height: 50, width: double.infinity)
                    ),
                    h10,
                    medicalAsyncValue.when(
                      data: (medicalAgencies) {
                        return DropdownSearch<MedicalAgencyModel>(
                          items: (filter, loadProps) => medicalAgencies, // List of MedicalAgencyModel
                          selectedItem: selectedMedicalAgency,
                          itemAsString: (MedicalAgencyModel agency) => agency.organizationName, // Display organization name
                          compareFn: (a, b) => a.code == b.code,
                          filterFn: (MedicalAgencyModel agency, String query) {
                            final lowerQuery = query.toLowerCase();
                            return agency.code.toLowerCase().contains(lowerQuery) ||
                                agency.organizationName.toLowerCase().contains(lowerQuery) ||
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
                            itemBuilder: (context, item, isDisabled, isSelected) =>
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(item.organizationName,style: br1,),
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
                                  final now = DateFormat('yyyy-MM-ddThh:mm:ss').format(DateTime.now());
                                  Map<String, dynamic> data = {
                                    "id": 0,
                                    "fullName": nameController.text.trim(),
                                    "contact": phoneController.text.trim(),
                                    "emailID": emailController.text.trim(),
                                    "appliedFor": selectedCountry,
                                    "medicalAgency": selectedCode,
                                    "queries": remarksController.text.trim(),
                                    "flag": "string",
                                    "entryDate": now
                                  };
                                  await ref.read(enquiryNotifier.notifier).insertEnquiry(data: data);

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
