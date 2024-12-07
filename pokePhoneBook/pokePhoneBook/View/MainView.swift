//
//  MainView.swift
//  pokePhoneBook
//
//  Created by jae hoon lee on 12/6/24.
//
import UIKit
import SnapKit

class MainView: UIView, UITableViewDataSource, UITableViewDelegate {
    private let dataSource = DataSource()
 
    private let topLabel: UILabel = {
        let label = UILabel()
        label.text = "친구 목록"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("추가", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        return button
    }()
    
    private let listTableView: UITableView  = {
        let tableView = UITableView()
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .white
        
        [
            topLabel,
            addButton,
            listTableView
        ].forEach { addSubview($0) }
        
        topLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(80)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(80)
            make.trailing.equalToSuperview().inset(30)
            make.width.equalTo(40)
        }
        
        listTableView.snp.makeConstraints { make in
            make.top.equalTo(topLabel.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview().inset(30)
        }
    }
}

extension MainView {
    
    func setTableView() {
        
        listTableView.dataSource = self
        listTableView.delegate = self
        listTableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
}


