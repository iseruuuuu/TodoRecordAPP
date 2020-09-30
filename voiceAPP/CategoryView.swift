//
//  CategoryView.swift
//  voiceAPP
//
//  Created by user on 2020/09/05.
//  Copyright © 2020 user. All rights reserved.
//

import SwiftUI

struct CategoryView: View {
    var Category: Entity.Category
    @State var numberOfTasks = 0
    @State var showList = false
    @Environment(\.managedObjectContext) var viewContext
    @State var addNewtask = false
    
    fileprivate func update() {
        self.numberOfTasks = Entity.count(in: self.viewContext, category: self.Category)
    }
    
    var body: some View {
        
        let gradient = Gradient(colors: [Category.color(), Category.color().opacity(0.8)])
        let linear = LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)
        
        
        
        
        
       return VStack(alignment: .leading) {
                Image(systemName: Category.image())
                    .font(.largeTitle)
                    .sheet(isPresented: $showList, onDismiss: {self.update()}) {
                        Llist(category: self.Category)
                            .environment(\.managedObjectContext,  self.viewContext)
                }
                
                Text(Category.toString())
                Text("・\(numberOfTasks)タスク")
                Button(action:  {
                    self.addNewtask = true
                }) {
              Image(systemName: "plus")
                }.sheet(isPresented: $addNewtask, onDismiss: {self.update()}) { newTask(category: self.Category.rawValue)
                    .environment(\.managedObjectContext, self.viewContext)
                }
            Spacer()
        }
            .padding()
        .frame(maxWidth: .infinity, minHeight: 150)
            .foregroundColor(.white)
            .background(linear)
            .cornerRadius(20)
    .onTapGesture {
            self.showList = true
        }
        .onAppear {
            self.update()
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static let context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext
    static var previews: some View {
        VStack {
            CategoryView(Category: Entity.Category .ImpUrg_1st, numberOfTasks: 100)
            CategoryView(Category: .ImpNUrg_2nd)
            CategoryView(Category: .NImpUrg_3rd)
            CategoryView(Category: .NImpNUrg_4th)
            CategoryView(Category: .NImpNUrg_5th)
            CategoryView(Category: .NImpNUrg_6th)
            
        }.environment(\.managedObjectContext, context)
        
    }
}
