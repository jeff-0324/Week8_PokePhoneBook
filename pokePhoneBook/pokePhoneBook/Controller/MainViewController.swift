//
//  ViewController.swift
//  pokePhoneBook
//
//  Created by jae hoon lee on 12/6/24.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private let mainView = MainView()
    private let enrolView = EnrolView()
    private let coreData = CoreDataManger()
    private let phoneBookViewController = PhoneBookViewController()
    
    // navigationBar button
    private let rightButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.title = "추가"
        barButton.style = .plain
        barButton.tintColor = .lightGray
        return barButton
    }()
    
//MARK: - setting
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.loadData()
        navigationBarSetup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        navigationBarSetup()
        setTableView()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(mainView)
        
        mainView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

//MARK: - 메서드 부분
extension MainViewController: PhoneBookViewControllerDelegate  {
    
    private func navigationBarSetup() {
        navigationItem.title = "친구 목록"
        navigationItem.rightBarButtonItem = rightButton
        
        rightButton.target = self
        rightButton.action = #selector(tappedAddButton)
    }
    
    // button action
    @objc func tappedAddButton() {
        navigationController?.pushViewController(phoneBookViewController, animated: true)
    }
    
    func didSaveData() {
        let fetchedData = CoreDataManger.shared.fetchDataSource()
            mainView.dataSource = fetchedData
       }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    // tablveView setting
    func setTableView() {
        mainView.listTableView.dataSource = self
        mainView.listTableView.delegate = self
        mainView.listTableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainView.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        
        let data = mainView.dataSource[indexPath.row]
        cell.friendName.text = data.name
        cell.friendNumber.text = data.phoneNumber
        
        if let imageData = data.profilesImage, let image = UIImage(data: imageData) {
            cell.pokemonImageView.image = image
        }
        return cell
    }
    
    // 특정 셀을 선택했을 때
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = mainView.dataSource[indexPath.row]
        
        let phoneBookVC = PhoneBookViewController()
        phoneBookVC.selectedData = data
        
        navigationController?.pushViewController(phoneBookVC, animated: true)
    }
}
