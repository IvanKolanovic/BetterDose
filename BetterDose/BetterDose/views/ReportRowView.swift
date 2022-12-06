
import SwiftUI

struct ReportRowView: View{
    
    var report: Report
    
    var body: some View{
        HStack{
            Label("Felt \(report.mood) at \(report.reportedAt).", systemImage: "heart.circle.fill")
                .foregroundColor(.black)
                .font(.subheadline)
                .padding(.horizontal,10)
        }
    }
}
