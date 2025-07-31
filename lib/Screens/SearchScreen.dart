import 'package:cattle/Provider/SearchProvider.dart';
import 'package:cattle/Screens/VertaicalLeadCard.dart';
import 'package:cattle/Utils/CattleStyles.dart';
import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/Utils/cattle_images.dart';
import 'package:cattle/Utils/cattle_strings.dart';
import 'package:cattle/Widget/CommonAppBar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';


class SearchScreen extends StatelessWidget {
  static const route = '/search_screen';
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchProvider(),
      child: const _SearchScreenBody(),
    );
  }
}

class _SearchScreenBody extends StatelessWidget {
  
  const _SearchScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const CommonAppBar(title: CattleStrings.strSearch),
      backgroundColor: CattleColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: TextField(
                controller: provider.searchController,
                onChanged: provider.performSearch,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: "Search by farmer name",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(CattleImagePath.searchgrey),
                  ),
                  suffixIcon: provider.searchController.text.isNotEmpty
                      ? GestureDetector(
                          onTap: provider.clearSearch,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SvgPicture.asset(CattleImagePath.closeorange),
                          ),
                        )
                      : null,
                  filled: true,
                  fillColor: CattleColors.lightergrey,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: CattleColors.hintGrey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: CattleColors.orange),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            if (provider.showResults && provider.searchResults.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Results", style: CattleStyles.neutral90w30014),
                    Text("${provider.searchResults.length} results", style: CattleStyles.neutral90w30014),
                  ],
                ),
              ),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child:  provider.selectedName != null
    ? _buildSelectedResultWidget(provider)
    : provider.showResults
        ? _buildSearchResults(provider)
        : _buildRecentSearchList(provider),

              ),
            ),
          ],
        ),
      ),
    );
  }
Widget _buildSelectedResultWidget(SearchProvider provider) {
  // Simulate lead data filtering (replace with real leadList logic)
 

    // if (provider.selectedName != null) {
      final filteredLeads = provider.yourLeadsListing.where((lead) => lead.name.toLowerCase() == provider.selectedName!.toLowerCase()).toList();
     if (provider.selectedName != null) {
      return Expanded(child:
      filteredLeads.length==0? Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(CattleImagePath.nosearch),
              const SizedBox(height: 16),
              Text(CattleStrings.strNoSearchHeading, style: CattleStyles.blacklightw60014),
              const SizedBox(height: 8),
              Text(CattleStrings.strNoSearchSubHeading, textAlign: TextAlign.center, style: CattleStyles.subHeading),
            ],
          ),
        ),
      ): LeadCardSlider(leadList: filteredLeads, caseType: "New"));
     }
     return Container();
   // }
}

  Widget _buildSearchResults(SearchProvider provider) {
    if (provider.searchResults.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(CattleImagePath.nosearch),
              const SizedBox(height: 16),
              Text(CattleStrings.strNoSearchHeading, style: CattleStyles.blacklightw60014),
              const SizedBox(height: 8),
              Text(CattleStrings.strNoSearchSubHeading, textAlign: TextAlign.center, style: CattleStyles.subHeading),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: provider.searchResults.length,
      itemBuilder: (context, index) {
        final name = provider.searchResults[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => provider.selectResult(name),
                child: Text(name, style: const TextStyle(fontSize: 16)),
              ),
              const Divider(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRecentSearchList(SearchProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "Recent", style: CattleStyles.neutral90w30014),
                    TextSpan(text: " search", style: CattleStyles.blacklightw50016),
                  ],
                ),
              ),
              Text("${provider.recentSearches.length} results", style: CattleStyles.neutral90w30014),
            ],
          ),
        ),
        const SizedBox(height: 8),
        ...provider.recentSearches.map((name) => ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name),
                  const Divider(thickness: 0.2),
                ],
              ),
              onTap: () => provider.selectRecent(name),
            )),
      ],
    );
  }
}
