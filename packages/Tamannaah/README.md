# Tamannaah

<p align="center">
    <img src="https://octodex.github.com/images/manufacturetocat.png" alt="drawing" width="300"/>
</p>

Developed with 💙 by 🦄

---

## Ios Usage
    cd ios
    pod cache clean --all
    flutter clean && rm ios/Podfile.lock pubspec.lock && rm -rf ios/Pods ios/Runner.xcworkspace
    pod deintegrate
    pod setup
    pod install
    pod repo update
    <!-- brew update -->
    <!-- brew install cocoapods -->
    <!-- gem install cocoapods -->
    pod repo update
    pod -–version
    pod install --verbose
    pod update Firebase
    
    ios/podfile
    platform :ios, '15.0'
    
    
    project.pbxproj
    IPHONEOS_DEPLOYMENT_TARGET = 15.0;
    
    Appframeworkinfo.plist
      <key>MinimumOSVersion</key>
      <string>15.0</string>


    https://docs.flutter.dev/deployment/ios#review-xcode-project-settings
    
    flutter build ipa

## Android Version
    **Change AndroidSdkVersion in build.gradle and local.properties and enable multidex
    https://youtu.be/5oUE25tj5aQ?list=PLCOnzDflrUceRLfHEkl-u2ipjsre6ZwjV&t=643
    **ManifestPlaceholders
    
    local.properties : mode, minsdk, compilesdk, targetsdk, version
    localProperties.getProperty('flutter.compileSdkVersion').toInteger()
    
    flutter.minSdkVersion=26
    flutter.targetSdkVersion=28
    flutter.compileSdkVersion=33
    flutter.buildMode=debug
    flutter.versionName=1.0.0
    flutter.versionCode=1

    https://docs.flutter.dev/deployment/android

## Intl
    l10n.yaml in root
        arb-dir: lib/l10n
        template-arb-file: app_en.arb
        output-localization-file: loki.dart
        output-class: Loki

    l10n folder in lib
        app_en.arb

    flutter gen-l10n

    flutter_localizations:
        sdk: flutter
    
    flutter
        generate : true

    import 'package:flutter_gen/gen_l10n/loki.dart';
    localizationsDelegates: Loki.localizationsDelegates,
    supportedLocales: Loki.supportedLocales,

    ios : add to info.plist
    
    <key>CFBundleLocalizations</key>
    <array>
    	<string>en</string>
    	<string>sv</string>
    </array>

## Google Codelabs
    https://codelabs.developers.google.com/?product=firebase%2Cflutter

## Firebase Appcheck
    https://www.youtube.com/watch?v=DEV372Kof0g
    https://www.youtube.com/watch?v=TzLON3oVGE0

    https://firebase.google.com/learn/pathways/firebase-app-check

    https://firebase.google.com/codelabs/app-attest

    FirebaseAppcheck playintegrity apptest

    build.gradle bom

## Firebase Security Rules
    https://firebase.google.com/codelabs/firebase-rules
    
    https://www.youtube.com/watch?v=VDulvfBpzZE
    https://www.youtube.com/watch?v=8Mzb9zmnbJs

## FireAuth
    https://pub.dev/packages/google_sign_in
    https://pub.dev/packages/sign_in_with_apple
    https://pub.dev/packages/flutter_facebook_auth

    https://youtu.be/vtGCteFYs4M?list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=14879

    https://firebase.google.com/docs/auth/android/google-signin
    https://firebase.google.com/docs/auth/android/facebook-login
    https://firebase.google.com/docs/auth/android/apple

    https://firebase.google.com/docs/auth/ios/google-signin
    https://firebase.google.com/docs/auth/ios/facebook-login
    https://firebase.google.com/docs/auth/ios/apple

    https://firebase.google.com/docs/auth/flutter/federated-auth

    https://www.chqbook.com/facebook-data-deletion-instructions-url/

    https://www.youtube.com/watch?v=IzyOdKm0bWE
    https://www.youtube.com/watch?v=HyiNbqLOCQ8&t=63s
    https://www.youtube.com/watch?v=q-9lx7aSWcc&t=705s

    firebase console sha

    https://developers.google.com/android/guides/client-auth?authuser=0&hl=en
    cmd.exe
    cd android
    gradlew.bat
    gradlew.bat signingReport
    
    gcp api enable
    ios integration

## Build Runner : 
    flutter pub run build_runner build --delete-conflicting-outputs

## Permission Handler : 
    https://pub.dev/packages/permission_handler

## Publish
    https://www.youtube.com/watch?v=g0GNuoCOtaQ
    
    https://www.youtube.com/watch?v=DLvdZtTAJrE

    https://www.youtube.com/watch?v=KEkk0k4pws8&list=PL_D-RntzgLvbbB7Uub06wW44znOoWJro4&index=59

    https://www.youtube.com/watch?v=nV1x5-vLPoY&list=PL6yRaaP0WPkVtoeNIGqILtRAgd3h2CNpT&index=49
    https://www.youtube.com/watch?v=8loXUWLBsF0&list=PL6yRaaP0WPkVtoeNIGqILtRAgd3h2CNpT&index=51

    https://developer.apple.com/programs/enroll/
    https://developer.apple.com/help/app-store-connect/
    https://learn.buildfire.com/en/articles/3345275-how-to-transfer-your-app-from-one-apple-developer-account-to-another

## Firebase Cloud Messaging + Notification
    https://developer.android.com/develop/ui/views/notifications

    https://www.youtube.com/watch?v=P51dI2y7QHA

    https://github.com/firebase/functions-samples/tree/main/fcm-notifications

    https://firebase.flutter.dev/docs/messaging/notifications/
    https://firebase.google.com/docs/cloud-messaging/flutter/client
    https://firebase.google.com/docs/cloud-messaging/ios/send-image

    https://github.com/firebase/flutterfire/tree/master/packages/firebase_messaging/firebase_messaging/example/lib

    https://github.com/firebase/quickstart-android/blob/214da24d38a2af723f6953c4f1c18a7ad3d68d08/messaging/app/src/main/AndroidManifest.xml#L24-L26

    https://developer.android.com/develop/ui/views/notifications/notification-permission

    AndroidManifest.xml
    <uses-permission android:name=android.permission.POST_NOTIFICATIONS" />


    <meta-data
        android:name="com.google.firebase.messaging.default_notification_channel_id"
        android:value="cracker_notification" />
    <intent-filter>
        <action android:name="android.intent.action.MAIN"/>
        <category android:name="android.intent.category.LAUNCHER"/>

## Firebase Remote Config
    https://www.youtube.com/watch?v=23T9SGLcDsM

## Flutter_Local_Notification
    https://pub.dev/packages/flutter_local_notifications

    android
    swift permissions

## App_Auth
    manifestPlaceholders += [
        'appAuthRedirectScheme' : "io.dracula.marvel"
    ]

## Admob
    https://www.youtube.com/watch?v=m0d_pbgeeG8    

## Stripe
    flutter_stripe

    https://checkout.stripe.dev/
    https://stripe.com/docs/payments/checkout
    https://stripe.com/docs/payments/accept-a-payment?platform=web&ui=elements
    https://stripe.com/docs/stripe-js/elements/payment-request-button
    https://stripe.com/docs/js/payment_intents/confirm_ideal_payment
    https://stripe.com/docs/api/subscriptions/cancel?lang=node    
    https://stripe.com/docs/billing/subscriptions/overview
    https://stripe.com/docs/billing/subscriptions/usage-based
    https://stripe.com/docs/google-pay?platform=react-native
    https://stripe.com/docs/payments/klarna
    https://stripe.com/en-in/billing

    https://pub.dev/documentation/flutter_stripe/latest/flutter_stripe/Stripe/confirmPayment.html

    https://www.youtube.com/watch?v=tpILK64NM6M

    https://github.com/stripe/stripe-firebase-extensions
    https://firebase.google.com/codelabs/stripe-firebase-extensions#4

    https://pub.dev/packages/pay
    https://www.youtube.com/watch?v=WGE4p6y2r_k
    https://www.youtube.com/watch?v=h8k_pjo7ams

## RevenueCat - InAppPurchase

    https://medium.com/flutter-community/in-app-purchases-with-flutter-a-comprehensive-step-by-step-tutorial-b96065d79a21
    
    https://medium.com/flutter-community/how-to-set-up-in-app-purchases-in-apple-connect-and-google-play-console-28cc2456af3b
    
    https://developer.android.com/google/play/billing
    https://developer.apple.com/in-app-purchase/

    https://pub.dev/packages/in_app_purchase
    https://codelabs.developers.google.com/codelabs/flutter-in-app-purchases#3
    https://blog.codemagic.io/understanding-in-app-purchase-apis-in-flutter/

    https://github.com/RevenueCat/purchases-flutter/tree/main/revenuecat_examples
    https://extensions.dev/extensions/revenuecat/firestore-revenuecat-purchases

    https://www.revenuecat.com/docs
    https://www.revenuecat.com/docs/firebase-integration
    https://www.revenuecat.com/docs/android-products
    https://www.revenuecat.com/docs/ios-products

    https://www.youtube.com/watch?v=31mM8ozGyE8
    https://www.youtube.com/watch?v=WechH9jx41w

    https://www.youtube.com/watch?v=TrkiSZ2mnlo
    https://www.youtube.com/watch?v=h-jOMh2KXTA

## Google Maps
    Google Maps : Enable Google Map SDK for each platform : Billing account
    google_maps_flutter

    https://codelabs.developers.google.com/?product=googlemapsplatform

    https://codelabs.developers.google.com/codelabs/google-maps-in-flutter#0
    
    https://developers.google.com/maps/gmp-get-started
    
    https://github.com/flutter/plugins/tree/main/packages/google_maps_flutter/google_maps_flutter/example/lib
    
    https://pub.dev/packages/google_maps_flutter
    
    Map 
        https://www.youtube.com/watch?v=LnZyorDeLmQ
        https://www.youtube.com/watch?v=MrnA6vpTXik
        https://www.youtube.com/watch?v=tfFByL7F-00
        https://www.youtube.com/watch?v=hgIVDqDCFbk
        https://www.youtube.com/watch?v=mVI_PiB7fyw
        https://www.youtube.com/watch?v=B9hsWOCXb_o
        https://www.youtube.com/watch?v=zLxoVC6jUPw
        https://www.youtube.com/watch?v=R4PxkSYQmec
    
    Places Api autocomplete
        https://www.youtube.com/watch?v=3CO8pGw7fzY
        https://www.youtube.com/watch?v=9rHHD1IwvkE
        https://www.youtube.com/watch?v=QyeBcwET-Ww
        https://www.youtube.com/watch?v=GejRaGkkQYQ
        https://www.youtube.com/playlist?list=PL_D-RntzgLvbhv28GXs0bO8wu84_mnyWV

    https://pub.dev/packages/geolocator
    https://pub.dev/packages/geocoding
    https://www.youtube.com/watch?v=PDriZznSzVI
    https://www.digitalocean.com/community/tutorials/flutter-geolocator-plugin#prerequisites
    
    https://pub.dev/packages/location
    https://blog.logrocket.com/geolocation-geocoding-flutter/

## Splash - Icons
    https://pub.dev/packages/flutter_native_splash
    https://pub.dev/packages/flutter_launcher_icons
    https://pub.dev/packages/flutter_app_badger
    
    https://docs.flutter.dev/development/ui/advanced/splash-screen
    https://developer.android.com/develop/ui/views/launch/splash-screen

## Quick Action
    https://pub.dev/packages/quick_actions
    https://www.youtube.com/watch?v=sqw-taR2_Ww

## Webview
    https://codelabs.developers.google.com/codelabs/flutter-webview#0
    https://www.youtube.com/watch?v=FrqGGw9DYfs
    https://www.youtube.com/watch?v=LyAwnwvbBKM
    https://www.youtube.com/watch?v=SyDo0GqBVYU
    https://www.youtube.com/watch?v=5R3ehXV-oog

## WebRtc
           : https://pub.dev/packages/flutter_webrtc
    zegocloud : 
    Twilio : https://pub.dev/packages/twilio_programmable_video
    Agora  : https://pub.dev/packages/agora_rtc_engine
    Livekit: https://pub.dev/packages/livekit_client
    Vonage : https://github.com/Vonage-Community/sample-video-flutter-app

## Deep Linking + Intents
    https://pub.dev/packages/uni_links
    https://pub.dev/packages/receive_sharing_intent
    https://pub.dev/packages/share_plus

    https://docs.flutter.dev/development/ui/navigation/deep-linking

    https://docs.flutter.dev/cookbook/navigation/set-up-universal-links

    https://www.youtube.com/watch?v=KNAb2XL7k2g
    https://www.youtube.com/watch?v=FjCfIeE1-dU
    https://www.youtube.com/watch?v=gpS723VPuBM

    https://blog.logrocket.com/understanding-deep-linking-flutter-uni-links/

    https://www.youtube.com/watch?v=1qFIg-lz4Ys&list=PLWz5rJ2EKKc-hZMZIfAUMBDR7kPC1m7HU
    https://developer.android.com/guide/components/intents-filters
    https://play.google.com/console/about/deeplinks/
    https://developer.android.com/training/app-links
    https://developer.android.com/training/basics/intents/filters.html
    https://developer.android.com/studio/write/app-link-indexing#testindent

    https://developer.apple.com/ios/universal-links/
    https://developer.apple.com/library/archive/documentation/General/Conceptual/AppSearch/UniversalLinks.html
    https://developer.apple.com/documentation/xcode/defining-a-custom-url-scheme-for-your-app

    Firebase Dynamic Link
        https://www.youtube.com/watch?v=aBrRJqrQTpQ
        https://www.youtube.com/watch?v=SSdAJO2EmBw    

        https://www.youtube.com/watch?v=zra2DCd0DnY
        https://www.youtube.com/watch?v=H4ae9Jv5B3I

        https://www.youtube.com/watch?v=KLBjAg6HvG0
        https://www.youtube.com/watch?v=iSC5ed6OowA
        https://www.youtube.com/watch?v=LqCi-TaUfJs

        https://firebase.flutter.dev/docs/dynamic-links/overview/

        https://github.com/firebase/flutterfire/blob/master/packages/firebase_dynamic_links/firebase_dynamic_links/example/lib/main.dart

## Firebase Analytics
    https://www.youtube.com/watch?v=2F2XhgMt8Dg

## Firebase Crashlytics
    https://www.youtube.com/watch?v=cIFLFpKTy7c
    https://www.youtube.com/watch?v=aIqy-Ulu4Gw

## Error Handling
    https://dartpad.dev/workshops.html?webserver=https://handling-errors-gracefully.web.app
    https://docs.flutter.dev/testing/errors
    https://api.flutter.dev/flutter/dart-async/Zone-class.html
    https://api.flutter.dev/flutter/dart-async/runZonedGuarded.html
    https://pub.dev/packages/catcher
    
    https://docs.flutter.dev/testing/errors#handling-all-types-of-errors

## Design
    m3 design guidlines
    44x44 button, 24x24 icon, 10 pad, 8 margin,
    
    #Google fonts : Mulish

    Lottie Files
        https://lottiefiles.com/95560-error-404
