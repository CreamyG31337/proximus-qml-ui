//#include <QtGui/QApplication>
//#include "qmlapplicationviewer.h"

//int main(int argc, char *argv[])
//{
//    QApplication app(argc, argv);

//    QmlApplicationViewer viewer;
//    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
//    viewer.setMainQmlFile(QLatin1String("qml/Proximus/main.qml"));
//    viewer.showExpanded();

//    return app.exec();
//}

#include <QtGui/QApplication>
#include <QtDeclarative/QDeclarativeView>
#include <QtDeclarative/QDeclarativeEngine>
#include <MDeclarativeCache>

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(MDeclarativeCache::qApplication(argc, argv));
    QScopedPointer<QDeclarativeView> view(MDeclarativeCache::qDeclarativeView());

    view->setSource(MDeclarativeCache::applicationDirPath()
                    + QLatin1String("/../qml/Proximus/main.qml"));

    QObject::connect(view->engine(), SIGNAL(quit()), view.data(), SLOT(close()));

    view->showFullScreen();

    app->exec();
}
