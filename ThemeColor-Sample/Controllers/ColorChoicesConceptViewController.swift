//
//  ColorChoicesConceptViewController.swift
//  ThemeColor-Sample
//
//  Created by 大西玲音 on 2021/06/30.
//

import UIKit

final class ColorChoicesConceptViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!

    var colorConcept: ColorConcept?
    private var titles: [String] {
        return colorConcept?.subConceptTitles ?? []
    }
    private var colors: [[UIColor]] {
        return colorConcept?.colors ?? []
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCustomCell(ColorSubConceptTableViewCell.self)
        tableView.tableFooterView = UIView()
    }
    
}

extension ColorChoicesConceptViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

extension ColorChoicesConceptViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCustomCell(with: ColorSubConceptTableViewCell.self)
        cell.configure(title: titles[indexPath.row])
        return cell
    }
    
    
}
