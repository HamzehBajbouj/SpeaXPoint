import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:speaxpoint/services/failure.dart';
import 'package:speaxpoint/models/speech_timing.dart';
import 'package:multiple_result/src/unit.dart';
import 'package:multiple_result/src/result.dart';
import 'package:speaxpoint/services/live_session/timer/i_timing_role_service.dart';

class TimingRoleFirebaseSerivce extends ITimingRoleService {
  final CollectionReference _onlineSessionCapturedDataC =
      FirebaseFirestore.instance.collection('OnlineSessionCapturedData');
  @override
  Future<Result<SpeechTiming, Failure>> getSpeakerSpeechTimingData(
      {required bool currentSpeakerisAppGuest,
      String? currentSpeakerToastmasterId,
      String? currentSpeakerGuestInvitationCode,
      String? chapterMeetingInvitationCode,
      String? chapterMeetingId}) async {
    try {
      SpeechTiming speechTiming = SpeechTiming();
      QuerySnapshot onlineSessionCapturedDataQS;
      if (currentSpeakerisAppGuest) {
        onlineSessionCapturedDataQS = await _onlineSessionCapturedDataC
            .where("chapterMeetingInvitationCode",
                isEqualTo: chapterMeetingInvitationCode)
            .where("guestInvitationCode",
                isEqualTo: currentSpeakerGuestInvitationCode)
            .get();
      } else {
        onlineSessionCapturedDataQS = await _onlineSessionCapturedDataC
            .where("chapterMeetingId", isEqualTo: chapterMeetingId)
            .where("toastmasterId", isEqualTo: currentSpeakerToastmasterId)
            .get();
      }

      if (onlineSessionCapturedDataQS.docs.isNotEmpty) {
        CollectionReference capturedTimingDataC = onlineSessionCapturedDataQS
            .docs.first.reference
            .collection("CapturedTimingData");
        QuerySnapshot capturedTimingDataQS = await capturedTimingDataC.get();
        if (capturedTimingDataQS.docs.isNotEmpty) {
          speechTiming = SpeechTiming.fromJson(
              capturedTimingDataQS.docs.first.data() as Map<String, dynamic>);
        }
      } else {
        return const Error(
          Failure(
              code: "No-Speaker-Found",
              location:
                  "TimingRoleFirebaseSerivce.getSpeakerSpeechTimingData()",
              message: "Could not found a speaker speech record"),
        );
      }
      return Success(speechTiming);
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location: "TimingRoleFirebaseSerivce.getSpeakerSpeechTimingData()",
            message: e.message ??
                "Database Error While getting the speech speaker details"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location: "TimingRoleFirebaseSerivce.getSpeakerSpeechTimingData()",
            message: e.toString()),
      );
    }
  }

  @override
  Future<Result<Unit, Failure>> startCurrentSpeakerTiming(
      {required SpeechTiming speechTiming,
      required bool currentSpeakerisAppGuest,
      String? currentSpeakerToastmasterId,
      String? currentSpeakerGuestInvitationCode,
      String? chapterMeetingInvitationCode,
      String? chapterMeetingId}) async {
    try {
      QuerySnapshot onlineSessionCapturedDataQS;
      if (currentSpeakerisAppGuest) {
        onlineSessionCapturedDataQS = await _onlineSessionCapturedDataC
            .where("chapterMeetingInvitationCode",
                isEqualTo: chapterMeetingInvitationCode)
            .where("guestInvitationCode",
                isEqualTo: currentSpeakerGuestInvitationCode)
            .get();
      } else {
        onlineSessionCapturedDataQS = await _onlineSessionCapturedDataC
            .where("chapterMeetingId", isEqualTo: chapterMeetingId)
            .where("toastmasterId", isEqualTo: currentSpeakerToastmasterId)
            .get();
      }

      if (onlineSessionCapturedDataQS.docs.isNotEmpty) {
        CollectionReference capturedTimingDataC = onlineSessionCapturedDataQS
            .docs.first.reference
            .collection("CapturedTimingData");
        QuerySnapshot capturedTimingDataQS = await capturedTimingDataC.get();
        if (capturedTimingDataQS.docs.isNotEmpty) {
          await capturedTimingDataQS.docs.first.reference
              .set(speechTiming.toJson());
        } else {
          await capturedTimingDataC.add(speechTiming.toJson());
        }
      } else {
        return const Error(
          Failure(
              code: "No-Speaker-Found",
              location: "TimingRoleFirebaseSerivce.startCurrentSpeakerTiming()",
              message: "Could not found a speaker speech record"),
        );
      }
      return Success.unit();
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location: "TimingRoleFirebaseSerivce.startCurrentSpeakerTiming()",
            message:
                e.message ?? "Database Error While starting the speech timer"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location: "TimingRoleFirebaseSerivce.startCurrentSpeakerTiming()",
            message: e.toString()),
      );
    }
  }

  @override
  Future<Result<Unit, Failure>> stopCurrentSpeakerTiming(
      {required SpeechTiming speechTiming,
      required bool currentSpeakerisAppGuest,
      String? currentSpeakerToastmasterId,
      String? currentSpeakerGuestInvitationCode,
      String? chapterMeetingInvitationCode,
      String? chapterMeetingId}) async {
    try {
      QuerySnapshot onlineSessionCapturedDataQS;
      if (currentSpeakerisAppGuest) {
        onlineSessionCapturedDataQS = await _onlineSessionCapturedDataC
            .where("chapterMeetingInvitationCode",
                isEqualTo: chapterMeetingInvitationCode)
            .where("guestInvitationCode",
                isEqualTo: currentSpeakerGuestInvitationCode)
            .get();
      } else {
        onlineSessionCapturedDataQS = await _onlineSessionCapturedDataC
            .where("chapterMeetingId", isEqualTo: chapterMeetingId)
            .where("toastmasterId", isEqualTo: currentSpeakerToastmasterId)
            .get();
      }

      if (onlineSessionCapturedDataQS.docs.isNotEmpty) {
        CollectionReference capturedTimingDataC = onlineSessionCapturedDataQS
            .docs.first.reference
            .collection("CapturedTimingData");
        QuerySnapshot capturedTimingDataQS = await capturedTimingDataC.get();
        if (capturedTimingDataQS.docs.isNotEmpty) {
          await capturedTimingDataQS.docs.first.reference.update({
            "timeCounterEndingTime": speechTiming.timeCounterEndingTime,
            "timeCounterStarted": speechTiming.timeCounterStarted
          });
        } else {
          const Error(
            Failure(
                code: "No-Timing-Record-Found",
                location:
                    "TimingRoleFirebaseSerivce.stopCurrentSpeakerTiming()",
                message: "Could not found a speaker speech timing record"),
          );
        }
      } else {
        return const Error(
          Failure(
              code: "No-Speaker-Found",
              location: "TimingRoleFirebaseSerivce.stopCurrentSpeakerTiming()",
              message: "Could not found a speaker speech record"),
        );
      }
      return Success.unit();
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location: "TimingRoleFirebaseSerivce.stopCurrentSpeakerTiming()",
            message:
                e.message ?? "Database Error While stoppong the speech timer"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location: "TimingRoleFirebaseSerivce.stopCurrentSpeakerTiming()",
            message: e.toString()),
      );
    }
  }

  @override
  Stream<SpeechTiming> getSpeakerSpeechTimingLiveData(
      {required bool currentSpeakerisAppGuest,
      String? currentSpeakerToastmasterId,
      String? currentSpeakerGuestInvitationCode,
      String? chapterMeetingInvitationCode,
      String? chapterMeetingId}) async* {
    Stream<SpeechTiming> speechTiming = Stream.empty();
    try {
      QuerySnapshot onlineSessionCapturedDataQS;
      if (currentSpeakerisAppGuest) {
        onlineSessionCapturedDataQS = await _onlineSessionCapturedDataC
            .where("chapterMeetingInvitationCode",
                isEqualTo: chapterMeetingInvitationCode)
            .where("guestInvitationCode",
                isEqualTo: currentSpeakerGuestInvitationCode)
            .get();
      } else {
        onlineSessionCapturedDataQS = await _onlineSessionCapturedDataC
            .where("chapterMeetingId", isEqualTo: chapterMeetingId)
            .where("toastmasterId", isEqualTo: currentSpeakerToastmasterId)
            .get();
      }
      if (onlineSessionCapturedDataQS.docs.isNotEmpty) {
        speechTiming = onlineSessionCapturedDataQS.docs.first.reference
            .collection("CapturedTimingData")
            .limit(1) // Retrieve only the first document
            .snapshots()
            .map((QuerySnapshot querySnapshot) => SpeechTiming.fromJson(
                querySnapshot.docs[0].data() as Map<String, dynamic>));
      }
      yield* speechTiming;
    } on FirebaseException catch (e) {
      log("${e.code} ${e.message}");
      yield* speechTiming;
    } catch (e) {
      log(e.toString());
      yield* speechTiming;
    }
  }
}
