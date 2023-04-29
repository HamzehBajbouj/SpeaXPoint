import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:multiple_result/src/unit.dart';
import 'package:speaxpoint/models/annoucement/announcement.dart';
import 'package:speaxpoint/models/annoucement/chapter_meeting_announcement.dart';
import 'package:speaxpoint/services/failure.dart';
import 'package:multiple_result/src/result.dart';
import 'package:speaxpoint/services/meeting_arrangement/common_services/meeting_arrangement_common_firebase_services.dart';
import 'package:speaxpoint/services/meeting_arrangement/manage_announcements/i_manage_chapter_meeting_announcements_service.dart';
import 'package:speaxpoint/util/constants/common_enums.dart';

class ManageChapterMeetingAnnouncementsFirebaseService
    extends MeetingArrangementCommonFirebaseServices
    implements IManageChapterMeeingAnnouncementsService {
  final CollectionReference _announcementCollection =
      FirebaseFirestore.instance.collection("Announcements");
  final FirebaseStorage storage = FirebaseStorage.instance;
  final CollectionReference _chapterMeetingsCollection =
      FirebaseFirestore.instance.collection('ChapterMeetings');
  @override
  Future<Result<Announcement, Failure>> getVolunteersAnnouncement(
      {required String chapterMeetingId}) async {
    try {
      Announcement volunteerAnnouncement = Announcement();
      QuerySnapshot announcementQS = await _announcementCollection
          .where("chapterMeetingId", isEqualTo: chapterMeetingId)
          .where("annoucementType",
              isEqualTo: AnnouncementType.VolunteersAnnouncement.name)
          .get();

      if (announcementQS.docs.isNotEmpty) {
        volunteerAnnouncement = Announcement.fromJson(
            announcementQS.docs.first.data() as Map<String, dynamic>);
      } else {
        return const Error(
          Failure(
              code: 'no-chapter-meeting-is-found',
              location:
                  "ManageChapterMeetingAnnouncementsFirebaseService.getVolunteersAnnouncement()",
              message:
                  "It seems the app can't find the chapter meeting record in the databases."),
        );
      }
      return Success(volunteerAnnouncement);
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location:
                "ManageChapterMeetingAnnouncementsFirebaseService.getVolunteersAnnouncement()",
            message: e.message ??
                "Database Error While fetching volunteers announcement details"),
      );
    } catch (e) {
      return Error(
        Failure(
          code: e.toString(),
          location:
              "ManageChapterMeetingAnnouncementsFirebaseService.getVolunteersAnnouncement()",
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Stream<List<Map<String, dynamic>>> getAllChapterMeetingAnnouncements(
      {required String chapterMeetingId}) async* {
    Stream<List<Map<String, dynamic>>> announcements = Stream.empty();
    try {
      var announcementgQS = _announcementCollection
          .where("chapterMeetingId", isEqualTo: chapterMeetingId)
          .snapshots();
      announcements = announcementgQS.map(
        (QuerySnapshot querySnapshot) => querySnapshot.docs
            .map(
              (e) => e.data() as Map<String, dynamic>,
            )
            .toList(),
      );

      yield* announcements;
    } on FirebaseException catch (e) {
      log("${e.code} ${e.message}");
      yield* announcements;
    } catch (e) {
      log(e.toString());
      yield* announcements;
    }
  }

  @override
  Future<Result<Unit, Failure>> deletePublishedAnnouncement(
      {required String chapterMeetingId,
      required String announcementType}) async {
    try {
      QuerySnapshot announcementQS = await _announcementCollection
          .where("chapterMeetingId", isEqualTo: chapterMeetingId)
          .where("annoucementType", isEqualTo: announcementType)
          .get();

      if (announcementQS.docs.isNotEmpty) {
        await announcementQS.docs.first.reference.delete().then(
          (_) async {
            if (announcementType ==
                AnnouncementType.ChapterMeetingAnnouncement.name) {
              QuerySnapshot chapterMeetingsQS = await _chapterMeetingsCollection
                  .where('chapterMeetingId', isEqualTo: chapterMeetingId)
                  .get();
              if (chapterMeetingsQS.docs.isNotEmpty) {
                await chapterMeetingsQS.docs.first.reference.update(
                  {'chapterMeetingStatus': ComingSessionsStatus.Pending.name},
                );
              }
            }
          },
        );
        //then delete the brushure from the storgae
        final ref = storage.ref(
            'chpaterMeetingsAnnouncements/chapterAnnouncementBrushure_$chapterMeetingId');
        await ref.delete().then((_) {
          //we need to handle the try and catch for this statemenet as this, otherwise
          //it might effect the entire deletePublishedAnnouncement return results.
          log('File deleted successfully');
        }).catchError(
          (error) {
            if (error.code == 'storage/object-not-found') {
              log('File does not exist');
            } else {
              log('Error deleting file: $error');
            }
          },
        );
      } else {
        return Error(
          Failure(
              code: 'No-Announcement-Found',
              location:
                  "ManageChapterMeetingAnnouncementsFirebaseService.deletePublishedAnnouncement()",
              message:
                  "It seems there is no annoucement record for $announcementType in the databases."),
        );
      }
      return Success.unit();
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location:
                "ManageChapterMeetingAnnouncementsFirebaseService.deletePublishedAnnouncement()",
            message:
                e.message ?? "Database Error While deleting the announcement"),
      );
    } catch (e) {
      return Error(
        Failure(
          code: e.toString(),
          location:
              "ManageChapterMeetingAnnouncementsFirebaseService.deletePublishedAnnouncement()",
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Result<Unit, Failure>> announceChapterMeeting({
    required ChapterMeetingAnnouncement chapterMeetingAnnouncement,
    required File? brochureFile,
    required String chapterMeetingId,
  }) async {
    try {
      if (brochureFile != null) {
        UploadTask uploadTask = storage
            .ref(
                "chpaterMeetingsAnnouncements/chapterAnnouncementBrushure_${chapterMeetingAnnouncement.chapterMeetingId}")
            .putFile(brochureFile);
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        chapterMeetingAnnouncement.brushureLink = downloadUrl;
      }

      await _announcementCollection
          .add(chapterMeetingAnnouncement.toJson())
          .then(
        (_) async {
          QuerySnapshot chapterMeetingsQS = await _chapterMeetingsCollection
              .where('chapterMeetingId', isEqualTo: chapterMeetingId)
              .get();
          if (chapterMeetingsQS.docs.isNotEmpty) {
            await chapterMeetingsQS.docs.first.reference.update(
              {'chapterMeetingStatus': ComingSessionsStatus.Coming.name},
            );
          }
        },
      );
      return Success.unit();
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location:
                "ManageChapterMeetingAnnouncementsFirebaseService.announceChapterMeeting()",
            message: e.message ??
                "Database Error While announcing the chapter meeting"),
      );
    } catch (e) {
      return Error(
        Failure(
          code: e.toString(),
          location:
              "ManageChapterMeetingAnnouncementsFirebaseService.announceChapterMeeting()",
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Result<ChapterMeetingAnnouncement, Failure>>
      getChapterMeetingAnnouncement({required String chapterMeetingId}) async {
    try {
      ChapterMeetingAnnouncement chapterMeetingAnnouncement =
          ChapterMeetingAnnouncement();
      QuerySnapshot announcementQS = await _announcementCollection
          .where("chapterMeetingId", isEqualTo: chapterMeetingId)
          .where("annoucementType",
              isEqualTo: AnnouncementType.ChapterMeetingAnnouncement.name)
          .get();

      if (announcementQS.docs.isNotEmpty) {
        chapterMeetingAnnouncement = ChapterMeetingAnnouncement.fromJson(
            announcementQS.docs.first.data() as Map<String, dynamic>);
      } else {
        return const Error(
          Failure(
              code: 'no-chapter-meeting-is-found',
              location:
                  "ManageChapterMeetingAnnouncementsFirebaseService.getChapterMeetingAnnouncement()",
              message:
                  "It seems the app can't find the chapter meeting record in the databases."),
        );
      }
      return Success(chapterMeetingAnnouncement);
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location:
                "ManageChapterMeetingAnnouncementsFirebaseService.getChapterMeetingAnnouncement()",
            message: e.message ??
                "Database Error While fetching chapter meeting announcement details"),
      );
    } catch (e) {
      return Error(
        Failure(
          code: e.toString(),
          location:
              "ManageChapterMeetingAnnouncementsFirebaseService.getChapterMeetingAnnouncement()",
          message: e.toString(),
        ),
      );
    }
  }
}
