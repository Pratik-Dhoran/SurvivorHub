buildscript {
    repositories {
        google()  // Required for Firebase and Android tools
        mavenCentral()  // Required for other dependencies
    }

    dependencies {
        // Updated to the latest AGP version (7.4.2 or higher)
        classpath("com.android.tools.build:gradle:7.4.2")
        
        // Updated to the latest Google services plugin version
        classpath("com.google.gms:google-services:4.3.15")  // Ensure you're using the right version for Firebase
    }
}

allprojects {
    repositories {
        google()  // Required for Firebase
        mavenCentral()  // Required for other dependencies
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
