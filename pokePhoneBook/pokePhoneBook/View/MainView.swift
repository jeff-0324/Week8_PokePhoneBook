//
//  MainView.swift
//  pokePhoneBook
//
//  Created by jae hoon lee on 12/6/24.
//
import UIKit
import SnapKit

class MainView: UIView {
    
    // API를 통해 받아온 데이터를 저장
    var dataSource: [DataSource] = []
    
    // 테이블 뷰
    let listTableView: UITableView  = {
        let tableView = UITableView()
        return tableView
    }()
    
    //MARK: - setting
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        loadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        
        addSubview(listTableView)
        
        // 테이블 뷰 Layout
        listTableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.bottom.equalToSuperview().inset(30)
        }
    }
}

//MARK: - method Part
extension MainView {
    
    // 테이블 뷰 reload
    func loadData() {
        dataSource = CoreDataManger.shared.fetchDataSource()
        listTableView.reloadData()
    }
}


