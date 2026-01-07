//
//  ContentView.swift
//  TaskManagerApp
//
//  Created by Edward Houser on 12/9/25.
//

import SwiftUI

struct ContentView: View {
    @State private var profiles: [Profile] = []
    // @State private var taskGroups: [TaskGroup] = []
    let saveKey = "savedProfiles"
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @Environment(\.scenePhase) private var scenePhase
    @State private var path = NavigationPath()
    let columns = [GridItem(.adaptive(minimum: 150))]
    
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    Text("select the working profile")
                        .font(.largeTitle.bold())
                        .accessibilityIdentifier("ProfileSelectionTitle")
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach($profiles) { $profile in
                            NavigationLink(value: profile) {
                                VStack{
                                    Image(profile.profileImage)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 80, height: 80)
                                        .clipShape(.circle)
                                    Text(profile.name)
                                }
                            }
                            .accessibilityIdentifier("ProfileSelectionLink \(profile) ")
                        }
                    }
                }
            }
            .navigationTitle("Home")
            .navigationBarHidden(true)
            .navigationDestination(for: Profile.self) { selectedProfile in
                if let index = profiles.firstIndex(where: {$0.id == selectedProfile.id}) {
                    DashboardView(profile: $profiles[index])
                }
            }
            
            
            
            
            //        NavigationSplitView(columnVisibility: $columnVisibility) {
            //            //SIDEBAR
            //            List(selection: $selectedTaskGroup){
            //                ForEach(taskGroups) { group in
            //                    NavigationLink(value: group) {
            //                        Label(group.title, systemImage: group.symbolName)
            //                    }
            //                }
            //            }
            //            .navigationTitle("To-Do App")
            //            .listStyle(.sidebar)
            //            .toolbar {
            //                ToolbarItem(placement: .topBarLeading) {
            //                    Button {
            //                        isDarkMode.toggle()
            //                    } label: {
            //                        Image(systemName: isDarkMode ? "sun.max.fill" : "moon.fill")
            //                    }
            //                }
            //
            //                ToolbarItem(placement: .primaryAction) {
            //                    Button {
            //                        isShowingAddGroup = true
            //                    } label: {
            //                        Image(systemName: "plus")
            //                    }
            //                }
            //            }
            //
            //        } detail: {
            //            if let group = selectedTaskGroup {
            //                if let index = taskGroups.firstIndex(where: { $0.id == group.id }) {
            //                    TaskGroupDetailView(groups: $taskGroups[index])
            //                }
            //                } else {
            //                    ContentUnavailableView("Select a Group", systemImage: "sidebar.left")
            //                }
            //            }
            //                .sheet(isPresented: $isShowingAddGroup){
            //                    NewGroupView{ newGroup in
            //                        taskGroups.append(newGroup)
            //                        selectedTaskGroup = newGroup
            //                    }
            //                }
            //
            .onAppear{
                loadData()
            }
            .onChange(of: scenePhase) { oldValue, newValue in
                if newValue == .active{
                    print("app is active")
                } else if newValue == .inactive {
                    print("App is inactive")
                } else if newValue == .background {
                    print("app is in background")
                    saveData()
                }
            }
        }
    }
    
        
        
        //    func saveData() {
        //        if let encodedData =  try? JSONEncoder().encode(taskGroups) {
        //            UserDefaults.standard.set(encodedData, forKey: saveKey)
        //        }
        //    }
        //
        //    func loadData() {
        //        if let savedData = UserDefaults.standard.data(forKey: saveKey){
        //            if let decodedGroups = try? JSONDecoder().decode([TaskGroup].self, from: savedData) {
        //                taskGroups = decodedGroups
        //                return
        //            }
        //        }
        func saveData() {
            if let encodedData =  try? JSONEncoder().encode(profiles) {
                UserDefaults.standard.set(encodedData, forKey: saveKey)
            }
        }
        
        func loadData() {
            if let savedData = UserDefaults.standard.data(forKey: saveKey){
                if let decodedProfiles = try? JSONDecoder().decode([Profile].self, from: savedData) {
                    profiles = decodedProfiles
                    return
                }
            }
            
            //mock data for dev purposes
            profiles = Profile.sample
            
            
        }
    }


//#Preview {
//    ContentView()
//}
