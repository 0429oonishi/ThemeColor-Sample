//
//  ThemeColorViewController.swift
//  ThemeColor-Sample
//
//  Created by 大西玲音 on 2021/06/28.
//

import UIKit

final class ThemeColorViewController: UIViewController {
    
    private static var identifier: String { String(describing: self) }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    static func instantiate() -> ThemeColorViewController {
        let themeColorVC = UIStoryboard(
            name: "ThemeColor",
            bundle: nil
        ).instantiateViewController(
            withIdentifier: ThemeColorViewController.identifier
        ) as! ThemeColorViewController
        return themeColorVC
        
    }
    
}
