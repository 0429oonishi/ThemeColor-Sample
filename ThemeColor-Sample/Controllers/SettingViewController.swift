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
    static let data = [Section(title: "このアプリを評価", expanded: false),
                       Section(title: "テーマカラー", expanded: false),
                       Section(title: "パスコード", expanded: false),
                       Section(title: "言語を選択", expanded: false)]
}

struct Row {
    let title: String
    static let data = [Row(title: "セルフカスタム"),
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
        return 0
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
                case "セルフカスタム":
                    print("セルフカスタム")
                case "オススメ":
                    print("おすすめ")
                default:
                    fatalError()
            }
        }
        return cell
    }
    
    
}
