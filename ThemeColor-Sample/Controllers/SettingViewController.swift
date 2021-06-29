//
//  SettingViewController.swift
//  ThemeColor-Sample
//
//  Created by 大西玲音 on 2021/06/28.
//

import UIKit

struct Section {
    var title: String
    var expanded: Bool
    static let data = [Section(title: "A", expanded: false),
                       Section(title: "テーマカラー", expanded: false),
                       Section(title: "B", expanded: false),
                       Section(title: "C", expanded: false)]
}

struct Row {
    let title: String
    static let data = [Row(title: "セルフ"),
                       Row(title: "オススメ")]
}

final class SettingViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var sections = Section.data
    private let rows = Row.data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomThemeColorTableViewCell.nib,
                           forCellReuseIdentifier: CustomThemeColorTableViewCell.identifier)
        tableView.register(SectionHeaderView.nib,
                           forHeaderFooterViewReuseIdentifier: SectionHeaderView.identifier)
        tableView.tableFooterView = UIView()
    }
    
}

extension SettingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sections[indexPath.section].expanded ? 60 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionHeaderView.identifier) as! SectionHeaderView
        let mySection = sections[section]
        headerView.configure(section: mySection) { [weak self] in
            if self?.sections[section].title == "テーマカラー" {
                self?.sections[section].expanded.toggle()
                self?.tableView.beginUpdates()
                self?.tableView.reloadRows(at: [IndexPath(row: 0, section: section)],
                                          with: .automatic)
                self?.tableView.endUpdates()
            }
        }
        return headerView
    }
    
}

extension SettingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sections[section].title == "テーマカラー"  {
            return rows.count
        }
        switch sections[section].title {
            case "テーマカラー":
                return rows.count
            case "A", "B", "C":
                return 0
            default:
                fatalError("予期せぬタイトルがあります。")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CustomThemeColorTableViewCell.identifier,
            for: indexPath) as! CustomThemeColorTableViewCell
        let row = rows[indexPath.row]
        cell.configure(row: row) { [weak self] in
            switch self?.rows[indexPath.row].title {
                case "セルフ":
                    let themeColorVC = ThemeColorViewController.instantiate(navTitle: "セルフ")
                    self?.navigationController?.pushViewController(themeColorVC, animated: true)
                case "オススメ":
                    let colorConceptVC = ColorConceptViewController.instantiate()
                    self?.navigationController?.pushViewController(colorConceptVC, animated: true)
                default:
                    fatalError("予期せぬタイトルがあります。")
            }
        }
        return cell
    }
    
    
}
