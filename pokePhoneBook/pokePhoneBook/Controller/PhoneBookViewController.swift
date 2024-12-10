//
//  PhoneBookViewController.swift
//  pokePhoneBook
//
//  Created by jae hoon lee on 12/8/24.
//

import UIKit
import SnapKit

protocol PhoneBookViewControllerDelegate: AnyObject {
    func didSaveData()
}

class PhoneBookViewController: UIViewController {
    private let enrolView = EnrolView()
    private let profilesImageManager = ProfilesImageManager()
    
    weak var delegate: PhoneBookViewControllerDelegate?
    
    // navigationBar button
    private let rightButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.title = "적용"
        barButton.style = .plain
        return barButton
    }()
    
    //MARK: - setting
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        navigationBarSetup()
    }
    
    private func configureUI() {
        view.addSubview(enrolView)
        
        enrolView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

//MARK: - 메서드 부분
extension PhoneBookViewController {
    
    // navigation bar setup
    private func navigationBarSetup() {
        navigationItem.title = "연락처 추가"
        navigationItem.rightBarButtonItem = rightButton
        
        rightButton.target = self
        rightButton.action = #selector(tappedApplyButton)
        
        enrolView.tappedMakeImageButton = { [weak self] in
            guard let self = self else { return }
            self.profilesImageManager.fetchPokemonApi { [weak self] image in
                guard let self = self else { return }
                if let image = image {
                    self.enrolView.pokemonImageView.image = image
                    self.enrolView.inputProfilesImage = UIImage.pngData(image)()
                }
            }
        }
    }
    
    // button action
    @objc func tappedApplyButton() {
        enrolView.inputData()
        guard let profilesImage = enrolView.inputProfilesImage else {
            print("Profiles image is missing")
            return
        }
        CoreDataManger.shared.createData(name: enrolView.inputName, phoneNumber: enrolView.inputPhoneNumber, profilesImage: profilesImage)
        delegate?.didSaveData()
        navigationController?.popViewController(animated: true)
    }
}
