import 'package:flutter/material.dart';
import 'package:simsar/Models/filter_model.dart';
import 'package:simsar/Theme/app_colors.dart';

void showFilterSheet(BuildContext context, PropertyFilter currentFilter, Function(PropertyFilter) onApply) {
  PropertyFilter tempFilter = currentFilter.copy();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setModalState) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: SAppColors.background, borderRadius: BorderRadius.circular(10)))),
                const Center(child: Text("Filter", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: SAppColors.secondaryDarkBlue))),
           
                const Text("Location", style: TextStyle(fontWeight: FontWeight.bold ,color: SAppColors.textGray)),

                DropdownButton<String>(
                  value: tempFilter.location,
                  hint: const Text("Select Location"),
                  isExpanded: true,
                  items: ["Damascus", "Aleppo", "Homs"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: (val) => setModalState(() => tempFilter.location = val),
                ),

                const SizedBox(height: 20),
                const Text("Property Type", style: TextStyle(fontWeight: FontWeight.bold ,color: SAppColors.textGray)),
                ...["Apartment", "Penthouse", "Hotel", "Villa"].map((type) => CheckboxListTile(
                  title: Text(type),
                  value: tempFilter.propertyTypes.contains(type),
                  onChanged: (val) {
                    setModalState(() {
                      val! ? tempFilter.propertyTypes.add(type) : tempFilter.propertyTypes.remove(type);
                    });
                  },
                )),

                const Text("Price Range", style: TextStyle(fontWeight: FontWeight.bold ,color: SAppColors.textGray)),
                RangeSlider(
                  values: RangeValues(tempFilter.minPrice, tempFilter.maxPrice),
                  min: 10,
                  max: 1000,
                  divisions: 20,
                  // Rounding prevents long decimal strings in the tooltip
                  labels: RangeLabels(
                    "\$${tempFilter.minPrice.round()}", 
                    "\$${tempFilter.maxPrice.round()}",
                  ),
                  onChanged: (values) {
                    setModalState(() {
                      tempFilter.minPrice = values.start;
                      tempFilter.maxPrice = values.end;
                    });
                  },
                ),

                Row(
                  children: [
                    // Inverted "Reset" Button
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          setModalState(() {
                            tempFilter = PropertyFilter(); // Reset to defaults
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(0, 52),
                          side: const BorderSide(color: SAppColors.secondaryDarkBlue, width: 1.5),
                          foregroundColor: SAppColors.secondaryDarkBlue,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text("Reset", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // "Apply" Button
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          onApply(tempFilter);
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: SAppColors.secondaryDarkBlue,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(0, 52),
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text("Apply", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  );
}