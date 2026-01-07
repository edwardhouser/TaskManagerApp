//
//  DashboardView.swift
//  TaskManagerApp
//
//  Created by Edward Houser on 12/20/25.
//

import SwiftUI

struct DashboardView: View {
    @Binding var profile: Profile
    @State private var selectedTaskGroup: TaskGroup?
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    @State private var isShowingAddGroup =  false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            List(selection: $selectedTaskGroup) {
                ForEach(profile.groups){ group in
                    NavigationLink(value: group) {
                        Label(group.title, systemImage: group.symbolName)
                    }
                    .accessibilityIdentifier("TaskGroupSelectionLink \(group) ")
                }
            }
            .navigationTitle(profile.name)
            .listStyle(.sidebar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading){
                    Button{
                        dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Home")
                        }
                    }
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Button {isShowingAddGroup = true } label : {
                        Image(systemName: "plus")
                    }
                }
            }
        } detail : {
            if let group = selectedTaskGroup {
                if let index = profile.groups.firstIndex(where: {$0.id == group.id}) {
                    TaskGroupDetailView(groups: $profile.groups[index])
                }
            } else {
                ContentUnavailableView("Select a Group", systemImage: "sidebar.left")
            }
        }
        .sheet(isPresented: $isShowingAddGroup) {
            NewGroupView { newGroup in
                profile.groups.append(newGroup)
            }
        }
    }
}
