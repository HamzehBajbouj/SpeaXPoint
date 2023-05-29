import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:speaxpoint/services/failure.dart';
import 'package:speaxpoint/models/online_session_captured_data.dart';
import 'package:multiple_result/src/unit.dart';
import 'package:multiple_result/src/result.dart';
import 'package:speaxpoint/services/live_session/i_live_session_service.dart';
import 'package:speaxpoint/util/constants/common_enums.dart';
import 'package:speaxpoint/util/time_manager.dart' as util;

class LiveSessionFirebaseService implements ILiveSessionService {
  final CollectionReference _chapterMeetingsC =
      FirebaseFirestore.instance.collection('ChapterMeetings');

  final CollectionReference _onlineSessionCapturedDataC =
      FirebaseFirestore.instance.collection('OnlineSessionCapturedData');

  @override
  Future<Result<String, Failure>> getSessionLaunchingTime(
      {required String chapterMeetingId}) async {
    String launchTime = "00:00:00";
    try {
      QuerySnapshot chapterMeetingQS = await _chapterMeetingsC
          .where("chapterMeetingId", isEqualTo: chapterMeetingId)
          .get();
      if (chapterMeetingQS.docs.isNotEmpty) {
        QuerySnapshot onlineSessionSQ = await chapterMeetingQS
            .docs.first.reference
            .collection("OnlineSession")
            .get();
        if (onlineSessionSQ.docs.isNotEmpty) {
          Map<String, dynamic> tempMap =
              onlineSessionSQ.docs.first.data() as Map<String, dynamic>;
          launchTime = tempMap['lanuchingTime'];
        }
      } else {
        return Error(
          Failure(
              code: "No-Chapter-Meeting-Found",
              location: "LiveSessionFirebaseService.getSessionLaunchingTime()",
              message:
                  "Could not found a chapter meeting with id : $chapterMeetingId"),
        );
      }
      return Success(launchTime);
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location: "LiveSessionFirebaseService.getSessionLaunchingTime()",
            message: e.message ??
                "Database Error While getting the session launch time"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location: "LiveSessionFirebaseService.getSessionLaunchingTime()",
            message: e.toString()),
      );
    }
  }

  @override
  Future<Result<Unit, Failure>> endChapterMeetingSession(
      {required String chapterMeetingId}) async {
    try {
      QuerySnapshot chapterMeetingQS = await _chapterMeetingsC
          .where("chapterMeetingId", isEqualTo: chapterMeetingId)
          .get();
      if (chapterMeetingQS.docs.isNotEmpty) {
        await chapterMeetingQS.docs.first.reference.update({
          'chapterMeetingStatus': ComingSessionsStatus.Completed.name,
        }).then(
          (_) async {
            QuerySnapshot onlineSessionSQ = await chapterMeetingQS
                .docs.first.reference
                .collection("OnlineSession")
                .get();
            if (onlineSessionSQ.docs.isNotEmpty) {
              await onlineSessionSQ.docs.first.reference.update(
                {
                  'terminatingTime': util.getCurrentUTCTime(),
                  'currentGuestSpeakerInvitationCode': null,
                  'currentSpeakerToastmasterId': null,
                  'isGuest': null,
                  'thereIsSelectedSpeaker': null,
                  'numberOfJoinedPeople': 0,
                },
              );
            }
          },
        );
      } else {
        return Error(
          Failure(
              code: "No-Chapter-Meeting-Found",
              location: "LiveSessionFirebaseService.endChapterMeetingSession()",
              message:
                  "Could not found a chapter meeting with id : $chapterMeetingId"),
        );
      }
      return Success.unit();
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location: "LiveSessionFirebaseService.endChapterMeetingSession()",
            message: e.message ??
                "Database Error While ending the chapter meeting session"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location: "LiveSessionFirebaseService.endChapterMeetingSession()",
            message: e.toString()),
      );
    }
  }

  @override
  Stream<int> getNumberOfOnlinePeople(
      {required String chapterMeetingId}) async* {
    Stream<int> onlinePeople = Stream.empty();
    try {
      QuerySnapshot chapterMeetingQS = await _chapterMeetingsC
          .where("chapterMeetingId", isEqualTo: chapterMeetingId)
          .get();

      if (chapterMeetingQS.docs.isNotEmpty) {
        onlinePeople = chapterMeetingQS.docs.first.reference
            .collection("OnlineSession")
            .limit(1) // Retrieve only the first document
            .snapshots()
            .map((QuerySnapshot querySnapshot) =>
                querySnapshot.docs[0].get("numberOfJoinedPeople"));
      }

      yield* onlinePeople;
    } on FirebaseException catch (e) {
      log("${e.code} ${e.message}");
      yield* onlinePeople;
    } catch (e) {
      log(e.toString());
      yield* onlinePeople;
    }
  }

  @override
  Stream<List<OnlineSessionCapturedData>> getOnlineCapturedDataForAppGuest(
      {required String chapterMeetingInvitationCode,
      required String guestInvitationCode}) async* {
    // TODO: implement getOnlineCapturedDataForAppGuest
    throw UnimplementedError();
  }

  @override
  Stream<List<OnlineSessionCapturedData>> getOnlineCapturedDataForAppUser(
      {required String chapterMeetingId}) async* {
    Stream<List<OnlineSessionCapturedData>> onlineSessionData = Stream.empty();
    try {
      onlineSessionData = _onlineSessionCapturedDataC
          .where("chapterMeetingId", isEqualTo: chapterMeetingId)
          .snapshots()
          .map(
            (QuerySnapshot querySnapshot) => querySnapshot.docs.map(
              (e) {
                return OnlineSessionCapturedData.fromJson(
                  e.data() as Map<String, dynamic>,
                );
              },
            ).toList(),
          );

      yield* onlineSessionData;
    } on FirebaseException catch (e) {
      log("${e.code} ${e.message}");
      yield* onlineSessionData;
    } catch (e) {
      log(e.toString());
      yield* onlineSessionData;
    }
  }

  @override
  Future<Result<Unit, Failure>> selectSpeech({
    required String chapterMeetingId,
    required bool isAnAppGuest,
    String? toastmasterId,
    String? guestInvitationCode,
    String? chapterMeetingInvitationCode,
  }) async {
    try {
      late QuerySnapshot onlineSessionCapturedData;
      if (isAnAppGuest) {
        onlineSessionCapturedData = await _onlineSessionCapturedDataC
            .where("chapterMeetingInvitationCode",
                isEqualTo: chapterMeetingInvitationCode)
            .where("guestInvitationCode", isEqualTo: guestInvitationCode)
            .get();
      } else {
        onlineSessionCapturedData = await _onlineSessionCapturedDataC
            .where("chapterMeetingId", isEqualTo: chapterMeetingId)
            .where("toastmasterId", isEqualTo: toastmasterId)
            .get();
      }

      if (onlineSessionCapturedData.docs.isNotEmpty) {
        await onlineSessionCapturedData.docs.first.reference.update(
          {
            "onlineSessionSpeakerTurn":
                OnlineSessionSpeakerTurn.CurrentlySelected.name,
          },
        ).then(
          (_) async {
            QuerySnapshot updatePreviousSelectedUserQS =
                await _onlineSessionCapturedDataC
                    .where("chapterMeetingId", isEqualTo: chapterMeetingId)
                    .where(
                      "onlineSessionSpeakerTurn",
                      isEqualTo:
                          OnlineSessionSpeakerTurn.CurrentlySelected.name,
                    )
                    .get();

            if (updatePreviousSelectedUserQS.docs.isNotEmpty) {
              List<OnlineSessionCapturedData> tempList =
                  updatePreviousSelectedUserQS.docs
                      .map(
                        (e) => OnlineSessionCapturedData.fromJson(
                            e.data() as Map<String, dynamic>),
                      )
                      .toList();
              if (isAnAppGuest) {
                tempList.removeWhere((element) =>
                    element.guestInvitationCode == guestInvitationCode);
              } else {
                tempList.removeWhere(
                    (element) => element.toastmasterId == toastmasterId);
              }
              QuerySnapshot? temQs;
              if (tempList.isNotEmpty) {
                if (tempList[0].isAnAppGuest!) {
                  temQs = await _onlineSessionCapturedDataC
                      .where("chapterMeetingId", isEqualTo: chapterMeetingId)
                      .where(
                        "guestInvitationCode",
                        isEqualTo: tempList[0].guestInvitationCode,
                      )
                      .get();
                } else {
                  temQs = await _onlineSessionCapturedDataC
                      .where("chapterMeetingId", isEqualTo: chapterMeetingId)
                      .where(
                        "toastmasterId",
                        isEqualTo: tempList[0].toastmasterId,
                      )
                      .get();
                }
              }
              if (temQs != null) {
                if (temQs.docs.isNotEmpty) {
                  await temQs.docs.first.reference.update(
                    {
                      "onlineSessionSpeakerTurn":
                          OnlineSessionSpeakerTurn.WasSelected.name,
                    },
                  );
                }
              }
            }
            late QuerySnapshot chapterMeetingQS;
            if (isAnAppGuest) {
              chapterMeetingQS = await _chapterMeetingsC
                  .where("invitationCode",
                      isEqualTo: chapterMeetingInvitationCode)
                  .get();
            } else {
              chapterMeetingQS = await _chapterMeetingsC
                  .where("chapterMeetingId", isEqualTo: chapterMeetingId)
                  .get();
            }
            if (chapterMeetingQS.docs.isNotEmpty) {
              CollectionReference onlineSessionC = chapterMeetingQS
                  .docs.first.reference
                  .collection("OnlineSession");
              QuerySnapshot onlineSessionQS = await onlineSessionC.get();
              if (isAnAppGuest) {
                await onlineSessionQS.docs.first.reference.update(
                  {
                    "currentGuestSpeakerInvitationCode": guestInvitationCode,
                    "isGuest": isAnAppGuest,
                    "thereIsSelectedSpeaker": true,
                    "currentSpeakerToastmasterId": null
                  },
                );
              } else {
                await onlineSessionQS.docs.first.reference.update(
                  {
                    "currentSpeakerToastmasterId": toastmasterId,
                    "isGuest": isAnAppGuest,
                    "thereIsSelectedSpeaker": true,
                    "currentGuestSpeakerInvitationCode": null,
                  },
                );
              }
            }
          },
        );
      } else {
        return Error(
          Failure(
              code: "No-Chapter-Meeting-Found",
              location: "LiveSessionFirebaseService.endChapterMeetingSession()",
              message:
                  "Could not found a chapter meeting with id : $chapterMeetingId"),
        );
      }
      return Success.unit();
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location: "LiveSessionFirebaseService.endChapterMeetingSession()",
            message: e.message ??
                "Database Error While ending the chapter meeting session"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location: "LiveSessionFirebaseService.endChapterMeetingSession()",
            message: e.toString()),
      );
    }
  }
}
