//
//  ColorChoicesSliderViewController.swift
//  ThemeColor-Sample
//
//  Created by 大西玲音 on 2021/06/30.
//

import UIKit

protocol ColorChoicesSliderVCDelegate: AnyObject {
    func sliderValueDidChanged(view: UIView)
}

final class ColorChoicesSliderViewController: UIViewController {
    
    @IBOutlet private weak var redNumberLabel: UILabel!
    @IBOutlet private weak var greenNumberLabel: UILabel!
    @IBOutlet private weak var blueNumberLabel: UILabel!
    @IBOutlet private weak var alphaNumberLabel: UILabel!
    @IBOutlet private weak var redSlider: UISlider!
    @IBOutlet private weak var greenSlider: UISlider!
    @IBOutlet private weak var blueSlider: UISlider!
    @IBOutlet private weak var alphaSlider: UISlider!
    
    weak var delegate: ColorChoicesSliderVCDelegate?
    private var sliderView: UIView!
    private var redValue: CGFloat = 0
    private var greenValue: CGFloat = 0
    private var blueValue: CGFloat = 0
    private var alpha: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(adjustSliders),
                                               name: .themeColor,
                                               object: nil)
        
    }
    
    @objc private func adjustSliders(notification: Notification) {
        let nextSelectedView = notification.userInfo!["selectedView"] as! UIView
        redValue = round(nextSelectedView.backgroundColor!.redValue * 255)
        greenValue = round(nextSelectedView.backgroundColor!.greenValue * 255)
        blueValue = round(nextSelectedView.backgroundColor!.blueValue * 255)
        alpha = (round(nextSelectedView.alpha * 10) / 10) * 100
        sliderView = UIView()
        redNumberLabel.text = String(Int(redValue))
        greenNumberLabel.text = String(Int(greenValue))
        blueNumberLabel.text = String(Int(blueValue))
        alphaNumberLabel.text = String(Int(alpha))
        redSlider.value = Float(redValue)
        greenSlider.value = Float(greenValue)
        blueSlider.value = Float(blueValue)
        alphaSlider.value = Float(alpha)
    }
    
    @IBAction private func redSliderValueDidChanged(_ sender: UISlider) {
        redValue = CGFloat(sender.value)
        sliderView.backgroundColor = UIColor.rgba(red: redValue, green: greenValue, blue: blueValue, alpha: alpha)
        delegate?.sliderValueDidChanged(view: sliderView)
        NotificationCenter.default.post(name: .initTileView, object: nil)
        redNumberLabel.text = String(Int(sender.value))
    }
    
    @IBAction private func greenSliderValueDidChanged(_ sender: UISlider) {
        greenValue = CGFloat(sender.value)
        sliderView.backgroundColor = UIColor.rgba(red: redValue, green: greenValue, blue: blueValue, alpha: alpha)
        delegate?.sliderValueDidChanged(view: sliderView)
        NotificationCenter.default.post(name: .initTileView, object: nil)
        greenNumberLabel.text = String(Int(sender.value))
    }
    
    @IBAction private func blueSliderValueDidChanged(_ sender: UISlider) {
        blueValue = CGFloat(sender.value)
        sliderView.backgroundColor = UIColor.rgba(red: redValue, green: greenValue, blue: blueValue, alpha: alpha)
        delegate?.sliderValueDidChanged(view: sliderView)
        NotificationCenter.default.post(name: .initTileView, object: nil)
        blueNumberLabel.text = String(Int(sender.value))
    }
    
    @IBAction private func alphaSliderValueDidChanged(_ sender: UISlider) {
        alpha = CGFloat(sender.value)
        sliderView.backgroundColor = UIColor.rgba(red: redValue, green: greenValue, blue: blueValue, alpha: alpha)
        delegate?.sliderValueDidChanged(view: sliderView)
        NotificationCenter.default.post(name: .initTileView, object: nil)
        alphaNumberLabel.text = String(Int(sender.value))
    }
    
}

private extension UIColor {
    
    static func rgba(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        let rgb = [red, green, blue].map { value -> CGFloat in
            if value < 0 { return 0 }
            if value > 255 { return 1 }
            return value / 255
        }
        let alpha: CGFloat = {
            if alpha > 100 { return 1 }
            if alpha < 0 { return 0 }
            return CGFloat(alpha) / 100
        }()
        return self.init(red: rgb[0], green: rgb[1], blue: rgb[2], alpha: alpha)
    }
    
}
