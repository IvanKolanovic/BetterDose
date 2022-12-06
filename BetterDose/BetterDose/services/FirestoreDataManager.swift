

import SwiftUI
import Firebase

class FirestoreDataManager: ObservableObject{
    @Published var users: [MyUser] = []
    @Published var diaries: [Diary] = []
    @Published var reports: [Report] = []
    @Published var currentUser: MyUser? = nil
    @Published var isFetching: Bool = true
    var db = Firestore.firestore();
    
    func createUser(_ request:MyUser) {
        db.collection("Users").document(request.getId()).setData([
            "id": request.getId(),
            "email": request.getEmail(),
            "fullName": request.getFullName(),
            "createdAt": request.getCreatedAt()
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func createDiaryEntry(_ request:Diary) {
        db.collection("Diary").document(request.id).setData([
            "id": request.id,
            "drugName": request.drugName,
            "takeAt": request.takeAt,
            "userId": request.userId
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    @MainActor
    func createReport(_ request:Report){
        DispatchQueue.main.async {
            self.db.collection("Report").document(request.id).setData([
                "id": request.id,
                "mood": request.mood,
                "reportedAt": request.reportedAt,
                "userId": request.userId
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                    self.reports.append(request)
                    self.reports = self.reports.sorted {
                        $0.reportedAt > $1.reportedAt
                    }
                }
            }
        }
    }
    
    @MainActor
    func fetchUser(_ uid: String) async
    {
        let docRef = db.collection("Users").document(uid)
        
        self.isFetching = true
        
        DispatchQueue.main.async {
            docRef.getDocument { (document, error) in
                if let document = document {
                    let dict =  document.data()
                    let uid = dict?["id"] as? String ?? ""
                    let email = dict?["email"] as? String ?? ""
                    let fullName = dict?["fullName"] as? String ?? ""
                    let createdAt = dict?["createdAt"] as? String ?? ""
                    self.currentUser = MyUser(id: uid, email: email, fullName: fullName, createdAt: createdAt)
                    self.isFetching = false
                } else {
                    print("Document does not exist")
                }
            }
        }
    }
    
    @MainActor
    func fetchDiaries() async
    {
        self.isFetching = true
        let authUser = Auth.auth().currentUser
        DispatchQueue.main.async {
            self.db.collection("Diary").whereField("userId", isEqualTo: authUser?.uid ?? "notReal")
                .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                        self.diaries = []
                        self.isFetching = false
                    } else {
                        self.diaries = []
                        for document in querySnapshot!.documents {
                            let dict =  document.data()
                            let id = dict["id"] as? String ?? ""
                            let userId = dict["userId"] as? String ?? ""
                            let drugName = dict["drugName"] as? String ?? ""
                            let takeAt = dict["takeAt"] as? String ?? ""
                            let diary = Diary(id: id, drugName: drugName, userId: userId, takeAt: takeAt)
                            self.diaries.append(diary)
                        }
                        self.diaries = self.diaries.sorted {
                            $0.takeAt < $1.takeAt
                        }
                        self.isFetching = false
                    }
                }
        }
    }
    
    @MainActor
    func fetchReports() async
    {
        self.isFetching = true
        let authUser = Auth.auth().currentUser
        DispatchQueue.main.async {
            self.db.collection("Report").whereField("userId", isEqualTo: authUser?.uid ?? "notReal")
                .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                        self.reports = []
                        self.isFetching = false
                    } else {
                        self.reports = []
                        for document in querySnapshot!.documents {
                            let dict =  document.data()
                            let id = dict["id"] as? String ?? ""
                            let userId = dict["userId"] as? String ?? ""
                            let mood = dict["mood"] as? String ?? ""
                            let reportedAt = dict["reportedAt"] as? String ?? ""
                            let report = Report(id: id, userId: userId, mood: mood, reportedAt: reportedAt)
                            self.reports.append(report)
                        }
                        self.reports = self.reports.sorted {
                            $0.reportedAt > $1.reportedAt
                        }
                        self.isFetching = false
                    }
                }
        }
    }
    
    func fetchUsers(){
        let ref = self.db.collection("Users")
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot{
                for document in snapshot.documents{
                    let data = document.data()
                    
                    let id = data["id"] as? String ?? ""
                    let email = data["email"] as? String ?? ""
                    let fullName = data["fullName"] as? String ?? ""
                    let createdAt = data["createdAt"] as? String ?? ""
                    
                    let user = MyUser(id: id, email: email, fullName: fullName, createdAt: createdAt)
                    self.users.append(user)
                    
                }
            }
            
        }
        
    }
    
    func updateName(_ name:String){
        let authUser = Auth.auth().currentUser
        let ref = self.db.collection("Users").whereField("id", isEqualTo: authUser?.uid ?? "Failed")
        self.isFetching = true

        DispatchQueue.main.async {
            ref.getDocuments() { (querySnapshot, err) in
                if err == nil {
                    for document in querySnapshot!.documents{
                        self.db.collection("Users").document(document.documentID).setData([ "fullName": name ], merge: true)
                        let dict =  document.data()
                        let uid = dict["id"] as? String ?? ""
                        let email = dict["email"] as? String ?? ""
                        let createdAt = dict["createdAt"] as? String ?? ""
                        let user = MyUser(id: uid, email: email, fullName: name, createdAt: createdAt)
                        self.currentUser = user
                        self.isFetching = false
                    }
                }
            }
        }
    }
    
    func deleteDoc(_ collection:String,_ docId:String){
        db.collection(collection).document(docId).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
}





