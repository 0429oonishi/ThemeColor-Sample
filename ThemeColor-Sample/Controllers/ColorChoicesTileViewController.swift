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
    weak var delegate: ColorChoicesTileVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTileViews()
        
    }
    
    private func setupTileViews() {
        tileStackViews.forEach {
            $0.arrangedSubviews
                .map { $0 as! ThemeColorTileView }
                .forEach { $0.delegate = self }
        }
    }
    
    
}

extension ColorChoicesTileViewController: ThemeColorTileViewDelegate {
    
    func tileViewDidTapped(selectedView: UIView) {
        delegate?.tileViewDidTapped(selectedView: selectedView)
    }
    
}
