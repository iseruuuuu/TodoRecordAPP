//
//  UIApplication+Extension.swift
//  voiceAPP
//
//  Created by user on 2020/09/07.
//  Copyright © 2020 user. All rights reserved.
//キーボードの話


import SwiftUI


extension UIApplication {
    func closeKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder),
                   to: nil,
                   from: nil,
                   for: nil)
    }
}
