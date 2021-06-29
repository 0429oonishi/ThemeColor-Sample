//
//  ColorConceptViewController.swift
//  ThemeColor-Sample
//
//  Created by 大西玲音 on 2021/06/28.
//

import UIKit

final class ColorConceptViewController: UIViewController {
    
    private static var identifier: String { String(describing: self) }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    static func instantiate() -> ColorConceptViewController {
        let colorConceptVC = UIStoryboard(
            name: "ColorConcept",
            bundle: nil
        ).instantiateViewController(
            withIdentifier: ColorConceptViewController.identifier
        ) as! ColorConceptViewController
        return colorConceptVC
    }
    
}
