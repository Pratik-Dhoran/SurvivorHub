plugins {
    kotlin("android") version "1.8.22"
    id("com.android.application")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")  // Add this line for Firebase services
}

android {
    namespace = "com.example.survivor_hub"  // Set namespace for Android Gradle Plugin (AGP) compatibility
    compileSdk = 35  // Update if your flutter.compileSdkVersion is different

    // Set the NDK version if necessary
    ndkVersion = "27.0.12077973"  // Match the NDK version requirement if necessary

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.survivor_hub"
        minSdk = 21  // Update if your flutter.minSdkVersion is different
        targetSdk = 33  // Update if your flutter.targetSdkVersion is different
        versionCode = 1
        versionName = "1.0.0"
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")  // Use proper signing configurations for release
        }
    }
}

flutter {
    source = "../.."  // Set the source path for the Flutter project
}
