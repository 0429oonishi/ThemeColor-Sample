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
    private struct Section {
        var title: String
        var expanded: Bool
    }
    private struct Row {
        let colors: [UIColor]
    }
    private var sections = [Section]()
    private var rows = [Row]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableViewData()
        setupTableView()
        
    }
    
    private func setupTableViewData() {
        titles.forEach { title in
            sections.append(Section(title: title, expanded: false))
        }
        colors.forEach { colors in
            rows.append(Row(colors: colors))
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCustomCell(AccordionColorTableViewCell.self)
        tableView.registerCustomCell(SectionHeaderView.self)
        tableView.tableFooterView = UIView()
    }
    
}

extension ColorChoicesConceptViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
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
        let cell = tableView.dequeueReusableCustomCell(with: AccordionTableViewCell.self)
        
        return cell
    }
    
    
}
