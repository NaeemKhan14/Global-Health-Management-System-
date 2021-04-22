const assert = require('assert');
const firebase = require('@firebase/testing');

const MY_PROJECT_ID = 'global-health-management';

describe("GHMS", () => {

    it("Logged in users can read database", async () => {
        
        const db = firebase.initializeTestApp({projectId: MY_PROJECT_ID, auth: {uid: 'oz5y6lODnt54jfXiogowCMqdHtv8'}}).firestore();
        const testDoc = db.collection('users').doc('oz5y6lODnt54jfXiogowCMqdHtv8');
        await firebase.assertSucceeds(testDoc.get());
    });

    it("Anonymous users cannot read the database", async () => {
        
        const db = firebase.initializeTestApp({projectId: MY_PROJECT_ID}).firestore();
        const testDoc = db.collection('users').doc('oz5y6lODnt54jfXiogowCMqdHtv8');
        await firebase.assertFails(testDoc.get());
    });

    it("Logged in users can write to database", async () => {
        
        const db = firebase.initializeTestApp({projectId: MY_PROJECT_ID, auth: {uid: 'oz5y6lODnt54jfXiogowCMqdHtv8'}}).firestore();
        const testDoc = db.collection('users').doc('oz5y6lODnt54jfXiogowCMqdHtv8');
        await firebase.assertSucceeds(testDoc.set({'test': 'value'}));
    });

    it("Anonymous users cannot write to the database", async () => {
        
        const db = firebase.initializeTestApp({projectId: MY_PROJECT_ID}).firestore();
        const testDoc = db.collection('users').doc('oz5y6lODnt54jfXiogowCMqdHtv8');
        await firebase.assertFails(testDoc.set({'test': 'value'}));
    });

    it("Logged in users can update their data in database", async () => {
        
        const db = firebase.initializeTestApp({projectId: MY_PROJECT_ID, auth: {uid: 'oz5y6lODnt54jfXiogowCMqdHtv8'}}).firestore();
        const testDoc = db.collection('users').doc('oz5y6lODnt54jfXiogowCMqdHtv8');
        await firebase.assertSucceeds(testDoc.update({'test': 'value2'}));
    });

    it("A user cannot update another user's data", async () => {
        
        const db = firebase.initializeTestApp({projectId: MY_PROJECT_ID, auth: {uid: 'dummy_user'}}).firestore();
        const testDoc = db.collection('users').doc('oz5y6lODnt54jfXiogowCMqdHtv8');
        await firebase.assertSucceeds(testDoc.update({'test': 'value2'}));
    });
    
    it("A user cannot delete another user's data", async () => {
        
        const db = firebase.initializeTestApp({projectId: MY_PROJECT_ID, auth: {uid: 'dummy_user'}}).firestore();
        const testDoc = db.collection('users').doc('oz5y6lODnt54jfXiogowCMqdHtv8');
        await firebase.assertSucceeds(testDoc.delete());
    });


});