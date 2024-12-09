//
//  PhoneBookViewController.swift
//  pokePhoneBook
//
//  Created by jae hoon lee on 12/8/24.
//

import UIKit
import SnapKit

class PhoneBookViewController: UIViewController {
    private let enrolView = EnrolView()
    private let rightButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.title = "적용"
        barButton.style = .plain
        return barButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        configureUI()
    }
    
    private func configureUI() {
        view.addSubview(enrolView)
        
        navigationItem.title = "연락처 추가"
        navigationItem.rightBarButtonItem = rightButton
        
        enrolView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        rightButton.target = self
        rightButton.action = #selector(tappedAddButton)
        
    }
    @objc func tappedAddButton() {
        navigationController?.popViewController(animated: true)
    }
}
