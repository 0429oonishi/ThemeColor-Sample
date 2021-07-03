//
//  ColorConceptTableViewCell.swift
//  ThemeColor-Sample
//
//  Created by 大西玲音 on 2021/06/29.
//

import UIKit

final class ColorConceptTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.6
        layer.shadowRadius = 3
        layer.shadowOffset = CGSize(width: 2, height: 2)
        backgroundColor = .clear
        backView.layer.cornerRadius = 10
        
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
    
}
