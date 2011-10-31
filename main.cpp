#include <QtGui/QApplication>
#include <QtDeclarative/QDeclarativeView>
#include <QtDeclarative/QDeclarativeEngine>
#include <MDeclarativeCache>
#include <main.h>

MySettings::MySettings()
{
}
MySettings::~MySettings()
{

}

RuleObject::RuleObject(QString name, bool enabled)
{

}

bool RuleObject::enabled()
{
    return boolenabled;
}

QString RuleObject::name()
{
    return strname;
}

void RuleObject::setEnabled(bool enabled)
{
    boolenabled = enabled;
}

void RuleObject::setName(QString name)
{
    strname = name;
}

RuleObject::~RuleObject()
{

}

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QCoreApplication::setOrganizationName("FakeCompany");
    QCoreApplication::setOrganizationDomain("appcheck.net");
    QCoreApplication::setApplicationName("Proximus");

    QScopedPointer<QApplication> app(MDeclarativeCache::qApplication(argc, argv));
    QScopedPointer<QDeclarativeView> view(MDeclarativeCache::qDeclarativeView());
    MySettings objSettings;
    view->rootContext()->setContextProperty("objQSettings",&objSettings);

    view->setSource(MDeclarativeCache::applicationDirPath()
                    + QLatin1String("/../qml/Proximus/main.qml"));

    QObject::connect(view->engine(), SIGNAL(quit()), view.data(), SLOT(close()));

    view->showFullScreen();

    app->exec();
}
