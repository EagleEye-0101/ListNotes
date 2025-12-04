//
//  ContentView.swift
//  ListNotes
//
//  Created by students on 13/9/47.
//

import SwiftUI
import SwiftData
struct ContentView: View {
    // Used to perform CRUD operations
    @Environment(\.modelContext)
        private var modelContext
    
    @Query private var lists: [Listt]
    
    @State private var title = ""
    @State private var isAlertShowing: Bool = false
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(lists)
                {
                    list in
                    Text(list.title)
                        .font(.title2)
                        .fontWeight(.light)
                        .padding(.vertical,5)
                        .padding(.horizontal,2)
                        .foregroundColor(.black)
                        .swipeActions{
                            Button("Delete",role: .destructive){
                                modelContext.delete(list)
                            }
                        }
                }
            }
            .navigationTitle("My Notes")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button{
                        //Add button action here
                        isAlertShowing.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .imageScale(.large)
                        
                    }
                    .alert("Create a new wish",isPresented:
                            $isAlertShowing){
                        TextField("Enter a list",text:$title)
                        
                        Button(){
                            modelContext.insert(Listt(title:title))
                            title = ""
                        } label: {
                            Text("Save")
                        }
                        .disabled(title.isEmpty)
                    }
                }
            }
            .overlay{
                if lists.isEmpty{
                    ContentUnavailableView("My list are not available", systemImage: "snow",description: Text("No lists added yet. Add one to get started."))
                }
            }
            
        }
       
    }
}

#Preview("Second List") {
    do{
        let container = try!
        ModelContainer(for: Listt.self,configurations:
            ModelConfiguration(isStoredInMemoryOnly: true)
    )
        
        let ctx = container.mainContext
        ctx.insert(Listt(title: "Swift Coding Club"))
        ctx.insert(Listt(title: "Hello"))
        ctx.insert(Listt(title: "Bye Bye"))
        ctx.insert(Listt(title: "1 kilogram atta"))
        
        
        //Return the view for this preview
        return ContentView()
            .modelContainer(container)
    }
}


#Preview("Main List"){
    ContentView()
        .modelContainer(for: Listt.self, inMemory: true)
}
