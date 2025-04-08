import 'package:cleaning_service/models/categories_service.dart';
import 'package:cleaning_service/screens/service_details/all_service_list_screen.dart';
import 'package:flutter/material.dart';

void showServicesOptions(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    useSafeArea: true,
    isScrollControlled: true,
    builder: (_) {
      return _ServiceOptionScreen(
        onDismiss: () {
          Navigator.of(_).pop();
        },
      );
    },
  );
}

class _ServiceOptionScreen extends StatelessWidget {
  final VoidCallback? onDismiss;
  _ServiceOptionScreen({required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 10.0, bottom: 10.0),
          child: IconButton(
            onPressed: onDismiss,
            style: IconButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            icon: Icon(
              Icons.close_rounded,
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(screenWidth * 0.05),
            topRight: Radius.circular(screenWidth * 0.05),
          ),
          child: Container(
            color: Colors.white,
            width: screenWidth,
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: CategoriesServiceModel.globalCategories[0].subCategory.length,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: screenWidth * 0.05,
                  mainAxisSpacing: screenWidth * 0.05,
                ),
                itemBuilder: (BuildContext context, int index) {
                  var categories = CategoriesServiceModel.globalCategories[0].subCategory;
                  return _buildService(onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AllServicesListScreen(category: categories[index],)));
                  }, context,categories[index].subCategoryName,
                      'assets/icons/electrician-service.webp');
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildService(BuildContext context, String title, String imageUrl,
      {VoidCallback? onTap}) {
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(screenWidth * 0.04),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              imageUrl,
              height: screenWidth * 0.1,
              width: screenWidth * 0.1,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: screenWidth * 0.01),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: screenWidth * 0.038,
                height: 1,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
