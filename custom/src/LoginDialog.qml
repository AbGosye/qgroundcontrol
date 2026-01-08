import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QGroundControl
import QGroundControl.Controls
import QGroundControl.ScreenTools

Rectangle {
    id: root
    width: 360
    height: 260
    radius: 8
    color: qgcPal.window

    // Center the dialog in the main window
    anchors.centerIn: parent

    // Expose username and password if needed elsewhere (optional)
    property alias username: usernameField.text
    property alias password: passwordField.text

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 16

        // Title
        QGCLabel {
            text: qsTr("SKYWIN-ETHIOPIA Login")
            font.pointSize: ScreenTools.largeFontPointSize
            Layout.alignment: Qt.AlignHCenter
        }

        // Username field
        QGCLabel {
            text: qsTr("Username")
        }
        TextField {
            id: usernameField
            placeholderText: qsTr("Enter username")
            Layout.fillWidth: true
        }

        // Password field
        QGCLabel {
            text: qsTr("Password")
        }
        TextField {
            id: passwordField
            placeholderText: qsTr("Enter password")
            echoMode: TextInput.Password
            Layout.fillWidth: true
        }

        // Buttons at the bottom
        RowLayout {
            Layout.alignment: Qt.AlignRight
            spacing: 12

            QGCButton {
                text: qsTr("Cancel")
                onClicked: mainWindow.closeDialog()
            }

            QGCButton {
                text: qsTr("Login")
                primary: true
                onClicked: {
                    if (usernameField.text === "admin" && passwordField.text === "admin") {
                        mainWindow.closeDialog(true)  // Success: close with accepted = true
                    } else {
                        mainWindow.showMessageDialog(
                            qsTr("Login Failed"),
                            qsTr("Invalid username or password.")
                        )
                        // Clear fields on failure (optional but nice)
                        usernameField.text = ""
                        passwordField.text = ""
                    }
                }
            }
        }
    }
}
