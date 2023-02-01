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
    platform :ios, '12.0'
    
    
    project.pbxproj
    IPHONEOS_DEPLOYMENT_TARGET = 12.0;
    
    Appframeworkinfo.plist
      <key>MinimumOSVersion</key>
      <string>12.0</string>

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

## Firebase Appcheck
    https://www.youtube.com/watch?v=DEV372Kof0g
    https://www.youtube.com/watch?v=TzLON3oVGE0

    FirebaseAppcheck playintegrity apptest

    build.gradle bom

## FireAuth
    https://pub.dev/packages/google_sign_in
    https://pub.dev/packages/sign_in_with_apple
    https://pub.dev/packages/flutter_facebook_auth
    
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

## Publish
    https://www.youtube.com/watch?v=g0GNuoCOtaQ
    https://www.youtube.com/watch?v=nV1x5-vLPoY&list=PL6yRaaP0WPkVtoeNIGqILtRAgd3h2CNpT&index=49
    https://www.youtube.com/watch?v=8loXUWLBsF0&list=PL6yRaaP0WPkVtoeNIGqILtRAgd3h2CNpT&index=51

## Firebase Cloud Messaging
    https://www.youtube.com/watch?v=P51dI2y7QHA

    https://firebase.flutter.dev/docs/messaging/notifications/
    https://firebase.google.com/docs/cloud-messaging/ios/send-image

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

## Stripe
    style.xml -> <style name="LaunchTheme" parent="Theme.AppCompat.Light.NoActionBar">
    style.xml -> <style name="LaunchTheme" parent="Theme.AppCompat.DayNight.NoActionBar">
    https://github.com/flutter-stripe/flutter_stripe/blob/main/example/android/app/src/main/res/values/styles.xml
    https://github.com/flutter-stripe/flutter_stripe/blob/main/example/android/app/src/main/res/values-night/styles.xml
    
    MainActivity.kt -> FlutterFragmentActivity

## Google Maps
    Google Maps : Enable Google Map SDK for each platform : Billing account
    google_maps_flutter
    
    https://developers.google.com/maps/gmp-get-started
    
    https://github.com/flutter/plugins/tree/main/packages/google_maps_flutter/google_maps_flutter/example/lib
    
    https://pub.dev/packages/google_maps_flutter
    
    https://codelabs.developers.google.com/codelabs/google-maps-in-flutter#0
    
    Map : https://www.youtube.com/watch?v=tfFByL7F-00
          https://www.youtube.com/watch?v=hgIVDqDCFbk
          https://www.youtube.com/watch?v=mVI_PiB7fyw
          https://www.youtube.com/watch?v=B9hsWOCXb_o
          https://www.youtube.com/watch?v=zLxoVC6jUPw
          https://www.youtube.com/watch?v=R4PxkSYQmec
    
    Places Api autecomplete: https://www.youtube.com/watch?v=3CO8pGw7fzY
    
    https://pub.dev/packages/geolocator
    https://pub.dev/packages/geocoding
    https://www.youtube.com/watch?v=PDriZznSzVI
    https://www.digitalocean.com/community/tutorials/flutter-geolocator-plugin#prerequisites
    
    https://pub.dev/packages/location
    https://blog.logrocket.com/geolocation-geocoding-flutter/

## Splash - Icons
    https://pub.dev/packages/flutter_native_splash
    https://pub.dev/packages/flutter_launcher_icons
    
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

## Android Deployment
    https://docs.flutter.dev/deployment/android