//
//  ColorSubConceptTableViewCell.swift
//  ThemeColor-Sample
//
//  Created by 大西玲音 on 2021/07/01.
//

import UIKit

final class ColorSubConceptTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    static var identifier: String { String(describing: self) }
    static var nib: UINib { UINib(nibName: String(describing: self), bundle: nil) }
    
    func configure(title: String) {
        titleLabel.text = title
    }
    
}
