import SwiftUI
import Firebase

struct CustomRating: View{
    var text: String
    var icon: String
    @ObservedObject var dataManager: FirestoreDataManager
    var dateFormatter: DateFormatter = DateFormatter()
    
    
    var body: some View{
        Label {
            Text(text)
        } icon: {
            Image(icon)
                .resizable()
                .frame(width: 44, height: 44, alignment: .center)
        }
        .frame(width: 60, height: 50)
        .labelStyle(VerticalLabelStyle())
        .onTapGesture(perform: tap)
    }
    
    func tap(){
        let authUser = Auth.auth().currentUser
        dateFormatter.dateFormat = "dd-MM-YYYY HH:mm"
        let report = Report(id: UUID().uuidString, userId: authUser?.uid ?? "Does not exist", mood: text, reportedAt: dateFormatter.string(from: Date.now))
        dataManager.createReport(report)
    }
}

