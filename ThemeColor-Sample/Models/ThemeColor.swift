//
//  ThemeColor.swift
//  ThemeColor-Sample
//
//  Created by 大西玲音 on 2021/06/28.
//

import UIKit

struct ThemeColor {
    var main: UIColor
    var sub: UIColor
    var accent: UIColor
    
    init(main: UIColor, sub: UIColor, accent: UIColor) {
        self.main = main
        self.sub = sub
        self.accent = accent
    }
    
    init(_ concept: ColorConcept) {
        let colors = concept.colors
        if colors.count != 3 {
            fatalError("要素数が一致しません。")
        }
        self.main = colors[0]
        self.sub = colors[1]
        self.accent = colors[2]
    }
}
