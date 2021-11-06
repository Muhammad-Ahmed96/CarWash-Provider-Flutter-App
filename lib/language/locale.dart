import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'languages/italian.dart';
import 'languages/portuguese.dart';
import 'languages/arabic.dart';
import 'languages/english.dart';
import 'languages/french.dart';
import 'languages/indonesian.dart';
import 'languages/spanish.dart';
import 'languages/swahili.dart';
import 'languages/turkish.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': english(),
    'ar': arabic(),
    'pt': portuguese(),
    'fr': french(),
    'id': indonesian(),
    'es': spanish(),
    'tr': turkish(),
    'it': italian(),
    'sw': swahili()
  };

  String? get selectCountry {
    return _localizedValues[locale.languageCode]!['selectCountry'];
  }

  String? get more {
    return _localizedValues[locale.languageCode]!['more'];
  }

  String? get bookedBy {
    return _localizedValues[locale.languageCode]!['bookedBy'];
  }

  String? get vehicle {
    return _localizedValues[locale.languageCode]!['vehicle'];
  }

  String? get totalAmount {
    return _localizedValues[locale.languageCode]!['totalAmount'];
  }

  String? get pickup {
    return _localizedValues[locale.languageCode]!['pickup'];
  }

  String? get driveIn {
    return _localizedValues[locale.languageCode]!['driveIn'];
  }

  String? get orContinueWith {
    return _localizedValues[locale.languageCode]!['orContinueWith'];
  }

  String? get enterMobileNumber {
    return _localizedValues[locale.languageCode]!['enterMobileNumber'];
  }

  String? get facebook {
    return _localizedValues[locale.languageCode]!['facebook'];
  }

  String? get google {
    return _localizedValues[locale.languageCode]!['google'];
  }

  String? get phoneNumber {
    return _localizedValues[locale.languageCode]!['phoneNumber'];
  }

  String? get fullName {
    return _localizedValues[locale.languageCode]!['fullName'];
  }

  String? get emailAddress {
    return _localizedValues[locale.languageCode]!['emailAddress'];
  }

  String? get continuee {
    return _localizedValues[locale.languageCode]!['continuee'];
  }

  String? get enterVerificationCodeWeveSent {
    return _localizedValues[locale.languageCode]!
        ['enterVerificationCodeWeveSent'];
  }

  String? get enterVerificationCode {
    return _localizedValues[locale.languageCode]!['enterVerificationCode'];
  }

  String? get myBookings {
    return _localizedValues[locale.languageCode]!['myBookings'];
  }

  String? get myCars {
    return _localizedValues[locale.languageCode]!['myCars'];
  }

  String? get favourites {
    return _localizedValues[locale.languageCode]!['favourites'];
  }

  String? get selectCar {
    return _localizedValues[locale.languageCode]!['selectCar'];
  }

  String? get services {
    return _localizedValues[locale.languageCode]!['services'];
  }

  String? get when {
    return _localizedValues[locale.languageCode]!['when'];
  }

  String? get serviceLocation {
    return _localizedValues[locale.languageCode]!['serviceLocation'];
  }

  String? get home {
    return _localizedValues[locale.languageCode]!['home'];
  }

  String? get office {
    return _localizedValues[locale.languageCode]!['office'];
  }

  String? get other {
    return _localizedValues[locale.languageCode]!['other'];
  }

  String? get logout {
    return _localizedValues[locale.languageCode]!['logout'];
  }

  String? get submit {
    return _localizedValues[locale.languageCode]!['submit'];
  }

  String? get resend {
    return _localizedValues[locale.languageCode]!['resend'];
  }

  String? get distance {
    return _localizedValues[locale.languageCode]!['distance'];
  }

  String? get cost {
    return _localizedValues[locale.languageCode]!['cost'];
  }

  String? get bookNow {
    return _localizedValues[locale.languageCode]!['bookNow'];
  }

  String? get proceedToPay {
    return _localizedValues[locale.languageCode]!['proceedToPay'];
  }

  String? get hello {
    return _localizedValues[locale.languageCode]!['hello'];
  }

  String? get viewAll {
    return _localizedValues[locale.languageCode]!['viewAll'];
  }

  String? get selectProvider {
    return _localizedValues[locale.languageCode]!['selectProvider'];
  }

  String? get carSelected {
    return _localizedValues[locale.languageCode]!['carSelected'];
  }

  String? get arrangePickupAndDrop {
    return _localizedValues[locale.languageCode]!['arrangePickupAndDrop'];
  }

  String? get serviceProviderWillpickup {
    return _localizedValues[locale.languageCode]!['serviceProviderWillpickup'];
  }

  String? get selectPickupAddress {
    return _localizedValues[locale.languageCode]!['selectPickupAddress'];
  }

  String? get datetime {
    return _localizedValues[locale.languageCode]!['datetime'];
  }

  String? get servicesSelected {
    return _localizedValues[locale.languageCode]!['servicesSelected'];
  }

  String? get processToPayment {
    return _localizedValues[locale.languageCode]!['processToPayment'];
  }

  String? get registerNow {
    return _localizedValues[locale.languageCode]!['registerNow'];
  }

  String? get setLocation {
    return _localizedValues[locale.languageCode]!['setLocation'];
  }

  String? get reviews {
    return _localizedValues[locale.languageCode]!['reviews'];
  }

  String? get comfirmBooking {
    return _localizedValues[locale.languageCode]!['comfirmBooking'];
  }

  String? get amountPayable {
    return _localizedValues[locale.languageCode]!['amountPayable'];
  }

  String? get payment {
    return _localizedValues[locale.languageCode]!['payment'];
  }

  String? get selectPaymentMethods {
    return _localizedValues[locale.languageCode]!['selectPaymentMethods'];
  }

  String? get payNow {
    return _localizedValues[locale.languageCode]!['payNow'];
  }

  String? get bookingConfirmed {
    return _localizedValues[locale.languageCode]!['bookingConfirmed'];
  }

  String? get sitBackAndRelax {
    return _localizedValues[locale.languageCode]!['sitBackAndRelax'];
  }

  String? get haveAGreatDay {
    return _localizedValues[locale.languageCode]!['haveAGreatDay'];
  }

  String? get viewMore {
    return _localizedValues[locale.languageCode]!['viewMore'];
  }

  String? get rateNow {
    return _localizedValues[locale.languageCode]!['rateNow'];
  }

  String? get bookingFor {
    return _localizedValues[locale.languageCode]!['bookingFor'];
  }

  String? get continueToPay {
    return _localizedValues[locale.languageCode]!['continueToPay'];
  }

  String? get readAll {
    return _localizedValues[locale.languageCode]!['readAll'];
  }

  String? get viewProfile {
    return _localizedValues[locale.languageCode]!['viewProfile'];
  }

  String? get cancel {
    return _localizedValues[locale.languageCode]!['cancel'];
  }

  String? get letUsKnowUrFeedbacks {
    return _localizedValues[locale.languageCode]!['letUsKnowUrFeedbacks'];
  }

  String? get submitReview {
    return _localizedValues[locale.languageCode]!['submitReview'];
  }

  String? get openingHours {
    return _localizedValues[locale.languageCode]!['openingHours'];
  }

  String? get openNow {
    return _localizedValues[locale.languageCode]!['openNow'];
  }

  String? get getDirection {
    return _localizedValues[locale.languageCode]!['getDirection'];
  }

  String? get peopleRated {
    return _localizedValues[locale.languageCode]!['peopleRated'];
  }

  String? get orderPlaced {
    return _localizedValues[locale.languageCode]!['orderPlaced'];
  }

  String? get savedAddresses {
    return _localizedValues[locale.languageCode]!['savedAddresses'];
  }

  String? get addNewLocation {
    return _localizedValues[locale.languageCode]!['addNewLocation'];
  }

  String? get selectAddressType {
    return _localizedValues[locale.languageCode]!['selectAddressType'];
  }

  String? get enterAddressDetails {
    return _localizedValues[locale.languageCode]!['enterAddressDetails'];
  }

  String? get myOrders {
    return _localizedValues[locale.languageCode]!['myOrders'];
  }

  String? get cashOnDelivery {
    return _localizedValues[locale.languageCode]!['cashOnDelivery'];
  }

  String? get payPal {
    return _localizedValues[locale.languageCode]!['payPal'];
  }

  String? get selectPaymentMethod {
    return _localizedValues[locale.languageCode]!['selectPaymentMethod'];
  }

  String? get rating {
    return _localizedValues[locale.languageCode]!['rating'];
  }

  String? get applyNow {
    return _localizedValues[locale.languageCode]!['applyNow'];
  }

  String? get selectDateAndTime {
    return _localizedValues[locale.languageCode]!['selectDateAndTime'];
  }

  String? get selectDate {
    return _localizedValues[locale.languageCode]!['selectDate'];
  }

  String? get selectTime {
    return _localizedValues[locale.languageCode]!['Select time'];
  }

  String? get selectCarBrand {
    return _localizedValues[locale.languageCode]!['selectCarBrand'];
  }

  String? get selectCarModel {
    return _localizedValues[locale.languageCode]!['selectCarModel'];
  }

  String? get selectCarType {
    return _localizedValues[locale.languageCode]!['selectCarType'];
  }

  String? get addCarNumber {
    return _localizedValues[locale.languageCode]!['addCarNumber'];
  }

  String? get saveCarInfo {
    return _localizedValues[locale.languageCode]!['saveCarInfo'];
  }

  String? get wereHappyToHear {
    return _localizedValues[locale.languageCode]!['wereHappyToHear'];
  }

  String? get letUsKnowQueriesAndFeedbacks {
    return _localizedValues[locale.languageCode]!
        ['letUsKnowQueriesAndFeedbacks'];
  }

  String? get sendYourMessage {
    return _localizedValues[locale.languageCode]!['sendYourMessage'];
  }

  String? get callUs {
    return _localizedValues[locale.languageCode]!['callUs'];
  }

  String? get mailUs {
    return _localizedValues[locale.languageCode]!['mailUs'];
  }

  String? get yourMessage {
    return _localizedValues[locale.languageCode]!['yourMessage'];
  }

  String? get about {
    return _localizedValues[locale.languageCode]!['about'];
  }

  String? get address {
    return _localizedValues[locale.languageCode]!['address'];
  }

  String? get location {
    return _localizedValues[locale.languageCode]!['location'];
  }

  String? get days {
    return _localizedValues[locale.languageCode]!['days'];
  }

  String? get addNewAddress {
    return _localizedValues[locale.languageCode]!['addNewAddress'];
  }

  String? get saved {
    return _localizedValues[locale.languageCode]!['saved'];
  }

  String? get termsAndCond {
    return _localizedValues[locale.languageCode]!['termsAndCond'];
  }

  String? get saveAddress {
    return _localizedValues[locale.languageCode]!['saveAddress'];
  }

  String? get contactUs {
    return _localizedValues[locale.languageCode]!['contactUs'];
  }

  String? get myAddresses {
    return _localizedValues[locale.languageCode]!['myAddresses'];
  }

  String? get changeLanguage {
    return _localizedValues[locale.languageCode]!['changeLanguage'];
  }

  String? get selectLanguage {
    return _localizedValues[locale.languageCode]!['selectLanguage'];
  }

  String? get register {
    return _localizedValues[locale.languageCode]!['register'];
  }

  String? get enterName {
    return _localizedValues[locale.languageCode]!['enterName'];
  }

  String? get verification {
    return _localizedValues[locale.languageCode]!['verification'];
  }

  String? get enterCode {
    return _localizedValues[locale.languageCode]!['enterCode'];
  }

  String? get dummyAddress1 {
    return _localizedValues[locale.languageCode]!['dummyAddress1'];
  }

  String? get dummyStore1 {
    return _localizedValues[locale.languageCode]!['dummyStore1'];
  }

  String? get dummyStore2 {
    return _localizedValues[locale.languageCode]!['dummyStore2'];
  }

  String? get save {
    return _localizedValues[locale.languageCode]!['save'];
  }

  String? get carPolish {
    return _localizedValues[locale.languageCode]!['carPolish'];
  }

  String? get dummyTime {
    return _localizedValues[locale.languageCode]!['dummyTime'];
  }

  String? get car1 {
    return _localizedValues[locale.languageCode]!['car1'];
  }

  String? get dummyName1 {
    return _localizedValues[locale.languageCode]!['dummyName1'];
  }

  String? get dummyNumber {
    return _localizedValues[locale.languageCode]!['dummyNumber'];
  }

  String? get contactNumber {
    return _localizedValues[locale.languageCode]!['contactNumber'];
  }

  String? get writeYourNumber {
    return _localizedValues[locale.languageCode]!['writeYourNumber'];
  }

  String? get dummyRating {
    return _localizedValues[locale.languageCode]!['dummyRating'];
  }

  String? get dummyAddress2 {
    return _localizedValues[locale.languageCode]!['dummyAddress2'];
  }

  String? get car2 {
    return _localizedValues[locale.languageCode]!['car2'];
  }

  String? get car1Model {
    return _localizedValues[locale.languageCode]!['car1Model'];
  }

  String? get car2Model {
    return _localizedValues[locale.languageCode]!['car2Model'];
  }

  String? get car1Number {
    return _localizedValues[locale.languageCode]!['car1Number'];
  }

  String? get car2Number {
    return _localizedValues[locale.languageCode]!['car2Number'];
  }

  String? get profile {
    return _localizedValues[locale.languageCode]!['profile'];
  }

  String? get support {
    return _localizedValues[locale.languageCode]!['support'];
  }

  String? get myServices {
    return _localizedValues[locale.languageCode]!['myServices'];
  }

  String? get account {
    return _localizedValues[locale.languageCode]!['account'];
  }

  String? get eng {
    return _localizedValues[locale.languageCode]!['english'];
  }

  String? get profileSetting {
    return _localizedValues[locale.languageCode]!['profileSetting'];
  }

  String? get arab {
    return _localizedValues[locale.languageCode]!['arabic'];
  }

  String? get updateInfo {
    return _localizedValues[locale.languageCode]!['updateInfo'];
  }

  String? get addServices {
    return _localizedValues[locale.languageCode]!['addServices'];
  }

  String? get selectServices {
    return _localizedValues[locale.languageCode]!['selectServices'];
  }

  String? get addServicePrice {
    return _localizedValues[locale.languageCode]!['addServicePrice'];
  }

  String? get closingTime {
    return _localizedValues[locale.languageCode]!['closingTime'];
  }

  String? get frnch {
    return _localizedValues[locale.languageCode]!['french'];
  }

  String? get providerName {
    return _localizedValues[locale.languageCode]!['providerName'];
  }

  String? get prtguese {
    return _localizedValues[locale.languageCode]!['portuguese'];
  }

  String? get addCar {
    return _localizedValues[locale.languageCode]!['addCar'];
  }

  String? get convertible {
    return _localizedValues[locale.languageCode]!['convertible'];
  }

  String? get addReview {
    return _localizedValues[locale.languageCode]!['addReview'];
  }

  String? get serviceProvider {
    return _localizedValues[locale.languageCode]!['serviceProvider'];
  }

  String? get homeb {
    return _localizedValues[locale.languageCode]!['homeb'];
  }

  String? get dummyDate1 {
    return _localizedValues[locale.languageCode]!['dummyDate1'];
  }

  String? get dummyTime1 {
    return _localizedValues[locale.languageCode]!['dummyTime1'];
  }

  String? get bodywash {
    return _localizedValues[locale.languageCode]!['bodywash'];
  }

  String? get interiorCleaning {
    return _localizedValues[locale.languageCode]!['interiorCleaning'];
  }

  String? get engineDetailing {
    return _localizedValues[locale.languageCode]!['engineDetailing'];
  }

  String? get pickUpAndDropCharges {
    return _localizedValues[locale.languageCode]!['pickUpAndDropCharges'];
  }

  String? get amountPaid {
    return _localizedValues[locale.languageCode]!['amountPaid'];
  }

  String? get dummyOpeningTime {
    return _localizedValues[locale.languageCode]!['dummyOpeningTime'];
  }

  String? get lorem {
    return _localizedValues[locale.languageCode]!['lorem'];
  }

  String? get creditCard {
    return _localizedValues[locale.languageCode]!['creditCard'];
  }

  String? get addNewCar {
    return _localizedValues[locale.languageCode]!['addNewCar'];
  }

  String? get tapToAdd {
    return _localizedValues[locale.languageCode]!['tapToAdd'];
  }

  String? get sun {
    return _localizedValues[locale.languageCode]!['sun'];
  }

  String? get mon {
    return _localizedValues[locale.languageCode]!['mon'];
  }

  String? get tue {
    return _localizedValues[locale.languageCode]!['tue'];
  }

  String? get wed {
    return _localizedValues[locale.languageCode]!['wed'];
  }

  String? get thr {
    return _localizedValues[locale.languageCode]!['thr'];
  }

  String? get fri {
    return _localizedValues[locale.languageCode]!['fri'];
  }

  String? get sat {
    return _localizedValues[locale.languageCode]!['sat'];
  }

  String? get june {
    return _localizedValues[locale.languageCode]!['june'];
  }

  String? get am {
    return _localizedValues[locale.languageCode]!['am'];
  }

  String? get pm {
    return _localizedValues[locale.languageCode]!['pm'];
  }

  String? get searchLocation {
    return _localizedValues[locale.languageCode]!['searchLocation'];
  }

  String? get approx {
    return _localizedValues[locale.languageCode]!['approx'];
  }

  String? get done {
    return _localizedValues[locale.languageCode]!['done'];
  }

  String? get dummyDistance {
    return _localizedValues[locale.languageCode]!['dummyDistance'];
  }

  String? get indonesia {
    return _localizedValues[locale.languageCode]!['indonesian'];
  }

  String? get italy {
    return _localizedValues[locale.languageCode]!['italian'];
  }

  String? get spansh {
    return _localizedValues[locale.languageCode]!['spanish'];
  }

  String? get swahilii {
    return _localizedValues[locale.languageCode]!['swahili'];
  }

  String? get turk {
    return _localizedValues[locale.languageCode]!['turkish'];
  }

  String? get bookingDetails {
    return _localizedValues[locale.languageCode]!['bookingDetails'];
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => [
        'en',
        'ar',
        'id',
        'pt',
        'fr',
        'es',
        'tr',
        'it',
        'sw'
      ].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of AppLocalizations.
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
