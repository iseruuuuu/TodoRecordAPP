//
//  userView.swift
//  voiceAPP
//
//  Created by user on 2020/09/05.
//  Copyright © 2020 user. All rights reserved.
//

//このファイルは使わない。

import SwiftUI

struct userView: View {
    
    let image: Image
    let userName: String
    let conment: String
    
    var body: some View {
        HStack {
            image
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text("\(userName)")
                    .foregroundColor(Color.tTitle)
                    .font(.title)
                Text("")
                Text("")
                Text("\(conment)")
                    .foregroundColor(Color.tTitle)
                    .font(.footnote)
                
            }
            
        }
        .background(Color.tBackground)
        .padding()
        
    }
    
}


struct userView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            userView(image: Image("iseki"), userName: "Ryu", conment: "プロフィール文がまだありません。")
            Circle()
        }
    }
}
