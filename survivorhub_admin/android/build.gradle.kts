buildscript {
    repositories {
        google()  // Ensure this repository is included
        mavenCentral()
    }
    dependencies {
        // ✅ Required for Firebase
        classpath("com.google.gms:google-services:4.4.0")  // Firebase classpath
    }
}

allprojects {
    repositories {
        google()  // Ensure this repository is included
        mavenCentral()
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
