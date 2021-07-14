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
        imageView.image = UIImage(systemName: "eyedropper")
        imageView.tintColor = .black
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
        mainColorView.hideImage(false)
        lastSelectedThemeColorView = mainColorView
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mainColorView.backgroundColor = ThemeColor.main
        subColorView.backgroundColor = ThemeColor.sub
        accentColorView.backgroundColor = ThemeColor.accent
        setThemeSubViewColor(view: mainColorView)
        setThemeSubViewColor(view: subColorView)
        setThemeSubViewColor(view: accentColorView)
        
        NotificationCenter.default.post(name: .themeColor,
                                        object: nil,
                                        userInfo: ["selectedView": mainColorView!])
        
    }
    
    private func setupImageView(view: ThemeColorView) {
        view.addSubview(view.imageView)
        NSLayoutConstraint.activate([
            view.imageView.heightAnchor.constraint(equalToConstant: 40),
            view.imageView.widthAnchor.constraint(equalToConstant: 40),
            view.imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            view.imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        view.imageView.isHidden = true
    }
    
    private func setThemeSubViewColor(view: ThemeColorView) {
        guard let color = view.backgroundColor else { fatalError() }
        view.subviews.forEach { view in
            let shouldWhite = (color.redValue < 0.4
                                && color.greenValue < 0.4
                                && color.blueValue < 0.4
                                && color.alphaValue > 0.5)
            if let imageView = view as? UIImageView {
                imageView.tintColor = { shouldWhite ? .white : .black }()
            }
            if let label = view as? UILabel {
                label.textColor = { shouldWhite ? .white : .black }()
            }
        }
    }
    
    @IBAction private func segmentedControlDidSelected(_ sender: UISegmentedControl) {
        // enum ContainerTypeにあわせるために+1する。
        containerType = ContainerType(rawValue: sender.selectedSegmentIndex + 1)!
        containerView.bringSubviewToFront(currentContainerView)
    }
    
    @IBAction private func saveButtonDidTapped(_ sender: Any) {
        UserDefaults.standard.save(color: mainColorView.backgroundColor, .main)
        UserDefaults.standard.save(color: subColorView.backgroundColor, .sub)
        UserDefaults.standard.save(color: accentColorView.backgroundColor, .accent)
        self.navigationController?.popToRootViewController(animated: true)
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
        setThemeSubViewColor(view: lastSelectedThemeColorView as! ThemeColorView)
    }
    
}

extension ThemeColorViewController: ColorChoicesSliderVCDelegate {
    
    func sliderValueDidChanged(view: UIView) {
        lastSelectedThemeColorView?.backgroundColor = view.backgroundColor
        lastSelectedThemeColorView?.alpha = view.alpha
        setThemeSubViewColor(view: lastSelectedThemeColorView as! ThemeColorView)
    }
    
}

extension ThemeColorViewController: ColorChoicesConceptVCDelegate {
    
    func subConceptTileViewDidTapped(view: UIView) {
        lastSelectedThemeColorView?.backgroundColor = view.backgroundColor
        lastSelectedThemeColorView?.alpha = view.alpha
        mainColorView.hideImage(true)
        subColorView.hideImage({ scheme != .main }())
        accentColorView.hideImage({ scheme != .sub }())
        switchTheme(scheme: scheme)
    }
    
    func subConceptTitleDidTapped(isExpanded: Bool) {
        mainColorView.hideImage(!isExpanded)
        subColorView.hideImage(true)
        accentColorView.hideImage(true)
        switchTheme()
    }
    
    private func switchTheme(scheme: ColorSchemeType? = nil) {
        switch scheme {
            case .main:
                lastSelectedThemeColorView = subColorView
                self.scheme = .sub
            case .sub:
                lastSelectedThemeColorView = accentColorView
                self.scheme = .accent
            case .accent:
                lastSelectedThemeColorView = nil
            case nil:
                lastSelectedThemeColorView = mainColorView
                self.scheme = .main
        }
    }
    
}

extension ThemeColorViewController: ThemeColorViewDelegate {
    
    func themeColorViewDidTapped(nextSelectedView: UIView) {
        guard lastSelectedThemeColorView != nil else { return }
        let isSameViewDidTapped = (lastSelectedThemeColorView == nextSelectedView)
        let _nextSelectedView = (nextSelectedView as! ThemeColorView)
        let _lastSelectedThemeColorView = (lastSelectedThemeColorView as! ThemeColorView)
        if !isSameViewDidTapped {
            _nextSelectedView.hideImage(false)
            _lastSelectedThemeColorView.hideImage(true)
            NotificationCenter.default.post(name: .themeColor,
                                            object: nil,
                                            userInfo: ["selectedView": nextSelectedView])
        }
        setThemeSubViewColor(view: _nextSelectedView)
        lastSelectedThemeColorView = nextSelectedView
    }
    
}
