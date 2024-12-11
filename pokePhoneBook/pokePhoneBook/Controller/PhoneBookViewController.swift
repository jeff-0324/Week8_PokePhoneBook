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
    var selectedData: DataSource?
    var mode: Mode = .add
    
    weak var delegate: PhoneBookViewControllerDelegate?
    
    // navigationBar button
    private let rightApplyButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.title = "생성"
        barButton.style = .plain
        return barButton
    }()
    
    private let rightUpdateButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.title = "수정"
        barButton.style = .plain
        return barButton
    }()
    
    //MARK: - setting
    override func viewWillAppear(_ animated: Bool) {
        switch mode {
        case .add :
            addModeSetupUI()
        case .view :
            viewModeSetupUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addModeSetupUI()
        navigationBarSetup()
    }
}

//MARK: - 메서드 부분
extension PhoneBookViewController {
    
    // navigation bar setup
    private func navigationBarSetup() {
        addModeRightButton()
        
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
        
        enrolView.tappedDeleteButton = { [weak self] in
            guard let self = self else { return }
            CoreDataManger.shared.deleteData(name: selectedData?.name)
            delegate?.didSaveData()
            navigationController?.popViewController(animated: true)
        }
    }
    
    // 추가 버튼을 눌렀을 때 add모드
    func addModeSetupUI() {
        view.addSubview(enrolView)
        
        navigationItem.title = "연락처 추가"
        enrolView.nameTextField.text = ""
        enrolView.phoneNumeberTextField.text = ""
        enrolView.pokemonImageView.image = nil
        
        enrolView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        addModeRightButton()
        enrolView.deleteButton.isHidden = true
    }
    
    // 테이블뷰 셀을 눌렀을 때 view모드
    func viewModeSetupUI() {
        if let data = selectedData {
            enrolView.nameTextField.text = data.name
            enrolView.phoneNumeberTextField.text = data.phoneNumber
            if let imageData = data.profilesImage, let image = UIImage(data: imageData) {
                enrolView.pokemonImageView.image = image
            }
            self.navigationItem.title = data.name
        } else {
             navigationItem.title = "연락처 추가"
        }
        
        viewModeRightButton()
        
        view.addSubview(enrolView)
        enrolView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        enrolView.deleteButton.isHidden = false
    }
    
    private func addModeRightButton() {
        navigationItem.rightBarButtonItem = rightApplyButton
        
        rightApplyButton.target = self
        rightApplyButton.action = #selector(tappedApplyButton)
    }
    
    private func viewModeRightButton() {
        navigationItem.rightBarButtonItem = rightUpdateButton
        
        rightUpdateButton.target = self
        rightUpdateButton.action = #selector(tappedUpdateButton)
        
    }
    
    // button action
    @objc func tappedApplyButton() {
        enrolView.inputData()
        guard let profilesImage = enrolView.inputProfilesImage else {
            print("Profiles image is missing")
            return
        }
        CoreDataManger.shared.createData(DataSource.init(name: enrolView.inputName,
                                                         phoneNumber: enrolView.inputPhoneNumber,
                                                         profilesImage: profilesImage))
        delegate?.didSaveData()
        navigationController?.popViewController(animated: true)
    }
    
    @objc func tappedUpdateButton() {
        enrolView.inputData()
        guard let profilesImage = enrolView.inputProfilesImage else {
            print("Profiles image is missing")
            return
        }
        
        CoreDataManger.shared.updateData(DataSource(name: enrolView.inputName,
                                                    phoneNumber: enrolView.inputPhoneNumber,
                                                    profilesImage: profilesImage))
        delegate?.didSaveData()
        navigationController?.popViewController(animated: true)
    }
}
