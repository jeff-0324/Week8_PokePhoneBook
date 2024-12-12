//
//  PhoneBookViewController.swift
//  pokePhoneBook
//
//  Created by jae hoon lee on 12/8/24.
//

import UIKit
import SnapKit

// 프로토콜 선언
protocol PhoneBookViewControllerDelegate: AnyObject {
    func didSaveData()
}

class PhoneBookViewController: UIViewController {
    private let enrolView = EnrolView()
    private let profilesImageManager = ProfilesImageManager()
    var selectedData: DataSource?
    weak var delegate: PhoneBookViewControllerDelegate?
    var mode: Mode = .add
    
    // 네비게이션바 생성 버튼(.add)
    private let rightAddButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.title = "생성"
        barButton.style = .plain
        return barButton
    }()
    
    // 네비게이션바 수정 버튼(.view)
    private let rightUpdateButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.title = "수정"
        barButton.style = .plain
        return barButton
    }()
    
    //MARK: - setting
    // 뷰를 띄우기 전 모드로 구분해서 뷰 생성
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
        buttonsAction()
    }
}

//MARK: - ButtonsMethod Part
extension PhoneBookViewController {
    
    private func buttonsAction() {
        
        // 랜덤 이미지 생성 메서드
        enrolView.tappedMakeImageButton = { [weak self] in
            guard let self = self else { return }
            // api 요청을 통해 받아온 Image처리 메서드(completion)
            self.profilesImageManager.fetchPokemonApi { [weak self] image in
                guard let self = self else { return }
                if let image = image {
                    self.enrolView.pokemonImageView.image = image
                    // image -> data로 변환
                    self.enrolView.inputProfilesImage = UIImage.pngData(image)()
                }
            }
        }
        
        // 데이터 삭제 메서드
        enrolView.tappedDeleteButton = { [weak self] in
            guard let self = self else { return }
            
            // 코어데이터에서 삭제
            CoreDataManger.shared.deleteData(name: selectedData?.name)
            delegate?.didSaveData()
            navigationController?.popViewController(animated: true)
        }
    }
}

//MARK: - AddMode Part
extension PhoneBookViewController {
    
    // 추가 버튼을 눌렀을 때(.add)
    private func addModeSetupUI() {
        
        // enrol뷰 데이터 초기화
        navigationItem.title = "연락처 추가"
        enrolView.nameTextField.text = ""
        enrolView.phoneNumeberTextField.text = ""
        enrolView.pokemonImageView.image = nil
        
        // 네비게이션바 오른쪽 버튼(.add)
        addModeRightButton()
        
        // enrol뷰 추가
        view.addSubview(enrolView)
        
        enrolView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // 삭제 버튼 숨기기(.add)
        enrolView.deleteButton.isHidden = true
    }
    
    // 네비게이션 상단 오른쪽 버튼(.add)
    private func addModeRightButton() {
        navigationItem.rightBarButtonItem = rightAddButton
        rightAddButton.target = self
        rightAddButton.action = #selector(tappedAddButton)
    }
    
    // 생성 버튼을 눌렀을 때(.add)
    @objc func tappedAddButton() {
        guard let profilesImage = enrolView.inputProfilesImage else {
            print("이미지를 찾을 수 없습니다.")
            return
        }
        enrolView.inputData()
        
        // 코어데이터에 생성
        CoreDataManger.shared.createData(DataSource.init(name: enrolView.inputName,
                                                         phoneNumber: enrolView.inputPhoneNumber,
                                                         profilesImage: profilesImage))
        delegate?.didSaveData()
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - ViewMode Part
extension PhoneBookViewController {
    
    // 테이블뷰 셀을 눌렀을 때(.view)
    private func viewModeSetupUI() {
        
        // 선택된 데이터로 뷰 구현
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
        
        // 네비게이션바 오른쪽 버튼(.view)
        viewModeRightButton()
        
        // enrol뷰 추가
        view.addSubview(enrolView)
        
        enrolView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // 삭제 버튼 보이기(.view)
        enrolView.deleteButton.isHidden = false
    }
    
    // 네비게이션 상단 오른쪽 버튼(.view)
    private func viewModeRightButton() {
        navigationItem.rightBarButtonItem = rightUpdateButton
        rightUpdateButton.target = self
        rightUpdateButton.action = #selector(tappedUpdateButton)
    }
    
    // 수정 버튼을 눌렀을 때(.view)
    @objc func tappedUpdateButton() {
        guard let profilesImage = enrolView.inputProfilesImage else {
            print("이미지를 찾을 수 없습니다.")
            return
        }
        enrolView.inputData()
        
        // 코어데이터에 업데이트
        CoreDataManger.shared.updateData(DataSource(name: enrolView.inputName,
                                                    phoneNumber: enrolView.inputPhoneNumber,
                                                    profilesImage: profilesImage))
        delegate?.didSaveData()
        navigationController?.popViewController(animated: true)
    }
}
