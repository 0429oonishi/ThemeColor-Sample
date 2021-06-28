//
//  ColorConcept.swift
//  ThemeColor-Sample
//
//  Created by 大西玲音 on 2021/06/28.
//

import UIKit

// MARK: - ToDo(Fix)
// 命名がextension UIColorのところとかぶっているが、
// タイピングや誤入力を事前に防ぐようにするためにこのような書き方にしている。
// もっと良いやり方が分かり次第、修正する。(名前空間を使っても補完する方法)

enum ColorConcept {
    
    case natural(_ subConcept: NaturalConcept)
    case pop(_ subConcept: PopConcept)
    var colors: [UIColor] {
        switch self {
            case .natural(.relax(let colors)): return colors
            case .natural(.feminine(let colors)): return colors
            case .natural(.organic(let colors)): return colors
            case .natural(.craft(let colors)): return colors
            case .natural(.living(let colors)): return colors
            case .natural(.botanical(let colors)): return colors
            case .pop(.a(let colors)): return colors
            case .pop(.b(let colors)): return colors
            // ...
        }
    }
}

enum NaturalConcept {
    case relax(_ colors: [UIColor] = [.Natural.Relax.eggIvory,
                                      .Natural.Relax.softBuff,
                                      .Natural.Relax.mistMossGreen])
    case feminine(_ colors: [UIColor] = [.Natural.Feminine.grandmaPink,
                                         .Natural.Feminine.blueVanilla,
                                         .Natural.Feminine.grandmaPurple])
    case organic(_ colors: [UIColor] = [.Natural.Organic.pattyGray,
                                        .Natural.Organic.classicPink,
                                        .Natural.Organic.smoothGreen])
    case craft(_ colors: [UIColor] = [.Natural.Craft.twilightGray,
                                      .Natural.Craft.sharpGray,
                                      .Natural.Craft.japaneseKai])
    case living(_ colors: [UIColor] = [.Natural.Living.creamBlue,
                                       .Natural.Living.northOcean,
                                       .Natural.Living.shineMuscat])
    case botanical(_ colors: [UIColor] = [.Natural.Botanical.clearWater,
                                          .Natural.Botanical.fineweed,
                                          .Natural.Botanical.babyLeaf])
}

enum PopConcept {
    // MARK: - ToDo あとでちゃんとかく
    case a(_ colors: [UIColor] = [.Pop.A.sampleColor,
                                  .Pop.A.sampleColor2,
                                  .Pop.A.sampleColor3])
    case b(_ colors: [UIColor] = [.red, .blue, .green])
}

private extension UIColor {
    
    struct Natural {
        struct Relax {
            static let eggIvory = UIColor(hex: "f3eed5")
            static let softBuff = UIColor(hex: "e4af9b")
            static let mistMossGreen = UIColor(hex: "d4dfbb") 
        }
        struct Feminine {
            static let grandmaPink = UIColor(hex: "e6c5cf")
            static let blueVanilla = UIColor(hex: "bdd8dd")
            static let grandmaPurple = UIColor(hex: "af9dc0")
        }
        struct Organic {
            static let pattyGray = UIColor(hex: "d9d8ce")
            static let classicPink = UIColor(hex: "e0b6a9")
            static let smoothGreen = UIColor(hex: "d3e9d0")
        }
        struct Craft {
            static let twilightGray = UIColor(hex: "dcd5c8")
            static let sharpGray = UIColor(hex: "a2a2ad")
            static let japaneseKai = UIColor(hex: "1f1e63")
        }
        struct Living {
            static let creamBlue = UIColor(hex: "e0f1f1")
            static let northOcean = UIColor(hex: "5188b1")
            static let shineMuscat = UIColor(hex: "aed265")
        }
        struct Botanical {
            static let clearWater = UIColor(hex: "d9eaec")
            static let fineweed = UIColor(hex: "74a64c")
            static let babyLeaf = UIColor(hex: "bcd537")
        }
    }
    
    struct Pop {
        struct A {
            // MARK: - ToDo あとでちゃんとした値を入れる
            static let sampleColor = UIColor(hex: "111111")
            static let sampleColor2 = UIColor(hex: "222222")
            static let sampleColor3 = UIColor(hex: "333333")
        }
        struct B {
            
        }
    }
    
    // ...
    
}
