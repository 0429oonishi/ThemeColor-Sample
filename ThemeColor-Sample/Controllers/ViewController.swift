//
//  ViewController.swift
//  ThemeColor-Sample
//
//  Created by 大西玲音 on 2021/06/28.
//

import UIKit

// 使用例
// モチベーションはカラーコンセプトとサブコンセプトを指定することで、
// 該当のカラー三色を呼び出し元で意識せずに取得すること。
// MARK: - ToDo(Fix)
// (.relax()と関数っぽくなっているところを綺麗にできれば、、、)

final class ViewController: UIViewController {
    
    private let themeColor = ThemeColor(.natural(.craft()))
    private let mainColorView = UIView()
    private let subColorView = UIView()
    private let accentColorView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupLayout()
        
    }
    
    private func setupViews() {
        mainColorView.backgroundColor = themeColor.main
        mainColorView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mainColorView)
        
        subColorView.backgroundColor = themeColor.sub
        subColorView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(subColorView)
        
        accentColorView.backgroundColor = themeColor.accent
        accentColorView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(accentColorView)
    }
    
    private func setupLayout() {
        let mainColorWidth: CGFloat = 300
        NSLayoutConstraint.activate([
            mainColorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            mainColorView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            mainColorView.widthAnchor.constraint(equalToConstant: mainColorWidth),
            mainColorView.heightAnchor.constraint(equalToConstant: mainColorWidth),
        ])
        NSLayoutConstraint.activate([
            subColorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            subColorView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            subColorView.widthAnchor.constraint(equalToConstant: mainColorWidth / 2),
            subColorView.heightAnchor.constraint(equalToConstant: mainColorWidth / 2),
        ])
        NSLayoutConstraint.activate([
            accentColorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            accentColorView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            accentColorView.widthAnchor.constraint(equalToConstant: mainColorWidth / 4),
            accentColorView.heightAnchor.constraint(equalToConstant: mainColorWidth / 4),
        ])
    }
    
    
    
}

