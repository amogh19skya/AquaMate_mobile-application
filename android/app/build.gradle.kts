plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.aqua_mate"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        // ⭐ 1. CHANGE JAVA VERSION TO 1.8 (if using older Kotlin/Flutter) OR KEEP 11
        //    AND ADD DESUGARING FLAG
        sourceCompatibility = JavaVersion.VERSION_1_8 // Changed from VERSION_11 for compatibility
        targetCompatibility = JavaVersion.VERSION_1_8 // Changed from VERSION_11 for compatibility

        // ⭐ 2. ENABLE CORE LIBRARY DESUGARING
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        // ⭐ 3. ENSURE JVM TARGET IS 1.8
        jvmTarget = "1.8" // Changed from VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.aqua_mate"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

// ⭐ 4. ADD THE DESUGARING DEPENDENCY BLOCK AT THE END
dependencies {
    // Add the desugaring library dependency
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}