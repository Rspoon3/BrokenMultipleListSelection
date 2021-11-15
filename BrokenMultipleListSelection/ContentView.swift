//
//  ContentView.swift
//  BrokenMultipleListSelection
//
//  Created by Richard Witherspoon on 11/15/21.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = Set<Int>()
    @State private var viewType = ViewType.working
    
    enum ViewType: String, CaseIterable{
        case working, broken, workAround
    }
    
    var body: some View {
        NavigationView{
            VStack{
                Picker("View Type", selection: $viewType){
                    ForEach(ViewType.allCases, id: \.self) { viewType in
                        Text(viewType.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                .onChange(of: viewType) { _ in
                    selection.removeAll()
                }
                
                switch viewType {
                case .working:
                    WorkingList(selection: $selection)
                case .broken:
                    BrokenList(selection: $selection)
                case .workAround:
                    WorkAroundList(selection: $selection)
                }
            }
            .toolbar {
                EditButton()
            }
            .navigationTitle("Selected (\(selection.count))")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct WorkingList: View {
    @Binding var selection: Set<Int>
    
    var body: some View {
        List(selection: $selection){
            ForEach(0..<20){ i in
                Text("This is row \(i)")
                    .contextMenu{
                        Button("Print Title"){
                            print("This is row \(i)")
                        }
                    }
            }
        }
    }
}



struct BrokenList: View {
    @Binding var selection: Set<Int>
    
    var body: some View {
        List(selection: $selection){
            ForEach(0..<20){ i in
                NavigationLink {
                    Text("This is row \(i)")
                } label: {
                    Text("This is row \(i)")
                }
                .contextMenu{
                    Button("Print Title"){
                        print("This is row \(i)")
                    }
                }
            }
        }
    }
}



struct WorkAroundList: View {
    @Binding var selection: Set<Int>
    @Environment(\.editMode) var editMode
    
    var body: some View {
        List(selection: $selection){
            ForEach(0..<20){ i in
                NavigationLink {
                    Text("This is row \(i)")
                } label: {
                    Text("This is row \(i)")
                }
                .contextMenu{
                    if editMode?.wrappedValue == .inactive{
                        Button("Print Title"){
                            print("This is row \(i)")
                        }
                    }
                }
            }
        }
    }
}
