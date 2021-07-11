//
//  ColorChoicesTileViewController.swift
//  ThemeColor-Sample
//
//  Created by 大西玲音 on 2021/06/30.
//

import UIKit

protocol ThemeColorTileViewDelegate: AnyObject {
    func tileViewDidTapped(selectedView: UIView)
}

final class ThemeColorTileView: UIView {
    
    weak var delegate: ThemeColorTileViewDelegate?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0, animations: {
            self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }, completion: { _ in
            UIView.animate(withDuration: 0.1) {
                self.transform = .identity
                self.layer.cornerRadius = self.frame.size.width / 2
            }
        })
        delegate?.tileViewDidTapped(selectedView: self)
    }
    
}

protocol ColorChoicesTileVCDelegate: AnyObject {
    func tileViewDidTapped(selectedView: UIView)
}

final class ColorChoicesTileViewController: UIViewController {
    
    @IBOutlet private weak var themeColorStackView: UIStackView!
    
    private var tileStackViews: [UIStackView] {
        themeColorStackView.arrangedSubviews.map { $0 as! UIStackView }
    }
    private var selectedTileView: UIView?
    weak var delegate: ColorChoicesTileVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTileViews()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(findSameColorTileView),
                                               name: .findSameColor,
                                               object: nil)

    }
    
    private func setupTileViews() {
        tileStackViews.forEach { stackView in
            stackView.arrangedSubviews
                .map { $0 as! ThemeColorTileView }
                .forEach { $0.delegate = self }
        }
    }
    
    @objc private func findSameColorTileView(notification: Notification) {
        let nextSelectedView = notification.userInfo!["selectedView"] as! UIView
        selectedTileView?.layer.cornerRadius = 0
        tileStackViews.forEach { stackView in
            stackView.arrangedSubviews
                .map { $0 as! ThemeColorTileView }
                .forEach { tileView in 
                    let sameColor = (tileView.backgroundColor == nextSelectedView.backgroundColor)
                    let sameAlpha = (tileView.alpha == nextSelectedView.alpha)
                    if sameColor && sameAlpha {
                        tileView.layer.cornerRadius = tileView.frame.size.width / 2
                        self.selectedTileView = tileView
                    }
                }
        }
    }
    
}

extension ColorChoicesTileViewController: ThemeColorTileViewDelegate {
    
    func tileViewDidTapped(selectedView: UIView) {
        delegate?.tileViewDidTapped(selectedView: selectedView)
        UIView.animate(withDuration: 0.1) {
            if self.selectedTileView != selectedView {
                self.selectedTileView?.layer.cornerRadius = 0
            }
        }
        self.selectedTileView = selectedView
    }
    
}
