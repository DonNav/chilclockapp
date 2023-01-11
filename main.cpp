#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QLocale>
#include <QDir>
#include <QGuiApplication>
#include <QSurfaceFormat>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QQmlContext>
#include <QDebug>
#include <QScreen>
#include <QtGlobal>


int main(int argc, char *argv[])
{
//    QGuiApplication app(argc, argv);


#if defined(Q_OS_LINUX) && !defined(Q_OS_ANDROID)
    // Linux requires 3.2 OpenGL Context
    // in order to instance 3D symbols
    QSurfaceFormat fmt = QSurfaceFormat::defaultFormat();
    fmt.setVersion(3, 2);
    QSurfaceFormat::setDefaultFormat(fmt);
#endif
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);



    // Initialize application view
    QQmlApplicationEngine appEngine;



    // Prise en compte du DPI pour les écrans
    double dpi;
    QSize size;
    #ifdef Q_OS_ANDROID
        qDebug() << "Android version";
        size = QGuiApplication::screens().first()->size();
        dpi = QGuiApplication::screens().first()->physicalDotsPerInch();
    #elif defined(Q_OS_LINUX)
        qDebug() << "Linux version";
        size = QSize(980, 480);
        dpi = 130;
    #elif defined(Q_OS_MACOS)
        qDebug() << "MacOS version";
        size = QSize(980, 480);
        dpi = 130;
    #elif defined(Q_OS_IOS)
        qDebug() << "iOS version";
        size = QSize(980, 480);
        dpi = 130;
    #else
        qDebug() << "Other version";
        size = QSize(980, 480);
        dpi = 130;
    #endif

    double screenDpi = dpi;
    double textScale = 1; // TODO Valeur à récupérer dynamiquement depuis la configuration du téléphone
    double textDpi = screenDpi * textScale;

    appEngine.rootContext()->setContextProperty("screenSize", size);
    appEngine.rootContext()->setContextProperty("screenDpi", screenDpi);
    appEngine.rootContext()->setContextProperty("textDpi", textDpi);

    // Set the source
    appEngine.load("qrc:/ChildClockApp/main.qml");

    return app.exec();
}
