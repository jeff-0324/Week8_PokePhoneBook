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
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        configureUI()
    }

    private func configureUI() {
        view.addSubview(mainView)
        
        mainView.buttonAction = {[weak self] in
            guard let self = self else { return }
            self.navigationController?.pushViewController(PhoneBookViewController(), animated: true)
        }
        
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}

