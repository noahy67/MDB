//
//  AuthManager.swift
//  MDB Social
//
//  Created by Michael Lin on 10/9/21.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthManager {
    
    static let shared = AuthManager()
    
    let auth = Auth.auth()
    
    enum SignInErrors: Error {
        case wrongPassword
        case userNotFound
        case invalidEmail
        case internalError
        case errorFetchingUserDoc
        case errorDecodingUserDoc
        case unspecified
    }
    
    let db = Firestore.firestore()
    
    var currentUser: User?
    
    private var userListener: ListenerRegistration?
    
    init() {
        guard let user = auth.currentUser else { return }
        
        linkUser(withuid: user.uid, completion: nil)
    }
    
    func signIn(withEmail email: String, password: String,
                completion: ((Result<User, SignInErrors>)->Void)?) {
        
        /* TODO: Hackshop */
        
        // Completion you can pass in a .success() or .failure()
        // .failure(pass in corresponding signinerrors)
        // refer to self.auth.signIn, auth is imported from firebaseAuth
        // this is error handling below
        
        auth.signIn(withEmail: email, password: password) { authResults, error in
            if let error = error {
                let nsError = error as NSError // type casting
                let errorCode = FirebaseAuth.AuthErrorCode(rawValue: nsError.code)
                switch errorCode {
                case .wrongPassword:
                    completion?(.failure(.wrongPassword))
                case .userNotFound:
                    completion?(.failure(.userNotFound))
                default:
                    completion?(.failure(.unspecified))
                }
                return
            }
            
            guard let authResult = authResults else {
                completion?(.failure(.internalError))
                return
            }
            // call linkUser, communication with firestore, fetch user meta data, put into struct, pass into a completion, same completion passed into signIn function
            
            // completion specifying what were gna do after action happens
            
            // delegating responsibility of completion to linkUser
            self.linkUser(withuid: authResult.user.uid, completion: completion)
        }
    }
    
    /* TODO: Firebase sign up handler, add user to firestore */
    
    func isSignedIn() -> Bool {
        return auth.currentUser != nil
    }
    
    func signOut(completion: (()->Void)? = nil) {
        do {
            try auth.signOut()
            unlinkCurrentUser()
            completion?()
        } catch { }
    }
    
    private func linkUser(withuid uid: String,
                          completion: ((Result<User, SignInErrors>)->Void)?) {
        
        /* TODO: Hackshop */
        // use different api from firebase, get uid from authentification
        
        // signIn is talking to authentification module, now using uid to go into firestore database and get a document
        // using users collection
        // attach listener to user so there can be multiple instances of uid, if owner event changed name of event, all clients should instantaneously update its corresponding title without having to update each document, something unique to firebase as opposed to building your own database
        
        // set it to userListener as you need a way unlink the currentUser, unlinkeCurrentUser gets called when signing out
        userListener = db.collection("users").document(uid).addSnapshotListener { docSnapshot, error in
            guard let document = docSnapshot else {
                completion?(.failure(.errorFetchingUserDoc))
                return
            }
            // decode data into user
            // always use decodable api for user and other events
            // codeable is encodable + decodable
            // checking if you can decode user struct from document you are accessing
            guard let user = try? document.data(as: User.self) else {
                completion?(.failure(.errorDecodingUserDoc))
                return
            }
            // have a fully unwrapped completion that doesn't fail
            // currentUser keeps track of who's signed in
            self.currentUser = user
            completion?(.success(user))
        }
    }
    
    private func unlinkCurrentUser() {
        userListener?.remove()
        currentUser = nil
    }
}
