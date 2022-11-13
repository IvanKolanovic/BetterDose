//
//  ContentView.swift
//  BetterDose
//
//  Created by bit4bytes on 13.11.2022..
//

import SwiftUI

struct ContentView: View {
    
    @State var currentNavTab = NavigationTabs.diary
    
    
    
    
    var body: some View {
        
       // LoginView()
        RegisterView()
        
        
        
        //        TabView(selection: $currentNavTab){
        //            NavigationStack {
        //                ZStack{
        //              //      MyMapTab()
        //                }
        //            }
        //            .tabItem {
        //                Image(systemName: "book")
        //                Text("Diary")
        //            }
        //            .tag(NavigationTabs.diary)
        //            NavigationStack {
        //     //               ParkListView(parks: _parks, selectedTab: $selectedTab, lm:$locationManager)
        //            }
        //            .tabItem {
        //                Image(systemName: "map")
        //                Text("Map")
        //            }.tag(NavigationTabs.map)
        //            NavigationStack {
        //         //       FavoriteView(parks: _parks,selected: $selectedTab)
        //            }
        //            .tabItem {
        //                Image(systemName: "text.magnifyingglass")
        //                Text("Search")
        //            }
        //            .tag(NavigationTabs.search)
        //            NavigationStack {
        //          //      AboutView()
        //
        //            }
        //            .tabItem {
        //                Image(systemName: "person")
        //                Text("Profile")
        //            }.tag(NavigationTabs.profile)
        //        }
    }
    
}
