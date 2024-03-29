import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/app/app_routes.gr.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_enums.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/text_fields.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/search_chapter_meeting_view_model.dart';

class SearchChapterMeetingScreen extends StatefulWidget {
  const SearchChapterMeetingScreen({super.key});

  @override
  State<SearchChapterMeetingScreen> createState() =>
      _SearchChapterMeetingScreenState();
}

class _SearchChapterMeetingScreenState
    extends State<SearchChapterMeetingScreen> {
  late SearchChapterMeetingViewModel _searchChapterMeetingViewModel;
  final TextEditingController _searchMeetingController =
      TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _searchChapterMeetingViewModel =
        Provider.of<SearchChapterMeetingViewModel>(context, listen: false);
    _searchChapterMeetingViewModel.clearSearch();
    _searchChapterMeetingViewModel.fetchItems();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    final double maxScroll = _scrollController.position.maxScrollExtent;
    final double currentScroll = _scrollController.position.pixels;
    final double delta = MediaQuery.of(context).size.height * 0.20;
    if (maxScroll - currentScroll <= delta) {
      _searchChapterMeetingViewModel.fetchItems();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Color(AppMainColors.p70),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Explore Chapter Meetings",
          style: TextStyle(
            fontFamily: CommonUIProperties.fontType,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(AppMainColors.p70),
          ),
        ),
      ),
      backgroundColor: const Color(AppMainColors.backgroundAndContent),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
          child: Column(
            children: [
              outlineTextFiledWithLeadingIcon(
                hintText: "Search By Club Username...",
                controller: _searchMeetingController,
                onChangeCallBack: (data) async {
                  if (data.isNotEmpty) {
                    await _searchChapterMeetingViewModel.searchByClubUsername(
                        clubUsername: data);
                  } else {
                    _searchChapterMeetingViewModel.clearSearch();
                    await _searchChapterMeetingViewModel.fetchItems();
                  }
                },
                icon: const Icon(
                  Icons.search,
                  size: 30,
                  color: Color(AppMainColors.p20),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Consumer<SearchChapterMeetingViewModel>(
                  builder: (context, viewmodel, _) {
                    if (viewmodel.loading &&
                        viewmodel.publishedAnnouncements.isEmpty) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (!viewmodel.loading &&
                        viewmodel.publishedAnnouncements.isEmpty) {
                      return const Center(
                        child: Text('No Published Announcements Can Be Found.'),
                      );
                    } else {
                      return ListView.separated(
                        controller: _scrollController,
                        separatorBuilder: (_, index) => const SizedBox(
                          height: 10,
                        ),
                        itemCount: viewmodel.publishedAnnouncements.length,
                        itemBuilder: (context, index) {
                          if (index ==
                              viewmodel.publishedAnnouncements.length) {
                            if (viewmodel.loading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (!viewmodel.hasMore) {
                              return Container();
                            }
                          }
                          final announcement =
                              viewmodel.publishedAnnouncements[index];

                          return _getAnnouncementCard(
                            chapterMeetingId: announcement['chapterMeetingId'],
                            announcementType: announcement['annoucementType'],
                            description: announcement['annoucementDescription'],
                            title: announcement['annoucementTitle'],
                            clubId: announcement['clubId'],
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Card _getAnnouncementCard({
    required String chapterMeetingId,
    required String title,
    required String description,
    required String announcementType,
    required String clubId,
  }) {
    return Card(
      margin: const EdgeInsets.all(0),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(CommonUIProperties.cardRoundedEdges),
        side: const BorderSide(
          width: 1.3,
          style: BorderStyle.solid,
          color: Color(AppMainColors.p20),
        ),
      ),
      child: ListTile(
        onTap: () {
          if (announcementType ==
              AnnouncementType.ChapterMeetingAnnouncement.name) {
            context.pushRoute(
              ChapterMeetingAnnouncementViewRouter(
                chapterMeetingId: chapterMeetingId,
                viewedFromSearchPage: true,
                clubId: clubId,
              ),
            );
          } else if (announcementType ==
              AnnouncementType.VolunteersAnnouncement.name) {
            context.pushRoute(
              VolunteerAnnouncementViewDetailsRouter(
                clubId: clubId,
                chapterMeetingId: chapterMeetingId,
              ),
            );
          }
        },
        contentPadding: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 2.5,
          bottom: 2.5,
        ),
        leading: Icon(
          announcementType == AnnouncementType.ChapterMeetingAnnouncement.name
              ? Icons.public
              : Icons.emoji_people_rounded,
          color: const Color(AppMainColors.p40),
          size: 35,
        ),
        title: Text(
          title,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontFamily: CommonUIProperties.fontType,
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: Color(AppMainColors.p80),
          ),
        ),
        subtitle: Text(
          description,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontFamily: CommonUIProperties.fontType,
            fontSize: 13,
            fontWeight: FontWeight.normal,
            color: Color(AppMainColors.p50),
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: Color(AppMainColors.p40),
          size: 35,
        ),
      ),
    );
  }
}
