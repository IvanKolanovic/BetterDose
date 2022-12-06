
import SwiftUI
import Firebase

struct DiaryPickDateView: View{
    @State private var picked:Date = Date.now
    @Binding var med:Medication
    var dateFormatter: DateFormatter = DateFormatter()
    @ObservedObject var dataManager: FirestoreDataManager
    @Binding var currentNavTab: Navigation;
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View{
        VStack {
            Form{
                Section(header: Text("Medication Selected").font(.headline).foregroundColor(Color("betterRed"))) {
                    HStack(spacing: 20){
                        Text("Substance name:").font(.subheadline).foregroundColor(Color("betterRed")).frame(width: 100)
                        Text(med.openfda.substanceName[0].capitalized)
                    }.frame(alignment: .leading)
                    HStack(spacing: 20){
                        Text("Dosage form:").font(.subheadline).foregroundColor(Color("betterRed")).frame(width: 100)
                        Text(med.products[0].dosageForm.capitalized)
                    }.frame(alignment: .leading)
                    HStack(spacing: 20){
                        Text("Route:").font(.subheadline).foregroundColor(Color("betterRed")).frame(width: 50)
                        Text(med.products[0].route.capitalized)
                    }.frame(alignment: .leading)
                    HStack(spacing: 20){
                        Text("Manufacturer name:").font(.subheadline).foregroundColor(Color("betterRed")).frame(width: 100)
                        Text(med.openfda.manufacturerName[0].capitalized)
                    }.frame(alignment: .leading)
                    DatePicker(selection: $picked, in: Date.now...) {
                        Text("Take at:").font(.subheadline).foregroundColor(Color("betterRed")).frame(width: 100)
                    }.padding(.horizontal,20)
                }
            }
            Button {
                addToDiary()
            } label: {
                Text("Add")
                    .frame(maxWidth: 285,maxHeight: 50  )
            }.buttonStyle(.borderedProminent).tint(Color("betterRed")).padding(.bottom,10)
            Spacer()
        }
    }
    
    func addToDiary() {
        let authUser = Auth.auth().currentUser
        dateFormatter.dateFormat = "dd-MM-YYYY HH:mm"
        let diary = Diary(id: UUID().uuidString, drugName: med.openfda.substanceName[0].capitalized, userId: authUser!.uid, takeAt: dateFormatter.string(from: picked))
        dataManager.createDiaryEntry(diary)
        currentNavTab = Navigation.diary
        self.presentationMode.wrappedValue.dismiss()
    }
}
