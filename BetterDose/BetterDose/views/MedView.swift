
import SwiftUI
import Firebase

struct MedView: View{
    
    @State var searchText = ""
    @State var searching = false
    @ObservedObject var api: ApiService
    @ObservedObject var dataManager: FirestoreDataManager
    @Binding var currentNavTab: Navigation
    
    var body: some View{
        VStack(alignment: .leading) {
            CustomSearchBar(searchText: $searchText, searching: $searching,api: api)
            VStack {
                if !api.meds.isEmpty{
                    MedDetailView(med: api.meds[0])
                    NavigationLink(destination: DiaryPickDateView(med: $api.meds[0],dataManager: dataManager,currentNavTab: $currentNavTab)) {
                        Text("Add to Diary")
                        .frame(maxWidth: 200,maxHeight: 30)            }.buttonStyle(.borderedProminent).tint(Color("betterRed")).padding(.horizontal,100).padding(.bottom,20)
                }else{
                    Spacer()
                    Image("doctors").resizable()
                        .frame(width: 400,height: 250,alignment: .leading)
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Medication")
            .toolbar {
                if searching {
                    Button("Cancel") {
                        searchText = ""
                        withAnimation {
                            searching = false
                            UIApplication.shared.inputViewController?.dismissKeyboard()
                        }
                    }
                }
            }
            .gesture(DragGesture()
                .onChanged({ _ in
                    UIApplication.shared.inputViewController?.dismissKeyboard()
                })
            )
        }.alert("Search", isPresented: $api.showAlert, actions: {
            Button("Okey", role: .cancel, action: {})
        },message: {Text("Request drug could not be found in our database.")})
    }
    
}
