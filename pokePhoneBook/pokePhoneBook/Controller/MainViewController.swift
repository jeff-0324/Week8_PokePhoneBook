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
    private let phoneBookViewController = PhoneBookViewController()
    
    // 네비게이션 바 버튼
    private let rightButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.title = "추가"
        barButton.style = .plain
        barButton.tintColor = .lightGray
        return barButton
    }()
    
    //MARK: - setting
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        navigationBarSetup()
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.loadData()
        navigationBarSetup()
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
extension MainViewController {
    
    // 네비게이션바 타이틀과 버튼 추가
    private func navigationBarSetup() {
        navigationItem.title = "친구 목록"
        navigationItem.rightBarButtonItem = rightButton
        rightButton.target = self
        rightButton.action = #selector(tappedAddButton)
    }
    
    // 추가 버튼을 눌렀을 때
    @objc func tappedAddButton() {
        phoneBookViewController.mode = .add
        navigationController?.pushViewController(phoneBookViewController, animated: true)
    }
}

//MARK: - Delegate Part
extension MainViewController: PhoneBookViewControllerDelegate  {
    
    // fetch한 데이터를 dataSource에 추가 후 reload
    func didSaveData() {
        let fetchedData = CoreDataManger.shared.fetchDataSource()
        mainView.dataSource = fetchedData
        mainView.listTableView.reloadData()
    }
}

//MARK: - TableView Part
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    // 테이블뷰 setting
    func setTableView() {
        mainView.listTableView.dataSource = self
        mainView.listTableView.delegate = self
        mainView.listTableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
    }
    
    // 테이블뷰 셀 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // 테이블뷰 셀 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainView.dataSource.count
    }
    
    // 테이블뷰 셀 구성
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        
        let data = mainView.dataSource[indexPath.row]
        cell.name.text = data.name
        cell.phoneNumber.text = data.phoneNumber
        
        guard let imageData = data.profilesImage, let image = UIImage(data: imageData)  else { return cell }
        cell.profilesImageView.image = image
        return cell
    }
    
    // 특정 셀을 선택했을 때
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = mainView.dataSource[indexPath.row]
        phoneBookViewController.selectedData = data
        phoneBookViewController.mode = .view
        
        navigationController?.pushViewController(phoneBookViewController, animated: true)
    }
}
