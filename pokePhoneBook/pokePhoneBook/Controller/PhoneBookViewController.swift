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
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        configureUI()
    }
    
    private func configureUI() {
        view.addSubview(enrolView)
        
        enrolView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
    }
    
}
