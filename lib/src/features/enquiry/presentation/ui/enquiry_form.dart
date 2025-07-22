


import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:ministry/src/core/utils/page_route.dart';
import 'package:ministry/src/core/widgets/common_widgets.dart';
import 'package:ministry/src/features/enquiry/application/controller/enquiry_controller.dart';
import 'package:ministry/src/features/enquiry/presentation/ui/enquiry_payment_ui.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/gap_manager.dart';
import '../../../login/application/login_notifier.dart';
import '../../application/controller/enquiry_notifier.dart';

class EnquiryForm extends ConsumerWidget {
  // final int provinceId;
  const EnquiryForm({super.key});

  @override
  Widget build(BuildContext context, ref) {


    final passportController = ref.watch(enquiryController).passportController;
    final confirmPassportController = ref.watch(enquiryController).confirmPassportController;
    final formKey = ref.watch(enquiryController).formKey;
    final firstNameController = ref.watch(enquiryController).firstNameController;
    final lastNameController = ref.watch(enquiryController).lastNameController;
    final emailController = ref.watch(enquiryController).emailController;
    final phoneController = ref.watch(enquiryController).phoneController;
    final remarksController = ref.watch(enquiryController).remarksController;
    final dateController = ref.watch(enquiryController).dateController;
    final selectedDate = ref.watch(enquiryController).selectedDate;
    final selectedCountry = ref.watch(enquiryController).selectedCountryDynamic;
    final selectedSector = ref.watch(enquiryController).selectedSector;
    final authState = ref.watch(loginNotifierProvider);
    final formState = ref.watch(enquiryNotifier);
    // final countriesAsyncValue = ref.watch(countriesProvider);
    // final medicalAsyncValue = ref.watch(medicalAgenciesProvider(provinceId));
    // final districtAsyncValue = ref.watch(districtProvider(provinceId));
    // final selectedCode = ref.watch(enquiryController).selectedCode;
    // final selectedMedicalAgency = ref.watch(enquiryController).selectedMedical;

    return GestureDetector(
      onTap: ()=>FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: commonNavBar('Appointment Form'),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    h10,
                    if(authState.user == null)
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

                    if(authState.user != null)
                      TypeAheadField(

                        controller: passportController,

                        builder: (context, controller, focusNode) {
                          return TextFormField(
                            focusNode: focusNode,
                            controller: passportController,
                            textCapitalization: TextCapitalization.characters,
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
                          );
                        },
                        suggestionsCallback: (pattern) {
                          if(pattern.trim().isEmpty){
                            return [authState.user!.passportNo];
                          }
                          // You can fetch from an API or filter a list
                          return [authState.user!.passportNo]
                              .where((item) => item!.toLowerCase().startsWith(pattern.toLowerCase()))
                              .toList();
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            title: Text(suggestion!),
                          );
                        },
                        onSelected: (suggestion) {
                          passportController.text = suggestion!;
                          confirmPassportController.text = suggestion;
                          firstNameController.text = authState.user!.firstName;
                          lastNameController.text = authState.user!.lastName;
                          emailController.text = authState.user!.email;
                          phoneController.text = authState.user!.contact!;

                        },
                        emptyBuilder: (context) => SizedBox(),

                      ),

                    h10,
                    TextFormField(
                      controller: confirmPassportController,
                      textCapitalization: TextCapitalization.characters,
                      decoration: InputDecoration(
                        labelText: "Confirm Your Passport",
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
                          return 'Confirm your passport';
                        }
                        else if(passportController.text.trim().isNotEmpty && value.toLowerCase() != passportController.text.trim().toLowerCase()){
                          return 'Passport does not match';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,

                    ),
                    h10,
                    TextFormField(
                      controller: firstNameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: "First name",
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
                          return 'First Name is required.';
                        }
                        return null;
                      },
                    ),
                    h10,
                    TextFormField(
                      controller: lastNameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: "Last name",
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
                          return 'Last Name is required.';
                        }
                        return null;
                      },
                    ),
                    h10,
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "E-mail (Optional)",
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

                    ),
                    h10,
                    TextFormField(
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
                      // validator: (value) {
                      //   if(value == null || value.trim().isEmpty){
                      //     return 'Remarks is required.';
                      //   }
                      //   return null;
                      // },
                    ),
                    h10,
                    // medicalAsyncValue.when(
                    //   data: (medicalAgencies) {
                    //     return DropdownSearch<MedicalAgencyModel>(
                    //       items: (filter, loadProps) => medicalAgencies, // List of MedicalAgencyModel
                    //       selectedItem: selectedMedicalAgency,
                    //       itemAsString: (MedicalAgencyModel agency) => agency.organizationname, // Display organization name
                    //       compareFn: (a, b) => a.code == b.code,
                    //       filterFn: (MedicalAgencyModel agency, String query) {
                    //         final lowerQuery = query.toLowerCase();
                    //         return agency.code.toLowerCase().contains(lowerQuery) ||
                    //             agency.organizationname.toLowerCase().contains(lowerQuery) ||
                    //             agency.fullAddress.toLowerCase().contains(lowerQuery);
                    //       },
                    //       decoratorProps: DropDownDecoratorProps(
                    //         decoration: InputDecoration(
                    //           labelText: "Select Medical Agency",
                    //           prefixIcon: Icon(Icons.account_balance_outlined,color: MyColors.primary,),
                    //           border: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(12),
                    //             borderSide: BorderSide(color: MyColors.primary),
                    //           ),
                    //           enabledBorder: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(12),
                    //             borderSide: BorderSide(color: MyColors.primary),
                    //           ),
                    //         ),
                    //       ),
                    //       onChanged: (value) {
                    //         ref.read(enquiryController.notifier).selectMedicalAgency(value);
                    //         FocusManager.instance.primaryFocus?.unfocus();
                    //       },
                    //       popupProps: PopupProps.menu(
                    //         showSearchBox: true, // Enables search
                    //         searchFieldProps: TextFieldProps(
                    //           decoration: InputDecoration(
                    //             hintText: "Search agency...",
                    //             border: OutlineInputBorder(
                    //               borderRadius: BorderRadius.circular(12),
                    //               borderSide: BorderSide(color: MyColors.primary),
                    //             ),
                    //           ),
                    //         ),
                    //         emptyBuilder: (context, searchEntry) => Center(child: Text('No available agency in this province.')),
                    //         itemBuilder: (context, item, isDisabled, isSelected) =>
                    //             Padding(
                    //               padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16),
                    //               child: Column(
                    //                 crossAxisAlignment: CrossAxisAlignment.start,
                    //                 children: [
                    //                   Text(item.organizationname,style: br1,),
                    //                   Text(item.fullAddress,style: br3,),
                    //                 ],
                    //               ),
                    //             ),
                    //       ),
                    //       validator: (value) {
                    //         if(value == null){
                    //           return 'Please select a Medical Agency';
                    //         }
                    //         return null;
                    //       },
                    //     );
                    //   },
                    //   error: (error, stack) => Text('$error'),
                    //   loading: () => commonShimmer(height: 50, width: double.infinity),
                    // ),
                    ///divider
                    // districtAsyncValue.when(
                    //   data: (districts) {
                    //     return DropdownSearch<dynamic>(
                    //       items: (filter, loadProps) => districts, // List of MedicalAgencyModel
                    //       selectedItem: selectedDistrict,
                    //       itemAsString: (dynamic district) => district['districtName'], // Display organization name
                    //       compareFn: (a, b) => a.code == b.code,
                    //       filterFn: (dynamic district, String query) {
                    //         final lowerQuery = query.toLowerCase();
                    //         return district['districtName'].toLowerCase().contains(lowerQuery) ;
                    //       },
                    //       decoratorProps: DropDownDecoratorProps(
                    //         decoration: InputDecoration(
                    //           labelText: "Select District",
                    //           prefixIcon: Icon(Icons.account_balance_outlined,color: MyColors.primary,),
                    //           border: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(12),
                    //             borderSide: BorderSide(color: MyColors.primary),
                    //           ),
                    //           enabledBorder: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(12),
                    //             borderSide: BorderSide(color: MyColors.primary),
                    //           ),
                    //         ),
                    //       ),
                    //       onChanged: (value) {
                    //         ref.read(enquiryController.notifier).selectedDistrict(value);
                    //         FocusManager.instance.primaryFocus?.unfocus();
                    //       },
                    //       popupProps: PopupProps.menu(
                    //         showSearchBox: true, // Enables search
                    //         searchFieldProps: TextFieldProps(
                    //           decoration: InputDecoration(
                    //             hintText: "Search available districts...",
                    //             border: OutlineInputBorder(
                    //               borderRadius: BorderRadius.circular(12),
                    //               borderSide: BorderSide(color: MyColors.primary),
                    //             ),
                    //           ),
                    //         ),
                    //         emptyBuilder: (context, searchEntry) => Center(child: Text('No available district in this province.')),
                    //
                    //       ),
                    //       validator: (value) {
                    //         if(value == null){
                    //           return 'Please select a District';
                    //         }
                    //         return null;
                    //       },
                    //     );
                    //   },
                    //   error: (error, stack) => Text('$error'),
                    //   loading: () => commonShimmer(height: 50, width: double.infinity),
                    // ),
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
                          dateController.text = DateFormat('yyyy-MM-dd').format(selectDate);
                          ref.read(enquiryController.notifier).selectDate(selectDate);
                        }

                      },
                      decoration: InputDecoration(
                        labelText: "Select Appointment date",
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
                        try{
                          final now = DateTime.now();
                          final currentDate = DateTime(now.year,now.month,now.day);
                          final date = DateFormat('yyyy-MM-dd').parse(value);
                          final selectedDate = DateTime(date.year,date.month,date.day);
                          if(selectedDate.isBefore(currentDate)){
                            return 'Selected date or time is before current date or time';
                          }
                        }catch(e){
                          return 'Invalid date format';
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
                                    "id": "0",
                                    "FirstName": firstNameController.text.trim(),
                                    "LastName": lastNameController.text.trim(),
                                    "contact": phoneController.text.trim(),
                                    "emailID": emailController.text.trim().isEmpty ? '' : emailController.text.trim(),
                                    "appliedFor": '${selectedCountry['id']}',
                                    "medicalAgency": "",
                                    "queries": remarksController.text.trim().isEmpty ? '' : remarksController.text.trim(),
                                    "passportNumber": passportController.text.trim().toUpperCase(),
                                    "flag": "Insert",
                                    "entryDate": now,
                                    "appointmentDate": DateFormat('yyyy-MM-ddTHH:mm:ss').format(selectedDate!),
                                    "extra1": '${selectedSector['id']}'
                                  };
                                  final response = await ref.read(enquiryNotifier.notifier).insertEnquiry(data: data);
                                  if(response != null){
                                    final idCode = response.split(',');
                                    final id = idCode[0];
                                    final code = idCode[1];

                                    final date = DateFormat('yyyy-MM-dd').format(selectedDate);
                                    routeTo(context, EnquiryPaymentUI(data: data, date: date, code: code, paymentId: id,));
                                  }


                                }
                              },
                              child:  formState.isLoading ? SpinKitDualRing(color: MyColors.white, size: 16,) : Text('Proceed to payment')
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
