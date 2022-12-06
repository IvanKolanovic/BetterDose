
import SwiftUI

struct CustomSearchBar: View

{
    @Binding var searchText: String
    @Binding var searching: Bool
    @ObservedObject var api: ApiService

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white).overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color("betterRed"), lineWidth: 2)
                )
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search ..", text: $searchText) { startedEditing in
                    if startedEditing {
                        withAnimation {
                            searching = true
                        }
                    }
                } onCommit: {
                    withAnimation {
                        searching = false
                        api.getMedsByName(searchText)
                    }
                }
            }
            .foregroundColor(.black)
            .padding(.leading, 13)
        }
        .frame(height: 40)
        .padding()
    }
}

