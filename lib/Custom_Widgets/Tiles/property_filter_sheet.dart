import 'package:flutter/material.dart';
import 'package:simsar/Models/filter_model.dart';
import 'package:simsar/Theme/app_colors.dart';
import 'package:simsar/Models/property_enums.dart';

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
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: SAppColors.background,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    "Filter",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: SAppColors.secondaryDarkBlue,
                    ),
                  ),
                ),

                const Text(
                  "Province",
                  style: TextStyle(fontWeight: FontWeight.bold, color: SAppColors.textGray),
                ),
                DropdownButton<Province>(
                  value: tempFilter.province,
                  hint: const Text("Select Province"),
                  isExpanded: true,
                  items: Province.values.map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e.displayName),
                  )).toList(),
                  onChanged: (val) {
                    setModalState(() {
                      tempFilter.province = val;
                      tempFilter.city = null; // Selection logic: reset city when province changes
                    });
                  },
                ),

                const SizedBox(height: 20),

                const Text(
                  "City",
                  style: TextStyle(fontWeight: FontWeight.bold, color: SAppColors.textGray),
                ),
                DropdownButton<City>(
                  value: tempFilter.city,
                  hint: Text(tempFilter.province == null ? "Select a province first" : "Select City"),
                  isExpanded: true,
                  items: City.getByProvince(tempFilter.province).map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e.displayName),
                  )).toList(),
                  onChanged: tempFilter.province == null
                      ? null
                      : (val) => setModalState(() => tempFilter.city = val),
                ),

                const Text(
                  "Property Type",
                  style: TextStyle(fontWeight: FontWeight.bold, color: SAppColors.textGray),
                ),
                ...PropertyType.values.map((type) => CheckboxListTile(
                      title: Text(type.displayName),
                      value: tempFilter.propertyTypes.contains(type),
                      onChanged: (val) {
                        setModalState(() {
                          val! ? tempFilter.propertyTypes.add(type) : tempFilter.propertyTypes.remove(type);
                        });
                      },
                    )),

                const Text(
                  "Price Range",
                  style: TextStyle(fontWeight: FontWeight.bold, color: SAppColors.textGray),
                ),
                RangeSlider(
                  values: RangeValues(tempFilter.minPrice, tempFilter.maxPrice),
                  min: 10,
                  max: 1000,
                  divisions: 20,
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
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          setModalState(() {
                            tempFilter = PropertyFilter();
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