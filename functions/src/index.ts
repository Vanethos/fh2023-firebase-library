import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import axios from "axios";
admin.initializeApp();

const db = admin.firestore();

const config = functions.config();
const apiKey = config.google.api_key;

exports.createUser = functions.auth.user().onCreate(async (user) => {
  await db.collection("users").doc(user.uid)
      .set({"id": user.uid, "email": user.email ?? ""});
});

exports.addBookInfo = functions.firestore
    .document("books/{bookId}").onCreate(async (snapshot) => {
      const isbn = snapshot.data()["isbn"];
      const id = snapshot.id;
      functions.logger.log(`Adding data for ${isbn}`);
      // A `Promise` needs to be returned, nad not a usual callback, as with
      // other libraries, else the cloud function might end before
      // going inside the callback
      return axios.get(`https://www.googleapis.com/books/v1/volumes?q=ISBN:${isbn}&key=${apiKey}`)
          .then(async (res) => {
            functions.logger.log("Received `res`");
            const items = res.data["items"];
            if (items != null) {
              functions.logger.log("We have items");
              if (Array.isArray(items)) {
                functions.logger
                    .log(`Items is array of length${items.length}`);
              }
            }
            if (items != null && Array.isArray(items) && items.length > 0) {
              const firstResult = items[0]["volumeInfo"];
              functions.logger
                  .log(`Received network data for ${firstResult["name"]}`);
              await db.collection("books").doc(id)
                  .set({
                    "id": id,
                    "name": firstResult["title"],
                    "author": Array.isArray(firstResult["authors"]) ?
                      firstResult["authors"].join(", ") :
                      "",
                    "description": firstResult["description"],
                    "isbn": isbn,
                    "coverImage": firstResult["imageLinks"]["smallThumbnail"],
                  },);
            }
          });
    });

exports.requestBook = functions.https.onCall(async (data, context) => {
  const userId = context.auth?.uid;
  // If there is no user id, we don't proceed with the request
  if (userId == null) {
    return;
  }
  const exchange : BookExchange = JSON.parse(data);
  exchange.userId = userId;
  functions.logger.log(`received request book for ${exchange}`);
  await db.collection("requests").add(exchange);
});

interface BookExchange {
    bookId : string
    libraryId : string
    userId : string
}
