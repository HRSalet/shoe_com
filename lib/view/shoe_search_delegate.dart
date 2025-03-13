// import 'package:flutter/material.dart';
//
// import '../../../../data/dummy_data.dart';
// import '../../../../models/shoe_model.dart';
// import '../../../view/detail/detail_screen.dart';
//
// class ShoeSearchDelegate extends SearchDelegate<ShoeModel?> {
//   // Combine all shoe lists into one
//   final List<ShoeModel> allShoes = [
//     ...nikeShoes,
//     ...adidasShoes,
//     ...bataShoes,
//     ...pumaShoes,
//     ...CampusShoes,
//     ...woodlandShoes,
//     ...reebokShoes,
//   ];
//
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           query = ''; // Clear the search query
//         },
//       ),
//     ];
//   }
//
//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//       icon: Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, null); // Close the search
//       },
//     );
//   }
//
//   @override
//   Widget buildResults(BuildContext context) {
//     List<ShoeModel> results =
//         allShoes
//             .where(
//               (shoe) =>
//                   shoe.name.toLowerCase().contains(query.toLowerCase()) ||
//                   shoe.model.toLowerCase().contains(query.toLowerCase()),
//             )
//             .toList();
//
//     if (results.isEmpty) {
//       return Center(child: Text("No results found"));
//     }
//
//     return ListView.builder(
//       itemCount: results.length,
//       itemBuilder: (context, index) {
//         ShoeModel shoe = results[index];
//         return ListTile(
//           title: Text(shoe.name),
//           subtitle: Text(shoe.model),
//           leading: Image.asset(shoe.imgAddress, width: 50, height: 50),
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder:
//                     (ctx) =>
//                         DetailScreen(model: shoe, isComeFromMoreSection: false),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return buildResults(context); // Show filtered list as suggestions
//   }
// }

import 'package:flutter/material.dart';

import '../../../../data/dummy_data.dart';
import '../../../../models/shoe_model.dart';
import '../../../view/detail/detail_screen.dart';

class ShoeSearchDelegate extends SearchDelegate<ShoeModel?> {
  // Combine all shoe lists into one
  final List<ShoeModel> allShoes = [
    ...nikeShoes,
    ...adidasShoes,
    ...bataShoes,
    ...pumaShoes,
    ...CampusShoes,
    ...woodlandShoes,
    ...reebokShoes,
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = ''; // Clear the search query
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // Close the search
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<ShoeModel> results =
        allShoes
            .where(
              (shoe) =>
                  shoe.name.toLowerCase().contains(query.toLowerCase()) ||
                  shoe.model.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();

    if (results.isEmpty) {
      return Center(child: Text("No results found"));
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        ShoeModel shoe = results[index];
        return ListTile(
          title: Text(shoe.name),
          subtitle: Text(shoe.model),
          leading: Image.asset(shoe.imgAddress, width: 50, height: 50),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (ctx) =>
                        DetailScreen(model: shoe, isComeFromMoreSection: false),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Center(child: Text("Type to search for shoes..."));
    }
    return buildResults(context);
  }
}
