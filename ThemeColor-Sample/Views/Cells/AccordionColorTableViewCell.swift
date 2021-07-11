//
//  AccordionColorTableViewCell.swift
//  ThemeColor-Sample
//
//  Created by 大西玲音 on 2021/07/11.
//

import UIKit

final class AccordionColorTableViewCell: UITableViewCell {

    @IBOutlet private weak var leftTileView: ThemeColorTileView!
    @IBOutlet private weak var centerTileView: ThemeColorTileView!
    @IBOutlet private weak var rightTileView: ThemeColorTileView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(colors: [UIColor]) {
        leftTileView.backgroundColor = colors[0]
        centerTileView.backgroundColor = colors[1]
        rightTileView.backgroundColor = colors[2]
    }
    
}
