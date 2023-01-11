QT += quick

SOURCES += \
        main.cpp

resources.files = main.qml
resources.files += ClockPage.qml
resources.files += ConfigurationPage.qml
resources.files += ComposantPageConfiguration.qml
resources.files += src/dauwn_img.png
resources.files += src/day_img.png
resources.files += src/sleeping_img.png
resources.files += src/sieste_img.png
resources.files += src/configuration_img.png
resources.files += src/button_suivant.png
resources.files += src/button_valider.png
resources.prefix = /$${TARGET}
RESOURCES += resources

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    ClockPage.qml \
    ComposantPageConfiguration.qml \
    ConfigurationPage.qml \
    android/AndroidManifest.xml \
    android/build.gradle \
    android/gradle.properties \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew \
    android/gradlew.bat \
    android/res/values/libs.xml \
    android/src/MyActivity.java \
    src/button_suivant.png \
    src/button_valider.png \
    src/configuration_img.png \
    src/dauwn_img.png \
    src/day_img.png \
    src/sieste_img.png \
    src/sleeping_img.png

contains(ANDROID_TARGET_ARCH,arm64-v8a) {
    ANDROID_PACKAGE_SOURCE_DIR = \
        $$PWD/android
}
