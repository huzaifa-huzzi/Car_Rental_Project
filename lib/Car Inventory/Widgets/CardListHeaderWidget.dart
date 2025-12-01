import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Car Inventory/Widgets/ButtonWidget.dart';

class CardListHeaderWidget extends StatelessWidget {
  final VoidCallback? onSearch;
  final VoidCallback? onFilter;
  final VoidCallback? onListView;
  final VoidCallback? onGridView;
  final VoidCallback? onAddCar;

  const CardListHeaderWidget({
    super.key,
    this.onSearch,
    this.onFilter,
    this.onListView,
    this.onGridView,
    this.onAddCar,
  });

  @override
  Widget build(BuildContext context) {
    bool isMobile = AppSizes.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.horizontalPadding(context),
        vertical: AppSizes.verticalPadding(context),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          /// ------------ LEFT SECTION ------------
          Row(
            children: [
              /// Search Bar
              Container(
                width: isMobile ? 180 : 300,
                height: 45,
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.padding(context),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    AppSizes.borderRadius(context),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, size: 18, color: Colors.grey),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search client name, car, etc",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(width: AppSizes.padding(context)),

              /// Filter Button
              _headerButton(
                context: context,
                icon: IconString.filterIcon,
                text: "Filter",
                onTap: onFilter,
              ),
            ],
          ),

          /// ------------ RIGHT SECTION ------------
          Row(
            children: [
              _circleIconButton(
                context: context,
                iconPath: IconString.previewOne,
                onTap: onListView,
              ),
              SizedBox(width: AppSizes.padding(context) / 2),

              _circleIconButton(
                context: context,
                iconPath: IconString.previewTwo,
                onTap: onGridView,
              ),
              SizedBox(width: AppSizes.padding(context)),

              /// Add Car Button (ONLY Web/Tablets)
              if (!isMobile)
                AddButton(
                  text: "Add Car",
                  height: 45,
                  width: 120,
                  onTap: (){},
                ),
            ],
          ),
        ],
      ),
    );
  }

  /// -------- FILTER BUTTON --------
  Widget _headerButton({
    required BuildContext context,
    required String icon,
    required String text,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.padding(context),
          vertical: AppSizes.padding(context) * 0.6,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            AppSizes.borderRadius(context),
          ),
        ),
        child: Row(
          children: [
            Image.asset(icon, width: 14, height: 14,color: AppColors.secondTextColor,),
            const SizedBox(width: 6),
            Text(text,style: TTextTheme.smallX(context),),
            const Icon(Icons.keyboard_arrow_down, size: 16),
          ],
        ),
      ),
    );
  }

  /// ---------- SMALL ICON BUTTON (LIST / GRID) ----------
  Widget _circleIconButton({
    required BuildContext context,
    required String iconPath,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.textColor,
          borderRadius: BorderRadius.circular(
            AppSizes.borderRadius(context),
          ),
        ),
        child: Center(
          child: Image.asset(iconPath, width: 18, height: 18, color: Colors.white),
        ),
      ),
    );
  }
}
