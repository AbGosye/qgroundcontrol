/****************************************************************************
 *
 * (c) 2009-2020 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

import QtQml

QtObject {
    // Custom action ID
    readonly property int actionCustomButton: _guidedController.customActionStart + 0

    // Button text in the guided actions list
    readonly property string customButtonTitle: qsTr("Login")
    readonly property string customButtonMessage: qsTr("Login is required to continue.")

    // Bypass the confirmation slider completely
    // This makes the action trigger immediately when selected
    function customConfirmAction(actionCode, actionData, mapIndicator, confirmDialog) {
        if (actionCode === actionCustomButton) {
            // Directly execute the action — no slider, no confirm dialog
            _guidedController.executeAction(actionCode, actionData, null, false)
            return true
        }
        return false
    }

    // Execute the custom Login dialog
    function customExecuteAction(actionCode, actionData, sliderOutputValue, optionChecked) {
        if (actionCode === actionCustomButton) {
            var component = Qt.createComponent(Qt.resolvedUrl("LoginDialog.qml"))

            if (component.status === Component.Ready) {
                var dialog = component.createObject(mainWindow)
                mainWindow.showDialog(dialog)
            } else if (component.status === Component.Error) {
                console.warn("LoginDialog load error:", component.errorString())
                mainWindow.showMessageDialog(
                    qsTr("Error"),
                    qsTr("Failed to load Login dialog.")
                )
            }
            return true
        }
        return false
    }
}
