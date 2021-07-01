//
//  ColorConcept.swift
//  ThemeColor-Sample
//
//  Created by 大西玲音 on 2021/06/28.
//

import UIKit

enum ColorConcept: CaseIterable {
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

