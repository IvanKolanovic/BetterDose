

import SwiftUI

struct DiaryView: View{
    @ObservedObject var dataManager: FirestoreDataManager
    
    init(dataManager: FirestoreDataManager) {
        self.dataManager = dataManager
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(named: "betterRed") ?? .black]
    }
    
    var body: some View{
        ZStack{
            if dataManager.isFetching{
                ProgressView("Loading...").progressViewStyle(.circular)
            }else{
                VStack{
                    List {
                        Section(header: Text("Medicine reminder").font(.headline).foregroundColor(Color("betterRed"))){
                            if !dataManager.diaries.isEmpty{
                                ForEach(dataManager.diaries) { diary in
                                    DiaryRowView(diary: diary)
                                }.onDelete(perform: deleteDiary)
                            } else{
                                Text("Empty")
                            }
                        }
                        
                        Section(header: Text("Mood report").font(.headline).foregroundColor(Color("betterRed"))){
                            if !dataManager.reports.isEmpty{
                                ForEach(dataManager.reports) { report in
                                    ReportRowView(report: report)
                                }.onDelete(perform: deleteReport)
                            } else{
                                Text("Empty")
                            }
                        }
                        
                    }.refreshable {
                        Task {
                            await dataManager.fetchDiaries()
                        }
                        Task {
                            await dataManager.fetchReports()
                        }
                    }.toolbar {
                        EditButton()
                    }.padding(.bottom,10) // end of list
                    
                    Text("How are you feeling?").font(.title).foregroundColor(Color("betterRed")).padding(.vertical,5)
                    HStack{
                        CustomRating(text: "Awful", icon: "horrible",dataManager: dataManager)
                        CustomRating(text: "Bad", icon: "bad",dataManager: dataManager)
                        CustomRating(text: "Meh", icon: "meh",dataManager: dataManager)
                        CustomRating(text: "Good", icon: "good",dataManager: dataManager)
                        CustomRating(text: "Great", icon: "awesome",dataManager: dataManager)
                    }
                    
                    Image("doctors").resizable()
                        .frame(width: 300,height: 175,alignment: .leading).padding(.top,30)
                }
            }
        }.task {
            await dataManager.fetchDiaries()
        }.task {
            await dataManager.fetchReports()
        }.navigationTitle("Medical diary")
    }
    
    
    func deleteDiary(at offsets: IndexSet) {
        //users.remove(atOffsets: offsets)
        for i in offsets {
            let a: Diary = dataManager.diaries.remove(at: i)
            dataManager.deleteDoc(FirebaseCollection.Diary.rawValue, a.id)
          }
    }
    
    func deleteReport(at offsets: IndexSet) {
        //users.remove(atOffsets: offsets)
        for i in offsets {
            let a: Report = dataManager.reports.remove(at: i)
            dataManager.deleteDoc(FirebaseCollection.Report.rawValue, a.id)
          }
    }
}
