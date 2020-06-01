import 'dart:convert';

class MacVendorModel {
    String oui;
    bool isPrivate;
    String companyName;
    String companyAddress;
    String countryCode;
    String assignmentBlockSize;
    DateTime dateCreated;
    DateTime dateUpdated;

    MacVendorModel({
        this.oui,
        this.isPrivate,
        this.companyName,
        this.companyAddress,
        this.countryCode,
        this.assignmentBlockSize,
        this.dateCreated,
        this.dateUpdated,
    });

    factory MacVendorModel.fromRawJson(String str) => MacVendorModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MacVendorModel.fromJson(Map<String, dynamic> json) => MacVendorModel(
        oui: json['oui'],
        isPrivate: json['isPrivate'],
        companyName: json['companyName'],
        companyAddress: json['companyAddress'],
        countryCode: json['countryCode'],
        assignmentBlockSize: json['assignmentBlockSize'],
        dateCreated: DateTime.parse(json['dateCreated']),
        dateUpdated: DateTime.parse(json['dateUpdated']),
    );

    Map<String, dynamic> toJson() => {
        'oui': oui,
        'isPrivate': isPrivate,
        'companyName': companyName,
        'companyAddress': companyAddress,
        'countryCode': countryCode,
        'assignmentBlockSize': assignmentBlockSize,
        'dateCreated': "${dateCreated.year.toString().padLeft(4, '0')}-${dateCreated.month.toString().padLeft(2, '0')}-${dateCreated.day.toString().padLeft(2, '0')}",
        'dateUpdated': "${dateUpdated.year.toString().padLeft(4, '0')}-${dateUpdated.month.toString().padLeft(2, '0')}-${dateUpdated.day.toString().padLeft(2, '0')}",
    };
}