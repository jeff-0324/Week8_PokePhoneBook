//
//  MainView.swift
//  pokePhoneBook
//
//  Created by jae hoon lee on 12/6/24.
//
import UIKit
import SnapKit

class MainView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    var dataSource: [DataSource] = []
    
    let listTableView: UITableView  = {
        let tableView = UITableView()
        return tableView
    }()
  
//MARK: - setting
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setTableView()
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
    
    // tablveView setting
    func setTableView() {
        listTableView.dataSource = self
        listTableView.delegate = self
        listTableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        
        let data = dataSource[indexPath.row]
        cell.friendName.text = data.name
        cell.friendNumber.text = data.phoneNumber
        
        if let imageData = data.profilesImage, let image = UIImage(data: imageData) {
            cell.pokemonImageView.image = image
        }
        return cell
    }
    
}


