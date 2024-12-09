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
    
    // navigationBar button
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
extension MainViewController  {
    
    private func navigationBarSetup() {
        navigationItem.title = "친구 목록"
        navigationItem.rightBarButtonItem = rightButton
        
        rightButton.target = self
        rightButton.action = #selector(tappedAddButton)
    }
    
    // button action
    @objc func tappedAddButton() {
        navigationController?.pushViewController(PhoneBookViewController(), animated: true)
    }
}
