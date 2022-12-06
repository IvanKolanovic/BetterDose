
import SwiftUI

struct DiaryRowView: View{
    
    var diary: Diary
    
    var body: some View{
        HStack{
            Label("Take \(diary.drugName) at \(diary.takeAt).", systemImage: "calendar.badge.clock")
                    .foregroundColor(.black)
                    .font(.subheadline)
                    .padding(.horizontal,10)
          
        }
    }
}
