//
//  ThemeColorViewController.swift
//  ThemeColor-Sample
//
//  Created by 大西玲音 on 2021/06/28.
//

import UIKit

final class ThemeColorViewController: UIViewController {
    
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var colorChoicesConceptContainerView: UIView!
    @IBOutlet private weak var colorChoicesTileContainerView: UIView!
    @IBOutlet private weak var colorChoicesSliderContainerView: UIView!

    private static var identifier: String { String(describing: self) }
    private var navTitle = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = navTitle
        
    }
    
    static func instantiate(navTitle: String) -> ThemeColorViewController {
        let themeColorVC = UIStoryboard(
            name: "ThemeColor",
            bundle: nil
        ).instantiateViewController(
            withIdentifier: ThemeColorViewController.identifier
        ) as! ThemeColorViewController
        themeColorVC.navTitle = navTitle
        return themeColorVC
    }
    
}
