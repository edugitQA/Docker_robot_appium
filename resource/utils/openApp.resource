*** Settings ***
Resource        ../../base.resource

*** Keywords ***
Open ted App

    Open Application
    ...    remote_url=http://localhost:4723/wd/hub
    ...    automationName=UIautomator2
    ...    platformName=android
    ...    deviceName=Google Pixel 7 Pro
    ...    app=${CURDIR}${/}..${/}app${/}app.apk