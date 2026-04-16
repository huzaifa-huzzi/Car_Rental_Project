import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart' show TTextTheme;
import 'package:flutter/material.dart';


class CompaniesDetailScreenWidget extends StatelessWidget {
  const CompaniesDetailScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 800;

    return Column(
      children: [
        _buildSectionCard(
          context,
          title: TextString.detailTitle1,
          subtitle: TextString.detailSubtitle1,
          child: LayoutBuilder(
            builder: (context, constraints) {
              double screenWidth = MediaQuery.of(context).size.width;
              int columns = screenWidth > 1200 ? 4 : (screenWidth > 800 ? 2 : 1);
              double ratio = screenWidth > 1200 ? 2.7 : (screenWidth > 800 ? 3.2 : 4.0);


              if (screenWidth > 1200) {
                columns = 4;
                ratio = 2.5;
              } else if (screenWidth > 800) {
                columns = 3;
                ratio = 2.1;
              } else if (screenWidth > 500) {
                columns = 2;
                ratio = 2.1;
              } else {
                columns = 1;
                ratio = 2.6;
              }

              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: columns,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: ratio,
                children: [
                  _buildStatCard(context,TextString.detailTable1 , "35", IconString.carInventoryIcon),
                  _buildStatCard(context,TextString.detailTable2 , "22", IconString.carInventoryIcon),
                  _buildStatCard(context,TextString.detailTable3, "6", IconString.underMaintenanceIcon),
                  _buildStatCard(context,TextString.detailTable4 , "43", IconString.staffIcon),
                  _buildStatCard(context, TextString.detailTable5, "35", IconString.staffIcon),
                  _buildStatCard(context,TextString.detailTable6 , "22", IconString.agreementIcon),
                  _buildStatCard(context, TextString.detailTable7, "6", IconString.returnCarIcon),
                  _buildStatCard(context,TextString.detailTable8 , "15", IconString.staffIcon),
                ],
              );
            },
          ),
        ),

        const SizedBox(height: 25),
        _buildSectionCard(
          context,
          title: TextString.detailTitle2,
          subtitle: TextString.detailSubtitle2,
          child: Column(
            children: [
              _buildResponsiveRow(isMobile, [
                _buildReadOnlyLogoField(context, TextString.companyLogo),
                _buildReadOnlyField(context, TextString.AddcompanyName, "Soft Snip"),
                _buildReadOnlyField(context, TextString.AddAccountStatus, "Active"),
              ]),
              const SizedBox(height: 20),
              _buildResponsiveRow(isMobile, [
                _buildReadOnlyField(context, TextString.AddPhoneNumber, "1234567-8"),
                _buildReadOnlyField(context, TextString.addcompanyEmailAdress, "aussie@gmail.com"),
                _buildReadOnlyField(context, TextString.emailStatus, "Verified"),
              ]),
              const SizedBox(height: 20),
              _buildResponsiveRow(isMobile, [
                _buildReadOnlyField(context, TextString.addcompanyAdress, "123 Hay Street"),
                _buildReadOnlyField(context, TextString.addcompanyTaxNo, "TAX-SA-98712"),
                _buildReadOnlyField(context, TextString.joiningDate, "4/03/2026"),
              ]),
            ],
          ),
        ),

        const SizedBox(height: 25),

        _buildSectionCard(
          context,
          title: TextString.detailTitle3,
          subtitle:TextString.detailSubtitle3,
          child: Column(
            children: [
              _buildResponsiveRow(isMobile, [
                _buildReadOnlyField(context, TextString.faceBook, "https://facebook.com", icon: IconString.facebookAdminIcon),
                _buildReadOnlyField(context, TextString.twitter, "https://twitter.com", icon: IconString.xAdminIcon),
                _buildReadOnlyField(context, TextString.instgram, "https://instagram.com", icon: IconString.instaAdminIcon),
              ]),
              const SizedBox(height: 20),
              _buildResponsiveRow(isMobile, [
                _buildReadOnlyField(context, TextString.linkedIn, "https://linkedin.com", icon: IconString.linkedinAdminIcon),
                _buildReadOnlyField(context, TextString.youtube, "https://youtube.com", icon: IconString.youtubeAdminIcon),
                const SizedBox(),
              ]),
            ],
          ),
        ),

        const SizedBox(height: 25),

        _buildSectionCard(
          context,
          title: TextString.detailTitle4,
          subtitle: TextString.detailSubtitle4,
          child: Column(
            children: [
              _buildResponsiveRow(isMobile, [
                _buildReadOnlyField(context, TextString.plan, "Monthly"),
                _buildReadOnlyField(context, TextString.startingDate, "4/03/2026"),
                _buildReadOnlyField(context, TextString.endingDate, "4/03/2027"),
              ]),
              const SizedBox(height: 20),
              _buildResponsiveRow(isMobile, [
                _buildStatusField(context,TextString.paymentStaus, "Subscribed"),
                _buildReadOnlyField(context, TextString.remaniningDays, "365 Days"),
                _buildReadOnlyField(context, TextString.Limit, "Fleet usage 35/50"),
              ]),
            ],
          ),
        ),
      ],
    );
  }

  /// ----------- Extra Widget
  // Responsive Rows
  Widget _buildResponsiveRow(bool isMobile, List<Widget> children) {
    if (isMobile) {
      return Column(
        children: children.map((c) => Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: c,
        )).toList(),
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children.map((c) => Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: c,
        ),
      )).toList(),
    );
  }

   // Logo Field
  Widget _buildReadOnlyLogoField(BuildContext context, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TTextTheme.tableRegular14black(context)),
        const SizedBox(height: 8),
        SizedBox(
          height: 55,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Image.asset(
              ImageString.plushlogoAdmin,
              height: 40,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }

  // standard Field
  Widget _buildReadOnlyField(BuildContext context, String label, String value, {String? icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TTextTheme.tableRegular14black(context)),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.toolBackground),
          ),
          child: Row(
            children: [
              if (icon != null) ...[
                Image.asset(icon, width: 20, height: 20),
                const SizedBox(width: 10),
              ],
              Expanded(
                child: Text(
                  value,
                  style: TTextTheme.titleinputTextField(context),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Status Field
  Widget _buildStatusField(BuildContext context, String label, String status) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TTextTheme.tableRegular14black(context)),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.toolBackground),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.completedColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                status,
                style: TTextTheme.tableSemiBold14(context),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Section Card
  Widget _buildSectionCard(BuildContext context, {required String title, required String subtitle, required Widget child}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.toolBackground),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TTextTheme.h2Style(context)),
            Text(subtitle, style: TTextTheme.bodyRegular16(context)),
            const SizedBox(height: 24),
            child,
          ],
        ),
      ),
    );
  }

  // Stats Card
  Widget _buildStatCard(BuildContext context, String title, String value, String assetPath) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.toolBackground),
      ),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(8)
            ),
            child: Center(child: Image.asset(assetPath, width: 20,color: AppColors.blackColor,)),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    title,
                    style: TTextTheme.bodyRegular12(context),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis
                ),
                const SizedBox(height: 2),

                FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                        value,
                        style: TTextTheme.h2Style(context)
                    )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}