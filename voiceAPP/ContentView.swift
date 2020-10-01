//
//  ContentView.swift
//  voiceAPP
//
//  Created by user on 2020/09/05.
//  Copyright © 2020 user. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack (spacing: 0) {
            Color.tBackground
            .edgesIgnoringSafeArea(.top)
            .frame(height:0)
                /*userView(image: Image("iseki"), userName: "Ryu", conment: "プロフィール文がまだありません。")*/
            //VStack {
            
            HStack (spacing: 0){
            CategoryView(Category: .ImpUrg_1st)
            Spacer()
            CategoryView(Category: .ImpNUrg_2nd)
        }
            HStack (spacing: 0){
            CategoryView(Category: .NImpUrg_3rd)
            Spacer()
            CategoryView(Category: .NImpNUrg_4th)
        }
            HStack (spacing: 0){
            CategoryView(Category: .NImpNUrg_5th)
            Spacer()
            CategoryView(Category: .NImpNUrg_6th)
        }
            }
        .padding()
        .background(Color.tBackground)
            .edgesIgnoringSafeArea(.bottom)
    }
    }
   
//}

struct ContentView_Previews: PreviewProvider {
    static let context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext
    static var previews: some View {
        ContentView()
        .environment(\.managedObjectContext, context)
    }
}
