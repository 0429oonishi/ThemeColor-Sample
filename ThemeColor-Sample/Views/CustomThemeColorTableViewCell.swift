//
//  CustomThemeColorTableViewCell.swift
//  ThemeColor-Sample
//
//  Created by 大西玲音 on 2021/06/28.
//

import UIKit

final class CustomThemeColorTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var view: UIView!
    
    static var identifier: String { String(describing: self) }
    static var nib: UINib { UINib(nibName: String(describing: self), bundle: nil) }
    var onTapEvent: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(didTapped))
        self.view.addGestureRecognizer(tapGR)
        
    }
    
    @objc private func didTapped() {
        onTapEvent?()
    }
    
    func configure(row: Row, onTapEvent: @escaping () -> Void) {
        titleLabel.text = row.title
        self.onTapEvent = onTapEvent 
    }
    
}
