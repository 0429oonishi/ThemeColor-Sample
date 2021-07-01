//
//  ColorConcept.swift
//  ThemeColor-Sample
//
//  Created by 大西玲音 on 2021/06/28.
//

import UIKit

enum ColorConcept: Int, CaseIterable {
    case natural
    case pop
    case elegant
    case modern
    case season
    case japan
    case overseas
    case service
    var title: String {
        switch self {
            case .natural: return "ナチュラル"
            case .pop: return "ポップ"
            case .elegant: return "エレガント"
            case .modern: return "モダン"
            case .season: return "シーズン"
            case .japan: return "ジャパン"
            case .overseas: return "オーバーシーズ"
            case .service: return "サービス"
        }
    }
    var subConceptTitles: [String] {
        switch self {
            case .natural: return NaturalConcept.allCases.map { $0.title }
            case .pop:
                <#code#>
            case .elegant:
                <#code#>
            case .modern:
                <#code#>
            case .season:
                <#code#>
            case .japan:
                <#code#>
            case .overseas:
                <#code#>
            case .service:
                <#code#>
        }
    }
    var colors: [[UIColor]] {
        switch self {
            case .natural: return NaturalConcept.allCases.map { $0.colors }
            case .pop:
                <#code#>
            case .elegant:
                <#code#>
            case .modern:
                <#code#>
            case .season:
                <#code#>
            case .japan:
                <#code#>
            case .overseas:
                <#code#>
            case .service:
                <#code#>
        }
    }
}

enum NaturalConcept: CaseIterable {
    case relax
    case feminine
    case organic
    case craft
    case living
    case botanical
    var title: String {
        switch self {
            case .relax: return "リラックス"
            case .feminine: return "フェミニン"
            case .organic: return "オーガニック"
            case .craft: return "クラフト"
            case .living: return "リビング"
            case .botanical: return "ボタニカル"
        }
    }
    var colors: [UIColor] {
        switch self {
            case .relax: return [.Natural.Relax.eggIvory,
                                 .Natural.Relax.softBuff,
                                 .Natural.Relax.mistMossGreen]
            case .feminine: return [.Natural.Feminine.grandmaPink,
                                    .Natural.Feminine.blueVanilla,
                                    .Natural.Feminine.grandmaPurple]
            case .organic: return [.Natural.Organic.pattyGray,
                                   .Natural.Organic.classicPink,
                                   .Natural.Organic.smoothGreen]
            case .craft: return [.Natural.Craft.twilightGray,
                                 .Natural.Craft.sharpGray,
                                 .Natural.Craft.japaneseKai]
            case .living: return [.Natural.Living.creamBlue,
                                  .Natural.Living.northOcean,
                                  .Natural.Living.shineMuscat]
            case .botanical: return [.Natural.Botanical.clearWater,
                                     .Natural.Botanical.fineweed,
                                     .Natural.Botanical.babyLeaf]
        }
    }
}

enum PopConcept {
    
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
        
    }
    
}
