




import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/core/resources/color_manager.dart';
import 'package:ministry/src/core/utils/shimmers.dart';
import 'package:ministry/src/core/widgets/common_widgets.dart';
import 'package:ministry/src/features/enquiry/application/controller/enquiry_controller.dart';
import 'package:ministry/src/features/enquiry/application/providers/enquiry_provider.dart';
import 'package:ministry/src/features/enquiry/presentation/ui/enquiry_form.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/gap_manager.dart';
import '../../../../core/utils/page_route.dart';

class CountryPicker extends ConsumerWidget {
  const CountryPicker({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final selectedCountry = ref.watch(enquiryController).selectedCountryDynamic;
    final selectedProvince = ref.watch(enquiryController).selectedProvince;
    final selectedSector = ref.watch(enquiryController).selectedSector;
    final countriesAsyncValue = ref.watch(availableCountriesProvider);
    final provincesAsyncValue = ref.watch(provinceProvider);
    final sectorAsyncValue = ref.watch(sectorProvider);
    final districtAsyncValue = ref.watch(districtProvider(selectedProvince == null ? null : selectedProvince['id']));
    final selectedDistrict = ref.watch(enquiryController).selectedDistrict;

    return Scaffold(
      appBar: commonNavBar('Appointment Form'),
      body: FadeIn(
        duration: Duration(seconds: 1),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Apply for :',style: bh1,),
                h20,

                countriesAsyncValue.when(
                    data: (countries) {
                      return DropdownSearch<Map<String, dynamic>>(
                        items: (filter, loadProps) => countries.map((e)=>e as Map<String, dynamic>).toList(), // List of countries as <String>
                        selectedItem: selectedCountry,
                        compareFn: (a, b) => a['id'] == b['id'],
                        itemAsString: (item) => item['value'],
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
                          ref.read(enquiryController.notifier).selectAvailableCountry(value);
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
                          constraints: BoxConstraints(
                            maxHeight: 200
                          )
                        ),
                        validator: (value) {
                          if(value == null){
                            return 'Please select a country you apply for';
                          }
                          return null;
                        },
                      );
                    },
                    error: (error, stack)=> Center(child: Text('$error')),
                    loading: ()=>commonShimmer(width: double.infinity,height: 50)
                ),
                h20,
                sectorAsyncValue.when(
                    data: (sectors){
                      return DropdownSearch<Map<String, dynamic>>(
                        items: (filter, loadProps) => sectors.map((e)=>e as Map<String, dynamic>).toList(), // List of provinces as <String>
                        selectedItem: selectedSector,
                        compareFn: (a, b) => a['id'] == b['id'],
                        itemAsString: (item) => item['value'],
                        decoratorProps: DropDownDecoratorProps(
                          decoration: InputDecoration(
                            labelText: "Select a Sector",
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
                          ref.read(enquiryController.notifier).selectSector(value);
                        },
                        popupProps: PopupProps.menu(
                            showSearchBox: true, // Enables the search feature
                            searchFieldProps: TextFieldProps(
                              decoration: InputDecoration(
                                hintText: "Search province...",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: MyColors.primary),
                                ),
                              ),
                            ),
                            constraints: BoxConstraints(
                                maxHeight: 250
                            )
                        ),
                        validator: (value) {
                          if(value == null){
                            return 'Please select a sector';
                          }
                          return null;
                        },
                      );
                    },
                    error: (error, stack)=> Center(child: Text('$error')),
                    loading: ()=>commonShimmer(width: double.infinity,height: 50)
                ),
                // h20,
                // provincesAsyncValue.when(
                //     data: (provinces){
                //       return DropdownSearch<Map<String, dynamic>>(
                //         items: (filter, loadProps) => provinces.map((e)=>e as Map<String, dynamic>).toList(), // List of provinces as <String>
                //         selectedItem: selectedProvince,
                //         compareFn: (a, b) => a['id'] == b['id'],
                //         itemAsString: (item) => item['value'],
                //         decoratorProps: DropDownDecoratorProps(
                //           decoration: InputDecoration(
                //             labelText: "Select a province",
                //             prefixIcon: Icon(Icons.pin_drop,color: MyColors.primary,),
                //             border: OutlineInputBorder(
                //               borderRadius: BorderRadius.circular(12),
                //               borderSide: BorderSide(color: MyColors.primary),
                //             ),
                //             enabledBorder: OutlineInputBorder(
                //               borderRadius: BorderRadius.circular(12),
                //               borderSide: BorderSide(color: MyColors.primary),
                //             ),
                //           ),
                //         ),
                //         onChanged: (value) {
                //           ref.read(enquiryController.notifier).selectProvince(value);
                //         },
                //         popupProps: PopupProps.menu(
                //             showSearchBox: true, // Enables the search feature
                //             searchFieldProps: TextFieldProps(
                //               decoration: InputDecoration(
                //                 hintText: "Search province...",
                //                 border: OutlineInputBorder(
                //                   borderRadius: BorderRadius.circular(12),
                //                   borderSide: BorderSide(color: MyColors.primary),
                //                 ),
                //               ),
                //             ),
                //             constraints: BoxConstraints(
                //                 maxHeight: 250
                //             )
                //         ),
                //         validator: (value) {
                //           if(value == null){
                //             return 'Please select a province';
                //           }
                //           return null;
                //         },
                //       );
                //     },
                //     error: (error, stack)=> Center(child: Text('$error')),
                //     loading: ()=>commonShimmer(width: double.infinity,height: 50)
                // ),
                // h20,
                // districtAsyncValue.when(
                //   data: (districts) {
                //     return DropdownSearch<Map<String, dynamic>>(
                //       items: (filter, loadProps) => districts.isEmpty ? [] : districts.map((e) => e as Map<String, dynamic>).toList() , // List of provinces as <String>
                //       selectedItem: selectedProvince,
                //       compareFn: (a, b) => a['districtId'] == b['districtId'],
                //       filterFn: (district, String query) {
                //         final lowerQuery = query.toLowerCase();
                //         final name = district['districtName'];
                //         if (name == null) return false;
                //         return name.toLowerCase().contains(lowerQuery);
                //       },
                //
                //       itemAsString: (item) => item['districtName'] ?? 'N/A',
                //
                //       decoratorProps: DropDownDecoratorProps(
                //         decoration: InputDecoration(
                //           labelText: "Select a district",
                //           prefixIcon: Icon(Icons.pin_drop,color: MyColors.primary,),
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
                //         ref.read(enquiryController.notifier).selectDistrict(value);
                //       },
                //       popupProps: PopupProps.menu(
                //           showSearchBox: true, // Enables the search feature
                //           searchFieldProps: TextFieldProps(
                //             decoration: InputDecoration(
                //               hintText: "Search district...",
                //               border: OutlineInputBorder(
                //                 borderRadius: BorderRadius.circular(12),
                //                 borderSide: BorderSide(color: MyColors.primary),
                //               ),
                //             ),
                //           ),
                //           constraints: BoxConstraints(
                //               maxHeight: 250
                //           ),
                //         emptyBuilder: (context, searchEntry) => Center(child: Text('No available district in this province.')),
                //       ),
                //       validator: (value) {
                //         if(value == null){
                //           return 'Please select a district';
                //         }
                //         return null;
                //       },
                //     );
                //   },
                //   error: (error, stack) => Text('$error'),
                //   loading: () => commonShimmer(height: 50, width: double.infinity),
                // ),
                h20,
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: MyColors.primary,
                            foregroundColor: MyColors.white,
                            disabledBackgroundColor: MyColors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)
                            )
                          ),
                          onPressed: (selectedCountry == null || selectedSector == null) ? null : ()=>routeTo(context, EnquiryForm()), child: Text('Next')
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
