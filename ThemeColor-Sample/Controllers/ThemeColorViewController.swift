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

enum ColorSchemeType {
    case main
    case sub
    case accent
}

protocol ThemeColorViewDelegate: AnyObject {
    func themeColorViewDidTapped(nextSelectedView: UIView)
}

final class ThemeColorView: UIView {
    
    weak var delegate: ThemeColorViewDelegate?
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark")
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.themeColorViewDidTapped(nextSelectedView: self)
    }
    
    func hideImage(_ isHidden: Bool) {
        imageView.isHidden = isHidden
    }
    
}

final class ThemeColorViewController: UIViewController {
    
    @IBOutlet private weak var mainColorView: ThemeColorView!
    @IBOutlet private weak var subColorView: ThemeColorView!
    @IBOutlet private weak var accentColorView: ThemeColorView!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var segmentedControlBackView: UIView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var colorChoicesConceptContainerView: UIView!
    @IBOutlet private weak var colorChoicesTileContainerView: UIView!
    @IBOutlet private weak var colorChoicesSliderContainerView: UIView!
    
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
    private var lastSelectedThemeColorView: UIView?
    private var scheme: ColorSchemeType = .main
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.bringSubviewToFront(currentContainerView)
        
        self.navigationItem.title = navTitle
        
        mainColorView.delegate = self
        subColorView.delegate = self
        accentColorView.delegate = self
        
        setupImageView(view: mainColorView)
        setupImageView(view: subColorView)
        setupImageView(view: accentColorView)
        mainColorView.imageView.isHidden = false
        lastSelectedThemeColorView = mainColorView
        
        NotificationCenter.default.post(name: .themeColor,
                                        object: nil,
                                        userInfo: ["selectedView": mainColorView!])
        
        switch containerType {
            case .concept:
                segmentedControlBackView.isHidden = true
                let colorChoicesConceptVC = self.children[0] as! ColorChoicesConceptViewController
                colorChoicesConceptVC.colorConcept = colorConcept
                colorChoicesConceptVC.delegate = self
                mainColorView.isUserInteractionEnabled = false
                subColorView.isUserInteractionEnabled = false
                accentColorView.isUserInteractionEnabled = false
                
            case .tile, .slider:
                let colorChoicesTileVC = self.children[1] as! ColorChoicesTileViewController
                colorChoicesTileVC.delegate = self
                
                let colorChoicesSliderVC = self.children[2] as! ColorChoicesSliderViewController
                colorChoicesSliderVC.delegate = self
        }
        
    }
    
    private func setupImageView(view: ThemeColorView) {
        view.addSubview(view.imageView)
        NSLayoutConstraint.activate([
            view.imageView.heightAnchor.constraint(equalToConstant: 50),
            view.imageView.widthAnchor.constraint(equalToConstant: 50),
            view.imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            view.imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        view.imageView.isHidden = true
    }
    
    @IBAction private func segmentedControlDidSelected(_ sender: UISegmentedControl) {
        // enum ContainerTypeにあわせるために+1する。
        containerType = ContainerType(rawValue: sender.selectedSegmentIndex + 1)!
        containerView.bringSubviewToFront(currentContainerView)
    }
    
    @IBAction private func saveButtonDidTapped(_ sender: Any) {
        // MARK: - ToDo 保存処理
        self.navigationController?.popViewController(animated: true)
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

extension ThemeColorViewController: ColorChoicesTileVCDelegate {
    
    func tileViewDidTapped(selectedView: UIView) {
        lastSelectedThemeColorView?.backgroundColor = selectedView.backgroundColor
        lastSelectedThemeColorView?.alpha = selectedView.alpha
    }
    
}

extension ThemeColorViewController: ColorChoicesSliderVCDelegate {
    
    func sliderValueDidChanged(view: UIView) {
        lastSelectedThemeColorView?.backgroundColor = view.backgroundColor
        lastSelectedThemeColorView?.alpha = view.alpha
    }
    
}

extension ThemeColorViewController: ColorChoicesConceptVCDelegate {
    
    func subConceptTileViewDidTapped(view: UIView) {
        lastSelectedThemeColorView?.backgroundColor = view.backgroundColor
        lastSelectedThemeColorView?.alpha = view.alpha
        switch scheme {
            case .main:
                mainColorView.hideImage(true)
                subColorView.hideImage(false)
                lastSelectedThemeColorView = subColorView
                scheme = .sub
            case .sub:
                subColorView.hideImage(true)
                accentColorView.hideImage(false)
                lastSelectedThemeColorView = accentColorView
                scheme = .accent
            case .accent:
                accentColorView.hideImage(true)
                mainColorView.hideImage(true)
                lastSelectedThemeColorView = nil
        }
        
    }
    
    func subConceptTitleDidTapped(isExpanded: Bool) {
        mainColorView.hideImage(!isExpanded)
        subColorView.hideImage(true)
        accentColorView.hideImage(true)
        lastSelectedThemeColorView = mainColorView
        scheme = .main
    }
    
}

extension ThemeColorViewController: ThemeColorViewDelegate {
    
    func themeColorViewDidTapped(nextSelectedView: UIView) {
        guard lastSelectedThemeColorView != nil else { return }
        let isSameViewDidTapped = (lastSelectedThemeColorView == nextSelectedView)
        let _nextSelectedView = (nextSelectedView as! ThemeColorView)
        let _lastSelectedThemeColorView = (lastSelectedThemeColorView as! ThemeColorView)
        if !isSameViewDidTapped {
            _nextSelectedView.imageView.isHidden = false
            _lastSelectedThemeColorView.imageView.isHidden = true
            NotificationCenter.default.post(name: .themeColor,
                                            object: nil,
                                            userInfo: ["selectedView": nextSelectedView])
        }
        lastSelectedThemeColorView = nextSelectedView
    }
    
}
