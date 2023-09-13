import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:speaxpoint/models/club_account.dart';
import 'package:multiple_result/src/unit.dart';
import 'package:multiple_result/src/result.dart';
import 'package:speaxpoint/services/club_profile/i_club_profile_service.dart';
import 'package:speaxpoint/services/failure.dart';

class ClubProfileFirebaseService extends IClubProfileService {
  final CollectionReference _clubAccountsCollection =
      FirebaseFirestore.instance.collection("ClubAccounts");
  final FirebaseStorage storage = FirebaseStorage.instance;
  @override
  Future<Result<ClubAccount, Failure>> getClubProfileData(
      {required String clubId}) async {
    ClubAccount clubAccount;
    try {
      QuerySnapshot clubAccountsQS = await _clubAccountsCollection
          .where("clubId", isEqualTo: clubId)
          .get();

      if (clubAccountsQS.docs.isNotEmpty) {
        clubAccount = ClubAccount.fromJson(
            clubAccountsQS.docs.first.data() as Map<String, dynamic>);
      } else {
        return const Error(
          Failure(
              code: 'no-club-is-found',
              location: "ClubProfileFirebaseService.getClubProfileData()",
              message:
                  "It seems the app can't find the the club record in the databases."),
        );
      }
      return Success(clubAccount);
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location: "ClubProfileFirebaseService.getClubProfileData()",
            message: e.message ?? "Database Error While fetching club details"),
      );
    } catch (e) {
      return Error(
        Failure(
          code: e.toString(),
          location: "ClubProfileFirebaseService.getClubProfileData()",
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Result<Unit, Failure>> updateClubProfileData({
    required String clubId,
    required ClubAccount clubAccount,
    File? profilePhoto,
    File? profileBackground,
  }) async {
    try {
      if (profilePhoto != null) {
        UploadTask uploadTask = storage
            .ref(
                "clubProfiles/${clubAccount.clubId}/profilePhoto_${clubAccount.clubId}")
            .putFile(profilePhoto);
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        clubAccount.profileImageURL = downloadUrl;
      }

      if (profileBackground != null) {
        UploadTask uploadTask = storage
            .ref(
                "clubProfiles/${clubAccount.clubId}/profileBackground_${clubAccount.clubId}")
            .putFile(profileBackground);
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        clubAccount.backgroundImageURL = downloadUrl;
      }
      QuerySnapshot clubAccountsQS = await _clubAccountsCollection
          .where("clubId", isEqualTo: clubId)
          .get();

      if (clubAccountsQS.docs.isNotEmpty) {
        final updateData = {
          "clubName": clubAccount.clubName,
          "profileDescription": clubAccount.profileDescription,
          "webSiteLink": clubAccount.webSiteLink,
          "officialEmail": clubAccount.officialEmail,
          "clubPhoneNumber": clubAccount.clubPhoneNumber,
          "clubLocationLink": clubAccount.clubLocationLink,
          "clubOverviewTitle": clubAccount.clubOverviewTitle,
          "clubOverviewDescription": clubAccount.clubOverviewDescription,
          "clubProfileWasSetUp": clubAccount.clubProfileWasSetUp,
        };

        if (clubAccount.backgroundImageURL != null) {
          updateData["backgroundImageURL"] = clubAccount.backgroundImageURL;
        }

        if (clubAccount.profileImageURL != null) {
          updateData["profileImageURL"] = clubAccount.profileImageURL;
        }

        clubAccountsQS.docs.first.reference.update(updateData);
      } else {
        return const Error(
          Failure(
              code: 'no-club-is-found',
              location: "ClubProfileFirebaseService.getClubProfileData()",
              message:
                  "It seems the app can't find the the club record in the databases."),
        );
      }
      return Success.unit();
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location: "ClubProfileFirebaseService.getClubProfileData()",
            message: e.message ?? "Database Error While fetching club details"),
      );
    } catch (e) {
      return Error(
        Failure(
          code: e.toString(),
          location: "ClubProfileFirebaseService.getClubProfileData()",
          message: e.toString(),
        ),
      );
    }
  }
}
