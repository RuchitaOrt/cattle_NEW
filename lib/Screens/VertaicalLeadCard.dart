
import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/Widget/LeadCard.dart';
import 'package:cattle/enum/caseListingEnum.dart';
import 'package:cattle/model/LeadModel.dart';
import 'package:flutter/material.dart';

class LeadCardSlider extends StatefulWidget {
   final List<LeadModel> leadList; 
   final String caseType;
  const LeadCardSlider({super.key, required this.leadList, required this.caseType});

  @override
  State<LeadCardSlider> createState() => _LeadCardSliderState();
}

class _LeadCardSliderState extends State<LeadCardSlider> {
  final ScrollController _scrollController = ScrollController();
  final int totalCards = 6;
  double itemHeight =
   252; // height of one card
  int _currentVisibleIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final scrollOffset = _scrollController.offset;
    final index = (scrollOffset / itemHeight).round();
    if (index != _currentVisibleIndex && index < totalCards) {
      setState(() {
        _currentVisibleIndex = index;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          controller: _scrollController,
          itemCount: widget.leadList.length,
          itemExtent: widget.caseType==CaseType.Complete.name?175: itemHeight,
         
          itemBuilder: (context, index) => _buildCard(index,widget.leadList),
        ),
        const SizedBox(height: 16),
       
      ],
    );
  }

  Widget _buildCard(int index,List<LeadModel> leadList) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: CattleColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            blurRadius: 6,
            offset: Offset(0, 2),
            color: Colors.black12,
          ),
        ],
      ),
      child:  LeadCard(leadList:  leadList[index],caseType: widget.caseType,), // Replace with your actual widget
    );
  }
}
