//
//  DetailRoww.swift
//  voiceAPP
//
//  Created by user on 2020/09/06.
//  Copyright © 2020 user. All rights reserved.
//

import SwiftUI

struct DetailRoww: View {
    @ObservedObject var todo: Entity
    var hideIcon = false
    var body: some View {
        HStack{
            if !hideIcon {
                CategoryImage(Entity.Category(rawValue: todo.category))
            }
            CheckBox(checked: Binding(get: {
                self.todo.state == Entity.State.done.rawValue
            }, set: {
                self.todo.state = $0 ? Entity.State.done.rawValue :
                    Entity.State.todo.rawValue
            })) {
                if self.todo.state == Entity.State.done.rawValue{
                    Text(self.todo.task ?? "no title").strikethrough()
                } else{
                    Text(self.todo.task ?? "no title")
                }
            }.foregroundColor(self.todo.state == Entity.State.done.rawValue ? .secondary : .primary)
        }.gesture(DragGesture().onChanged({ value in
            if value.predictedEndTranslation.width > 200 {
                if self.todo.state != Entity.State.done.rawValue {
                    self.todo.state = Entity.State.done.rawValue
                }
            } else if value.predictedEndTranslation.width < -200 {
                if self.todo.state != Entity.State.done.rawValue {
                    self.todo.state = Entity.State.done.rawValue
                }
            }
        }))
    }
}

    struct DetailRow_Previews: PreviewProvider {
           static var previews: some View {
            
            
            let context = (UIApplication.shared.delegate as! AppDelegate)
                .persistentContainer.viewContext
            let newTodo = Entity(context: context)
            newTodo.task = "将来への人間関係づくり"
            newTodo.state = Entity.State.done.rawValue
            newTodo.category = 0
            let newTodo1 = Entity(context: context)
            newTodo1.task="クレームへの対応"
            newTodo.category = 1
            let newTodo2 = Entity(context: context)
            newTodo2.task="無意味な接待や付き合い"
            newTodo2.category = 2
            let newTodo3 = Entity(context: context)
            newTodo3.task="長時間、必要以上の息抜き"
            newTodo3.category = 3
            return VStack(alignment: .leading) {
                VStack {
                    DetailRoww(todo: newTodo)
                    DetailRoww(todo: newTodo, hideIcon: true)
                    DetailRoww(todo: newTodo1)
                    DetailRoww(todo: newTodo2)
                    DetailRoww(todo: newTodo3)
                }.environment(\.managedObjectContext, context)
            }

            
            
           }
       }

   
