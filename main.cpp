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
        strname = name;
        boolenabled = enabled;
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
    QList<QObject*> rulesList;

    objSettings.beginGroup("settings");
    if (!objSettings.contains("GPS")) //first run, need to create default settings
    {
        objSettings.setValue("GPS",false);
    }
    objSettings.endGroup();//end settings
    objSettings.beginGroup("rules");
    if (objSettings.childGroups().count() == 0) //first run, or no rules -- create one example rule
    {
        objSettings.setValue("Example Rule/enabled",(bool)false);
        objSettings.setValue("Example Rule/Location/enabled",(bool)true);
        objSettings.setValue("Example Rule/Location/NOT",(bool)false);
        objSettings.setValue("Example Rule/Location/RADIUS",(double)250);
        objSettings.setValue("Example Rule/Location/LONGITUDE",(double)-113.485336);
        objSettings.setValue("Example Rule/Location/LATITUDE",(double)53.533064);
    }

    Q_FOREACH(const QString &strRuleName, objSettings.childGroups()){//for each rule
        objSettings.beginGroup(strRuleName);
        rulesList.append(new RuleObject(strRuleName,objSettings.getValue("enabled",false).toBool()));
        objSettings.endGroup();
    }
    objSettings.endGroup();//end rules
    view->rootContext()->setContextProperty("objQSettings",&objSettings);
    view->rootContext()->setContextProperty("objRulesModel", QVariant::fromValue(rulesList));

    view->setSource(MDeclarativeCache::applicationDirPath()
                    + QLatin1String("/../qml/Proximus/main.qml"));

    QObject::connect(view->engine(), SIGNAL(quit()), view.data(), SLOT(close()));

    view->showFullScreen();

    app->exec();
}
