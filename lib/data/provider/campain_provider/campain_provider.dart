abstract class CampaignProvider {
  Future checkIn({String? idUse, String? dateCheck, String? timeIn});

  Future report({String? topic, String? content});

  Future listKeepingWeek(
      {int? limit,
      int? offset,
      String? idUser,
      String? dateBegin,
      String? dateEnd});

  Future listKeepingMonth(
      {int? limit, int? offset, String? idUser, String? month, String? year});
}
