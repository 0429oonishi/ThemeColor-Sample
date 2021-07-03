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
    
    func configure(row: Row) {
        titleLabel.text = row.title
    }
    
}
