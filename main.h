#ifndef MAIN_H
#define MAIN_H

#include <QtGui/QApplication>
#include <QtDeclarative/QDeclarativeView>
#include <QtDeclarative/QDeclarativeEngine>
#include <MDeclarativeCache>
#include <QtCore/QSettings>
#include <QtDeclarative/QDeclarativeContext>
#include <QtCore/QCoreApplication>
#include <QtCore/QtGlobal>
#include <QtCore/QStringList>
#include <QtCore/QObject>
#include <QtCore/QAbstractListModel>
#include <QtCore/QScopedPointer>


//annoying wrapper class for qsettings
class MySettings : public QObject
{
    Q_OBJECT
public:
    explicit MySettings();
    virtual ~MySettings();
    Q_INVOKABLE QVariant getValue(QString keyval,QVariant defaultval){
        return qsettInternal.value(keyval,defaultval);
    }
    Q_INVOKABLE void setValue(QString key,QVariant value){
        qsettInternal.setValue(key,value);
    }
    Q_INVOKABLE void beginGroup(QString prefix){
        qsettInternal.beginGroup(prefix);
    }
    Q_INVOKABLE void endGroup(){
        qsettInternal.endGroup();
    }
    Q_INVOKABLE bool contains(QString key){
        return qsettInternal.contains(key);
    }
    Q_INVOKABLE QStringList childGroups(){
        return qsettInternal.childGroups();
    }

private:
    QSettings qsettInternal;
};

//list of rules
class RuleObject : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool enabled READ enabled WRITE setEnabled)
    Q_PROPERTY(QString name READ name WRITE setName)
public:
    RuleObject(QString name, bool enabled);
    ~RuleObject();
    void setEnabled(bool enabled);
    void setName(QString name);
    bool enabled();
    QString name();
private:
    QString strname;
    bool boolenabled;
};

#endif // MAIN_H
