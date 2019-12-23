const functions = require('firebase-functions')
const admin = require('firebase-admin')
admin.initializeApp()

exports.sendNotification = functions.firestore
  .document('Groups/{groupId1}/{groupId2}/{message}')
  .onCreate((snap, context) => {
    console.log('----------------start function--------------------')

    const doc = snap.data()
    console.log(doc)

    const idFrom = doc.idFrom
    const idTo = doc.idTo
    const contentMessage = doc.text

    // Get push token user to (receive)
    admin
      .firestore()
      .collection('Users')
      .get()
      .then(querySnapshot => {
        querySnapshot.forEach(userTo => {
          console.log(`Found user to: ${userTo.data().username}`)
          if (userTo.data().pushToken) {
            // Get info user from (sent)
            const payload = {
              notification: {
                title: `You have a message from "${doc.username}"`,
                body: contentMessage,
                badge: '1',
                sound: 'default'
              }
            }
            // Let push to the target device
            admin
              .messaging()
              .sendToDevice(userTo.data().pushToken, payload)
              .then(response => {
                console.log('Successfully sent message:', response)
              })
              .catch(error => {
                console.log('Error sending message:', error)
              })
          } else {
            console.log('Can not find pushToken target user')
          }
        })
      })
    return null
  })