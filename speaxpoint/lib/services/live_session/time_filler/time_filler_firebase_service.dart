import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:speaxpoint/services/failure.dart';
import 'package:speaxpoint/models/time_filler_captured_data.dart';
import 'package:multiple_result/src/unit.dart';
import 'package:multiple_result/src/result.dart';
import 'package:speaxpoint/services/live_session/time_filler/i_time_filler_service.dart';

class TimeFillerFirebaseService extends ITimeFillerService {
  final CollectionReference _onlineSessionCapturedDataC =
      FirebaseFirestore.instance.collection('OnlineSessionCapturedData');

  @override
  Future<Result<Unit, Failure>> increaseTimeFillerCounter(
      {required TimeFillerCapturedData timeFillerCapturedData,
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
        CollectionReference timeFillerDataC = onlineSessionCapturedDataQS
            .docs.first.reference
            .collection("TimeFillersCapturedData");
        await timeFillerDataC.add(timeFillerCapturedData.toJson());
      } else {
        return const Error(
          Failure(
              code: "No-Speaker-Found",
              location: "TimeFillerFirebaseService.increaseTimeFillerCounter()",
              message: "Could not found a speaker speech record"),
        );
      }
      return Success.unit();
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location: "TimeFillerFirebaseService.increaseTimeFillerCounter()",
            message: e.message ??
                "Database Error While adding new time filler data"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location: "TimeFillerFirebaseService.increaseTimeFillerCounter()",
            message: e.toString()),
      );
    }
  }

  @override
  Future<Result<Unit, Failure>> decreaseTimeFillerCounter(
      {required TimeFillerCapturedData timeFillerCapturedData,
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
        CollectionReference timeFillerDataC = onlineSessionCapturedDataQS
            .docs.first.reference
            .collection("TimeFillersCapturedData");
        QuerySnapshot timeFillerDataQS = await timeFillerDataC
            .where("typeOfTimeFiller",
                isEqualTo: timeFillerCapturedData.typeOfTimeFiller)
            .orderBy('timeOfCapturing', descending: true)
            .limit(1)
            .get();
        if (timeFillerDataQS.docs.isNotEmpty) {
          await timeFillerDataQS.docs.first.reference.delete();
        } else {
          return Error(
            Failure(
                code: "No-Time-Recotd-Found",
                location:
                    "TimeFillerFirebaseService.decreaseTimeFillerCounter()",
                message:
                    "Could not find the latest time filler captured data for type : ${timeFillerCapturedData.typeOfTimeFiller}"),
          );
        }
      } else {
        return const Error(
          Failure(
              code: "No-Speaker-Found",
              location: "TimeFillerFirebaseService.decreaseTimeFillerCounter()",
              message: "Could not found a speaker speech record"),
        );
      }
      return Success.unit();
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location: "TimeFillerFirebaseService.decreaseTimeFillerCounter()",
            message: e.message ??
                "Database Error While deleting latest time filler data"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location: "TimingRoleFirebaseSerivce.decreaseTimeFillerCounter()",
            message: e.toString()),
      );
    }
  }

  @override
  Future<Result<Map<String, int>, Failure>> getSpeakerTimeFillerData(
      {required bool currentSpeakerisAppGuest,
      String? currentSpeakerToastmasterId,
      String? currentSpeakerGuestInvitationCode,
      String? chapterMeetingInvitationCode,
      String? chapterMeetingId}) async {
    try {
      Map<String, int> timeFillerSpeakerData = {};
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
        CollectionReference timeFillerDataC = onlineSessionCapturedDataQS
            .docs.first.reference
            .collection("TimeFillersCapturedData");
        QuerySnapshot timeFillerDataQS = await timeFillerDataC.get();

        for (var doc in timeFillerDataQS.docs) {
          String typeOfTimeFiller = doc.get('typeOfTimeFiller') as String;
          timeFillerSpeakerData.update(typeOfTimeFiller, (value) => value + 1,
              ifAbsent: () => 1);
        }
      } else {
        return const Error(
          Failure(
              code: "No-Speaker-Found",
              location: "TimeFillerFirebaseService.getSpeakerTimeFillerData()",
              message: "Could not found a speaker speech record"),
        );
      }
      return Success(timeFillerSpeakerData);
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location: "TimeFillerFirebaseService.getSpeakerTimeFillerData()",
            message: e.message ??
                "Database Error While getting speaker time filler data"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location: "TimeFillerFirebaseService.getSpeakerTimeFillerData()",
            message: e.toString()),
      );
    }
  }

  @override
  Stream<Map<String, int>> getSpeakerTimeFillerLiveData(
      {required bool currentSpeakerisAppGuest,
      String? currentSpeakerToastmasterId,
      String? currentSpeakerGuestInvitationCode,
      String? chapterMeetingInvitationCode,
      String? chapterMeetingId}) async* {
    Stream<Map<String, int>> timeFillerLiveData = Stream.empty();
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
        CollectionReference timeFillerC = onlineSessionCapturedDataQS
            .docs.first.reference
            .collection("TimeFillersCapturedData");
        // Create a stream transformer to convert the QuerySnapshot to Map<String, int>
        StreamTransformer<QuerySnapshot<Map<String, dynamic>>, Map<String, int>>
            transformer = StreamTransformer.fromHandlers(handleData:
                (QuerySnapshot<Map<String, dynamic>> snapshot,
                    EventSink<Map<String, int>> sink) {
          // Create an empty map
          Map<String, int> countMap = {};
          // Iterate over the documents
          for (var doc in snapshot.docs) {
            // Get the value of the 'typeOfTimeFiller' field
            String typeOfTimeFiller = doc.get('typeOfTimeFiller') as String;

            // Increment the count for the typeOfTimeFiller in the map
            countMap.update(typeOfTimeFiller, (value) => value + 1,
                ifAbsent: () => 1);
          }

          // Emit the count map
          sink.add(countMap);
        });
        timeFillerLiveData = timeFillerC.snapshots().transform(transformer);
      }

      yield* timeFillerLiveData;
    } on FirebaseException catch (e) {
      log("${e.code} ${e.message}");
      yield* timeFillerLiveData;
    } catch (e) {
      log(e.toString());
      yield* timeFillerLiveData;
    }
  }

  @override
  Stream<int> getTotalNumberOfTimeFillers(
      {required bool currentSpeakerisAppGuest,
      String? currentSpeakerToastmasterId,
      String? currentSpeakerGuestInvitationCode,
      String? chapterMeetingInvitationCode,
      String? chapterMeetingId}) async* {
    Stream<int> timeFillersCounter = Stream.empty();
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
        CollectionReference timeFillerC = onlineSessionCapturedDataQS
            .docs.first.reference
            .collection("TimeFillersCapturedData");

        timeFillersCounter = timeFillerC.snapshots().map(
          (QuerySnapshot snapshot) {
            return snapshot.size;
          },
        );
      }

      yield* timeFillersCounter;
    } on FirebaseException catch (e) {
      log("${e.code} ${e.message}");
      yield* timeFillersCounter;
    } catch (e) {
      log(e.toString());
      yield* timeFillersCounter;
    }
  }
}
