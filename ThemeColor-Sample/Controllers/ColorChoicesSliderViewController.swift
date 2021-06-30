//
//  ColorChoicesSliderViewController.swift
//  ThemeColor-Sample
//
//  Created by 大西玲音 on 2021/06/30.
//

import UIKit

final class ColorChoicesSliderViewController: UIViewController {
    
    @IBOutlet private weak var redNumberLabel: UILabel!
    @IBOutlet private weak var greenNumberLabel: UILabel!
    @IBOutlet private weak var blueNumberLabel: UILabel!
    @IBOutlet private weak var alphaNumberLabel: UILabel!
    @IBOutlet private weak var redSlider: UISlider!
    @IBOutlet private weak var greenSlider: UISlider!
    @IBOutlet private weak var blueSlider: UISlider!
    @IBOutlet private weak var alphaSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction private func redSliderValueDidChanged(_ sender: UISlider) {
        redNumberLabel.text = String(Int(sender.value))
    }
    
    @IBAction private func greenSliderValueDidChanged(_ sender: UISlider) {
        greenNumberLabel.text = String(Int(sender.value))
    }
    
    @IBAction private func blueSliderValueDidChanged(_ sender: UISlider) {
        blueNumberLabel.text = String(Int(sender.value))
    }
    
    @IBAction private func alphaSliderValueDidChanged(_ sender: UISlider) {
        alphaNumberLabel.text = String(Int(sender.value))
    }
    
}
