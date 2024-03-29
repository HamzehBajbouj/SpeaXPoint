import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:speaxpoint/models/online_session.dart';
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
  Future<Result<String, Failure>> getSessionLaunchingTime({
    required bool isAnAppGuest,
    String? chapterMeetingId,
    String? chapterMeetingInvitationCode,
  }) async {
    String launchTime = "00:00:00";
    try {
      QuerySnapshot chapterMeetingQS;
      if (isAnAppGuest) {
        chapterMeetingQS = await _chapterMeetingsC
            .where("invitationCode", isEqualTo: chapterMeetingInvitationCode)
            .get();
      } else {
        chapterMeetingQS = await _chapterMeetingsC
            .where("chapterMeetingId", isEqualTo: chapterMeetingId)
            .get();
      }

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
                  'thereIsSelectedSpeaker': false,
                  'numberOfJoinedPeople': 0,
                  'currentSpeakerName': null,
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
  Stream<List<OnlineSessionCapturedData>> getListOfSpeachesForAppGuest({
    required String chapterMeetingInvitationCode,
  }) async* {
    // TODO: implement getOnlineCapturedDataForAppGuest
    throw UnimplementedError();
  }

  @override
  Stream<List<OnlineSessionCapturedData>> getListOfSpeachesForAppUser(
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
            //this one is used just temprory to save a new selected
            //speaker details after updating his status, and before removing it from the
            //list
            OnlineSessionCapturedData currentSpeakerDetails =
                OnlineSessionCapturedData();
            if (updatePreviousSelectedUserQS.docs.isNotEmpty) {
              List<OnlineSessionCapturedData> tempList =
                  updatePreviousSelectedUserQS.docs
                      .map(
                        (e) => OnlineSessionCapturedData.fromJson(
                            e.data() as Map<String, dynamic>),
                      )
                      .toList();

              if (isAnAppGuest) {
                currentSpeakerDetails = tempList.firstWhere((element) =>
                    element.guestInvitationCode == guestInvitationCode);
                tempList.removeWhere((element) =>
                    element.guestInvitationCode == guestInvitationCode);
              } else {
                currentSpeakerDetails = tempList.firstWhere(
                    (element) => element.toastmasterId == toastmasterId);
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

                  //here i also want to end the timing if there is timing counter
                  //if there is any kind of swticting but the time is still running
                  QuerySnapshot capturedTimingDataQS = await temQs
                      .docs.first.reference
                      .collection("CapturedTimingData")
                      .get();
                  if (capturedTimingDataQS.docs.isNotEmpty) {
                    await capturedTimingDataQS.docs.first.reference.update({
                      "timeCounterStarted": false,
                      "timeCounterEndingTime":
                          DateTime.now().toUtc().toString(),
                    });
                  }
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
                    "currentSpeakerToastmasterId": null,
                    "currentSpeakerName": currentSpeakerDetails.speakerName,
                  },
                );
              } else {
                await onlineSessionQS.docs.first.reference.update(
                  {
                    "currentSpeakerToastmasterId": toastmasterId,
                    "isGuest": isAnAppGuest,
                    "thereIsSelectedSpeaker": true,
                    "currentGuestSpeakerInvitationCode": null,
                    "currentSpeakerName": currentSpeakerDetails.speakerName,
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
              location: "LiveSessionFirebaseService.selectSpeech()",
              message:
                  "Could not found a chapter meeting with id : $chapterMeetingId"),
        );
      }
      return Success.unit();
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location: "LiveSessionFirebaseService.selectSpeech()",
            message: e.message ??
                "Database Error While ending the chapter meeting session"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location: "LiveSessionFirebaseService.selectSpeech()",
            message: e.toString()),
      );
    }
  }

  @override
  Stream<OnlineSession> getOnlineSessionDetails(
      {required bool isAnAppGuest,
      String? chapterMeetingId,
      String? chapterMeetingInvitationCode}) async* {
    Stream<OnlineSession> onlineSession = Stream.empty();
    try {
      QuerySnapshot chapterMeetingQS;

      if (isAnAppGuest) {
        chapterMeetingQS = await _chapterMeetingsC
            .where("invitationCode", isEqualTo: chapterMeetingInvitationCode)
            .get();
      } else {
        chapterMeetingQS = await _chapterMeetingsC
            .where("chapterMeetingId", isEqualTo: chapterMeetingId)
            .get();
      }

      if (chapterMeetingQS.docs.isNotEmpty) {
        onlineSession = chapterMeetingQS.docs.first.reference
            .collection("OnlineSession")
            .limit(1) // Retrieve only the first document
            .snapshots()
            .map((QuerySnapshot querySnapshot) => OnlineSession.fromJson(
                querySnapshot.docs[0].data() as Map<String, dynamic>));
      }

      yield* onlineSession;
    } on FirebaseException catch (e) {
      log("${e.code} ${e.message}");
      yield* onlineSession;
    } catch (e) {
      log(e.toString());
      yield* onlineSession;
    }
  }

  @override
  Future<Result<List<OnlineSessionCapturedData>, Failure>>
      getListOfSpeachesSpeakersForAppGuest(
          {required String chapterMeetingInvitationCode,
          }) async {
    try {

      List<OnlineSessionCapturedData> tempList = [];
      QuerySnapshot onlineSessionCapturedDataQS =
          await _onlineSessionCapturedDataC
              .where("chapterMeetingInvitationCode",
                  isEqualTo: chapterMeetingInvitationCode)
              .get();
      if (onlineSessionCapturedDataQS.docs.isEmpty) {
        return const Error(
          Failure(
              code: "No-Speeches-Found",
              location:
                  "LiveSessionFirebaseService.getListOfSpeachesSpeakersForAppGuest()",
              message: "Could not find any speeches' speakers "),
        );
      } else {
        tempList = onlineSessionCapturedDataQS.docs
            .map((doc) => OnlineSessionCapturedData.fromJson(
                doc.data() as Map<String, dynamic>))
            .toList();
      }

      return Success(tempList);
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location:
                "LiveSessionFirebaseService.getListOfSpeachesSpeakersForAppGuest()",
            message: e.message ??
                "Database Error While getting speeches speakers list"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location:
                "LiveSessionFirebaseService.getListOfSpeachesSpeakersForAppGuest()",
            message: e.toString()),
      );
    }
  }

  @override
  Future<Result<List<OnlineSessionCapturedData>, Failure>>
      getListOfSpeachesSpeakersForAppUser(
          {required String chapterMeetingId}) async {
    try {
      List<OnlineSessionCapturedData> tempList = [];
      QuerySnapshot onlineSessionCapturedDataQS =
          await _onlineSessionCapturedDataC
              .where("chapterMeetingId", isEqualTo: chapterMeetingId)
              .get();
      if (onlineSessionCapturedDataQS.docs.isEmpty) {
        return const Error(
          Failure(
              code: "No-Speeches-Found",
              location:
                  "LiveSessionFirebaseService.getListOfSpeachesSpeakersForAppUser()",
              message: "Could not find any speeches' speakers "),
        );
      } else {
        tempList = onlineSessionCapturedDataQS.docs
            .map((doc) => OnlineSessionCapturedData.fromJson(
                doc.data() as Map<String, dynamic>))
            .toList();
      }

      return Success(tempList);
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location:
                "LiveSessionFirebaseService.getListOfSpeachesSpeakersForAppUser()",
            message: e.message ??
                "Database Error While getting speeches speakers list"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location:
                "LiveSessionFirebaseService.getListOfSpeachesSpeakersForAppUser()",
            message: e.toString()),
      );
    }
  }
}
