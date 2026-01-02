//
//  NewGroupView.swift
//  TaskManagerApp
//
//  Created by Edward Houser on 12/16/25.
//

import SwiftUI

struct NewGroupView: View {
    @Environment(\.dismiss) var dismiss
    @State private var groupName = ""
    @State private var selectedIcon = "list.bullet"
    let icons = ["list.bullet", "bookmark.fill", "graduationcap.fill", "cart.fill", "house.fill", "heart.fill", "star.fill", "flag.fill"]
    
    var onSave: (TaskGroup) -> Void
    
    var body: some View {
        
        NavigationStack{
            Form{
                Section("Group Name"){
                    TextField("Insert Name of Group", text:$groupName)
                }
                
                Section("Select Icon"){
                    LazyVGrid(columns: [GridItem(.adaptive(minimum:40))]){
                        ForEach(icons, id:\.self) { icon in
                        Image(systemName: icon)
                                .frame(width: 30, height: 30)
                                .background(selectedIcon == icon ? Color.cyan.opacity(0.2) : Color.clear)
                                .foregroundStyle(selectedIcon == icon ? Color.cyan : Color.gray)
                                .clipShape(.circle)
                                .onTapGesture {
                                    selectedIcon = icon
                                }
                        }
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("New Group Creator")
            .toolbar{
                ToolbarItem(placement : .cancellationAction){
                    Button("Cancel") {dismiss()}
                }
                ToolbarItem(placement: .confirmationAction){
                    Button("Save"){
                        let newGroup = TaskGroup(title: groupName, symbolName: selectedIcon, tasks: [])
                        onSave(newGroup)
                        dismiss()
                    }
                }
            }
        }
    }
}
