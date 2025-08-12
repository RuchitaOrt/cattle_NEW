
import 'package:cattle/Provider/filter_provider.dart';
import 'package:cattle/Utils/CattleStyles.dart';
import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/Utils/cattle_images.dart';
import 'package:cattle/Utils/cattle_strings.dart';
import 'package:cattle/Widget/CommonAppBar.dart';
import 'package:cattle/Widget/DatePicker.dart';
import 'package:cattle/Widget/custom_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatelessWidget {
  static const String route = '/filter_screen';
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FilterProvider(),
      child:  _FilterScreenBody(),
    );
  }
}

class _FilterScreenBody extends StatelessWidget {
   _FilterScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FilterProvider>();

    return Scaffold(
      backgroundColor: CattleColors.white,
      appBar:  CommonAppBar(title: CattleStrings.strFilter,onBack: ()
      {
Navigator.pop(context);
      },),
      body:
     
           Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 120,
                          decoration: BoxDecoration(
                            color: CattleColors.lightergrey,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListView.builder(
                            itemCount: provider.tabs.length,
                            itemBuilder: (context, index) => _buildTabItem(context, index),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16, top: 16, bottom: 16),
                          child: _buildRightPanel(context),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => provider.resetFilters(),
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            side: const BorderSide(color: CattleColors.orange, width: 0.4),
                          ),
                          child: const Text("Reset",
                              style: TextStyle(
                                  color: CattleColors.orange,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => provider.applyFilters(),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            backgroundColor: CattleColors.orange,
                          ),
                          child: const Text("Apply",
                              style: TextStyle(color: CattleColors.white,fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }

  Widget _buildTabItem(BuildContext context, int index) {
    final provider = context.read<FilterProvider>();
    final isSelected = index == provider.selectedTabIndex;
    final count = index == 0 ? 0 : provider.selectedOptions[provider.tabs[index]]!.length;

    return InkWell(
      onTap: () => provider.setTabIndex(index),
      child: Container(
        color: isSelected ? Colors.white : CattleColors.lightergrey,
        padding: const EdgeInsets.only(right: 24),
        child: Row(
          children: [
            Container(width: 4, height: 50, color: isSelected ? CattleColors.orange : Colors.transparent),
            const SizedBox(width: 8),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Text(provider.tabs[index],
                        style: TextStyle(
                          color: isSelected ? CattleColors.brownblack : CattleColors.secondaryGrey,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        )),
                  ),
                  if (count > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                      child: Text("$count",
                          style: TextStyle(
                              color: isSelected
                                  ? CattleColors.orange
                                  : CattleColors.blacklight,
                              fontSize: 10)),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

Widget _buildRightPanel(BuildContext context) {
  final provider = context.watch<FilterProvider>();
  final currentTab = provider.tabs[provider.selectedTabIndex];

  if (currentTab == "Date") {
        return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         
           CustomTextFieldWidget(
                    isMandatory: false,
                    title: CattleStrings.strFromDate,
                    hintText: CattleStrings.strFromDateHint,
                    onTapField: () {
                      showCattleDatePicker(
                          context: context,
                          controller: provider.fromController);
                    },
                    isFieldReadOnly: true,
                    onChange: (val) {},
                    textEditingController: provider.fromController,
                    autovalidateMode: AutovalidateMode.disabled,
                    suffixIcon: Icon(Icons.calendar_today,
                        size: 18, color: CattleColors.orange),
                  ),
                   CustomTextFieldWidget(
                     isMandatory: false,
                    title: CattleStrings.strToDate,
                    hintText: CattleStrings.strToDateHint,
                    onTapField: () {
                      showCattleDatePicker(
                          context: context,
                          controller: provider.toController);
                    },
                    isFieldReadOnly: true,
                    onChange: (val) {},
                    textEditingController: provider.toController,
                    autovalidateMode: AutovalidateMode.disabled,
                    suffixIcon: Icon(Icons.calendar_today,
                        size: 18, color: CattleColors.orange),
                  ),
          // const SizedBox(height: 16),
          // const Text("To"),
          // const SizedBox(height: 8),
          // _datePickerTile(context, provider.toDate, () => provider.pickDate(context, false)),
        ],
      );
  }

  final list = currentTab == "Village"
      ? provider.getFilteredVillageOptions()
      : provider.options[currentTab] ?? [];

  final selected = provider.selectedOptions[currentTab]!;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (currentTab == "Village")
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: TextField(
  controller: provider.villageSearchController,
  onChanged: provider.updateVillageSearch,
  decoration: InputDecoration(
    hintText: "Search",
    labelStyle: TextStyle(color: CattleColors.hintGrey,),
    hintStyle:  TextStyle(color: CattleColors.hintGrey,),
    prefixIcon: Icon(Icons.search, color: CattleColors.hintGrey),
    contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    filled: true,
    fillColor: CattleColors.white,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: CattleColors.hintGrey,width: 0.4), // 👈 default border
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: CattleColors.orange, width: 0.4), // 👈 on focus
    ),
  ),
),

        ),
      Expanded(
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            final item = list[index];
            final isSelected = selected.contains(item);
            return Column(
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: isSelected,
                      onChanged: (_) => provider.toggleOption(currentTab, item),
                      activeColor: CattleColors.orange,
                      checkColor: CattleColors.white,
                      side: const BorderSide(color: CattleColors.hintGrey),
                      visualDensity: const VisualDensity(horizontal: -4),
                    ),
                    Expanded(
                      child: Text(item,
                          style: const TextStyle(fontSize: 12, color: CattleColors.blacklight)),
                    ),
                    const Text('3', style: TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                ),
                const Divider(height: 1, thickness: 0.5, color: CattleColors.hintGrey),
              ],
            );
          },
        ),
      ),
    ],
  );
}

  // Widget _buildRightPanel(BuildContext context) {
  //   final provider = context.watch<FilterProvider>();
  //   final currentTab = provider.tabs[provider.selectedTabIndex];

  //   if (currentTab == "Date") {
  //     return Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         // const Text("From"),
  //         // const SizedBox(height: 8),
  //         // _datePickerTile(context, provider.fromDate, () 
  //         // {
  //         //      showCattleDatePicker(
  //         //                 context: context, controller: from,
  //         //                 );
  //         // }
  //         // // => provider.pickDate(context, true)
          
  //         // ),
  //          CustomTextFieldWidget(
  //                   isMandatory: false,
  //                   title: CattleStrings.strFromDate,
  //                   hintText: CattleStrings.strFromDateHint,
  //                   onTapField: () {
  //                     showCattleDatePicker(
  //                         context: context,
  //                         controller: fromController);
  //                   },
  //                   isFieldReadOnly: true,
  //                   onChange: (val) {},
  //                   textEditingController: fromController,
  //                   autovalidateMode: AutovalidateMode.disabled,
  //                   suffixIcon: Icon(Icons.calendar_today,
  //                       size: 18, color: CattleColors.orange),
  //                 ),
  //                  CustomTextFieldWidget(
  //                    isMandatory: false,
  //                   title: CattleStrings.strToDate,
  //                   hintText: CattleStrings.strToDateHint,
  //                   onTapField: () {
  //                     showCattleDatePicker(
  //                         context: context,
  //                         controller: toController);
  //                   },
  //                   isFieldReadOnly: true,
  //                   onChange: (val) {},
  //                   textEditingController: toController,
  //                   autovalidateMode: AutovalidateMode.disabled,
  //                   suffixIcon: Icon(Icons.calendar_today,
  //                       size: 18, color: CattleColors.orange),
  //                 ),
  //         // const SizedBox(height: 16),
  //         // const Text("To"),
  //         // const SizedBox(height: 8),
  //         // _datePickerTile(context, provider.toDate, () => provider.pickDate(context, false)),
  //       ],
  //     );
  //   }

  //   final list = provider.options[currentTab] ?? [];
  //   final selected = provider.selectedOptions[currentTab]!;

  //   return ListView.builder(
  //     itemCount: list.length,
  //     itemBuilder: (context, index) {
  //       final item = list[index];
  //       final isSelected = selected.contains(item);
  //       return Column(
  //         children: [
  //           Row(
  //             children: [
  //               Checkbox(
  //                 value: isSelected,
  //              onChanged: (_) => provider.toggleOption(currentTab, item),

  //                 activeColor: CattleColors.orange,
  //                 checkColor: CattleColors.white,
  //                 side: const BorderSide(color: CattleColors.hintGrey),
  //                 visualDensity: const VisualDensity(horizontal: -4),
  //               ),
  //               Expanded(
  //                 child: Text(item,
  //                     style:
  //                         const TextStyle(fontSize: 12, color: CattleColors.blacklight)),
  //               ),
  //               const Text('3', style: TextStyle(fontSize: 14, color: Colors.grey)),
  //             ],
  //           ),
  //           const Divider(height: 1, thickness: 0.5, color: CattleColors.hintGrey),
  //         ],
  //       );
  //     },
  //   );
  // }

  Widget _datePickerTile(BuildContext context, DateTime? date, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: CattleColors.hintGrey),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              date != null ? DateFormat('dd MMM yyyy').format(date) : "Select date",
              style: const TextStyle(color: Colors.black),
            ),
            const Icon(Icons.calendar_today, size: 18, color: CattleColors.orange),
          ],
        ),
      ),
    );
  }
}
