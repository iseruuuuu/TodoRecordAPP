//
//  CategoryImage.swift
//  voiceAPP
//
//  Created by user on 2020/09/05.
//  Copyright © 2020 user. All rights reserved.
//

import SwiftUI

struct CategoryImage: View {
    
    var category: Entity.Category
    
    init(_ category: Entity.Category?) {
        self.category = category ?? .ImpUrg_1st
    }
    
    var body: some View {
        Image(systemName: category.image())
            .resizable()
            .scaledToFit()
            .foregroundColor(.white)
            .frame(width: 35, height: 35)
            .background(category.color())
            .cornerRadius(40.0)
    }
}
struct CategoryImage_Previews: PreviewProvider {
    static var previews: some View {
        CategoryImage(Entity.Category.ImpUrg_1st)
    }
}
