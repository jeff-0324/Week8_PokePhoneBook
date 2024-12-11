//
//  MainView.swift
//  pokePhoneBook
//
//  Created by jae hoon lee on 12/6/24.
//
import UIKit
import SnapKit

class MainView: UIView {
    
    var dataSource: [DataSource] = []
    
    let listTableView: UITableView  = {
        let tableView = UITableView()
        return tableView
    }()
  
//MARK: - setting
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        loadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .white
        
        addSubview(listTableView)
        
        listTableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.bottom.equalToSuperview().inset(30)
        }
    }
}

//MARK: - method Part
extension MainView {
    
    func loadData() {
        dataSource = CoreDataManger.shared.fetchDataSource()
        listTableView.reloadData()
    }
}


