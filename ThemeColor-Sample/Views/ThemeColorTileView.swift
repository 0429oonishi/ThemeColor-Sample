//
//  ThemeColorTileView.swift
//  ThemeColor-Sample
//
//  Created by 大西玲音 on 2021/08/01.
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
