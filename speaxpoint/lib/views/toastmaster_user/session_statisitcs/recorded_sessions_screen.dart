import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/app/app_routes.gr.dart';
import 'package:speaxpoint/models/chapter_meeting.dart';
import 'package:speaxpoint/models/online_session_captured_data.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart';
import 'package:speaxpoint/util/ui_widgets/common_widgets.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/statisitcs/recorded_sessions_view_model.dart';

class RecordedSessionsScreen extends StatefulWidget {
  const RecordedSessionsScreen({super.key});

  @override
  State<RecordedSessionsScreen> createState() => _RecordedSessionsScreenState();
}

class _RecordedSessionsScreenState extends State<RecordedSessionsScreen> {
  late RecordedSessionViewModel _recordedSessionsViewModel;
  final TextEditingController _searchMeetingController =
      TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _recordedSessionsViewModel =
        Provider.of<RecordedSessionViewModel>(context, listen: false);
    _recordedSessionsViewModel.fetchItems();
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
      _recordedSessionsViewModel.fetchItems();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Recorded Session",
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
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Consumer<RecordedSessionViewModel>(
                  builder: (context, viewmodel, _) {
                    if (viewmodel.loading &&
                        viewmodel.recordedSession.isEmpty) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color(AppMainColors.p40),
                        ),
                      );
                    } else if (!viewmodel.loading &&
                        viewmodel.recordedSession.isEmpty) {
                      return Stack(
                        children: [
                          Visibility(
                            visible: !_isLoading,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: SvgPicture.asset(
                                      fit: BoxFit.fill,
                                      "assets/images/no_statistics.svg",
                                      allowDrawingOutsideViewBox: false,
                                      // width: 200,
                                      height: 150,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  const Text(
                                    'Thers are not any recorded sessions yet.',
                                    style: TextStyle(
                                      fontFamily: CommonUIProperties.fontType,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Color(AppMainColors.p70),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  outlinedButton(
                                      callBack: () async {
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        await _recordedSessionsViewModel
                                            .fetchItems(
                                              resetEverything: true,
                                            )
                                            .timeout(const Duration(seconds: 5))
                                            .then((value) {
                                          setState(() {
                                            _isLoading = false;
                                          });
                                        });
                                      },
                                      content: "Refresh Screen")
                                ],
                              ),
                            ),
                          ),
                          if (_isLoading)
                            Container(
                              color: Colors.black.withOpacity(0.0),
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: Color(AppMainColors.p40),
                                ),
                              ),
                            ),
                        ],
                      );
                    } else {
                      return ListView.separated(
                        controller: _scrollController,
                        separatorBuilder: (_, index) => const SizedBox(
                          height: 10,
                        ),
                        itemCount: viewmodel
                            .recordedSession["ChapterMeetings"]!.length,
                        itemBuilder: (context, index) {
                          if (index == viewmodel.recordedSession.length) {
                            if (viewmodel.loading) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Color(AppMainColors.p40),
                                ),
                              );
                            } else if (!viewmodel.hasMore) {
                              return Container();
                            }
                          }
                          final chapterMeeting = ChapterMeeting.fromJson(
                              viewmodel
                                  .recordedSession["ChapterMeetings"]![index]);
                          final capturedData =
                              OnlineSessionCapturedData.fromJson(
                                  viewmodel.recordedSession[
                                      "OnlineSessionCapturedData"]![index]);
                          return recordedSessionCard(
                            chapterMeetingTitle: chapterMeeting.chapterTitle!,
                            dataOfTheSession: chapterMeeting.dateOfMeeting!,
                            iconButtonAction: () {
                              context.pushRoute(
                                RecordedSessionStatisticsViewRouter(
                                  chapterMeetingId:
                                      chapterMeeting.chapterMeetingId!,
                                  toastmasterId: capturedData.toastmasterId!,
                                ),
                              );
                            },
                            roleName:
                                "${capturedData.roleName!} ${capturedData.roleOrderPlace! == 0 ? "" : capturedData.roleOrderPlace.toString()}",
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
}
