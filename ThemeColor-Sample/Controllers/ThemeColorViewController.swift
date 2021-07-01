//
//  ThemeColorViewController.swift
//  ThemeColor-Sample
//
//  Created by 大西玲音 on 2021/06/28.
//

import UIKit

enum ContainerType: Int {
    case concept
    case tile
    case slider
}

final class ThemeColorViewController: UIViewController {
    
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var segmentedControlBackView: UIView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var colorChoicesConceptContainerView: UIView!
    @IBOutlet private weak var colorChoicesTileContainerView: UIView!
    @IBOutlet private weak var colorChoicesSliderContainerView: UIView!
    
    private static var identifier: String { String(describing: self) }
    private var containerType: ContainerType = .tile
    private var currentContainerView: UIView {
        switch containerType {
            case .concept: return colorChoicesConceptContainerView
            case .tile: return colorChoicesTileContainerView
            case .slider: return colorChoicesSliderContainerView
        }
    }
    private var navTitle = ""
    private var colorConcept: ColorConcept?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.bringSubviewToFront(currentContainerView)
        if containerType == .concept {
            segmentedControlBackView.isHidden = true
            let colorChoicesConceptVC = self.children[0] as! ColorChoicesConceptViewController
            colorChoicesConceptVC.colorConcept = colorConcept
        }
        self.navigationItem.title = navTitle
        
    }
    
    @IBAction private func segmentedControlDidSelected(_ sender: UISegmentedControl) {
        // enum ContainerTypeにあわせるために+1する。
        containerType = ContainerType(rawValue: sender.selectedSegmentIndex + 1)!
        containerView.bringSubviewToFront(currentContainerView)
    }
    
    static func instantiate(containerType: ContainerType,
                            colorConcept: ColorConcept?) -> ThemeColorViewController {
        let themeColorVC = UIStoryboard(
            name: "ThemeColor",
            bundle: nil
        ).instantiateViewController(
            withIdentifier: ThemeColorViewController.identifier
        ) as! ThemeColorViewController
        themeColorVC.containerType = containerType
        let navTitle = colorConcept?.title ?? "セルフ"
        themeColorVC.navTitle = navTitle
        themeColorVC.colorConcept = colorConcept
        return themeColorVC
    }
    
}
