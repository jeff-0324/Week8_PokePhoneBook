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
    private let rightButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.title = "추가"
        barButton.style = .plain
        barButton.tintColor = .lightGray
        return barButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        configureUI()
    }

    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(mainView)
        navigationItem.title = "친구 목록"
        navigationItem.rightBarButtonItem = rightButton
       
        mainView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        rightButton.target = self
        rightButton.action = #selector(tappedAddButton)
    }
    
    @objc func tappedAddButton() {
        navigationController?.pushViewController(PhoneBookViewController(), animated: true)
    }
}

