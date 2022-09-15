class WhistleFeedModel {
  String? status = '';
  String? message = '';
  Data? data;

  WhistleFeedModel({this.status, this.message, this.data});

  WhistleFeedModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Campaindata>? campgainlist;
  int? uiLimit;

  Data({this.campgainlist, this.uiLimit});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      campgainlist = <Campaindata>[];
      json['data'].forEach((v) {
        campgainlist!.add(new Campaindata.fromJson(v));
      });
    }
    uiLimit = json['ui_limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.campgainlist != null) {
      data['data'] = this.campgainlist!.map((v) => v.toJson()).toList();
    }
    data['ui_limit'] = this.uiLimit;
    return data;
  }
}

class Campaindata {
  String? campaignId;
  String? creativeId;
  String? headline = "";
  String? tracker;
  String? brandname;
  String? uniqueClickId;
  String? cTA;
  int? count;

  Campaindata(
      {this.campaignId,
      this.creativeId,
      this.headline,
      this.tracker,
      this.brandname,
      this.uniqueClickId,
      this.cTA,
      this.count});

  Campaindata.fromJson(Map<String, dynamic> json) {
    campaignId = json['campaign_id'];
    creativeId = json['creative_id'];
    headline = json['headline'];
    tracker = json['tracker'];
    brandname = json['brandname'];
    uniqueClickId = json['unique_click_id'];
    cTA = json['CTA'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['campaign_id'] = this.campaignId;
    data['creative_id'] = this.creativeId;
    data['headline'] = this.headline;
    data['tracker'] = this.tracker;
    data['brandname'] = this.brandname;
    data['unique_click_id'] = this.uniqueClickId;
    data['CTA'] = this.cTA;

    return data;
  }
}
