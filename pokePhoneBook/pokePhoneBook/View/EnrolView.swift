//
//  EnrolView.swift
//  pokePhoneBook
//
//  Created by jae hoon lee on 12/6/24.
//
import UIKit
import SnapKit

class EnrolView: UIView {
    
    var inputName: String = ""
    var inputPhoneNumber: String = ""
    var inputProfilesImage: Data?
    
    // 클로저를 통한 버튼구현
    var tappedMakeImageButton: (() -> Void)?
    var tappedDeleteButton: (() -> Void)?
    
    // 포켓몬 이미지를 띄워줄 이미지뷰
    var pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.cornerRadius = 100
        return imageView
    }()
    
    // 이미지 생성 버튼
    private let createImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("랜덤 이미지 생성", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        return button
    }()
    
    // 이름 입력 텍스트필드
    var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " 이름을 입력해주세요"
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.cornerRadius = 10
        textField.clearButtonMode = .always
        textField.returnKeyType = .done
        return textField
    }()
    
    // 전화번호 입력 텍스트필드
    var phoneNumeberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " 전화번호를 입력해주세요"
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.cornerRadius = 10
        textField.clearButtonMode = .always
        textField.returnKeyType = .done
        return textField
    }()
    
    // 삭제 버튼
    let deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("연락처 삭제", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .lightGray
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        return button
    }()
    
    //MARK: - setting
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        applyAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        
        [
            pokemonImageView,
            createImageButton,
            nameTextField,
            phoneNumeberTextField,
            deleteButton
        ].forEach { addSubview($0) }
        
        // 포켓몬 이미지를 띄워줄 이미지뷰 Layout
        pokemonImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(200)
        }
        
        // 이미지 생성 버튼 Layout
        createImageButton.snp.makeConstraints { make in
            make.top.equalTo(pokemonImageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(70)
        }
        
        // 이름 입력 텍스트필드 Layout
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(createImageButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(50)
        }
        
        // 전화번호 입력 텍스트필드 Layout
        phoneNumeberTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(50)
        }
        
        // 삭제 버튼 Layout
        deleteButton.snp.makeConstraints { make in
            make.top.equalTo(phoneNumeberTextField.snp.bottom).offset(200)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalTo(300)
        }
    }
}

//MARK: - Button Part
extension EnrolView {
    
    // 버튼 액션 추가 메서드
    private func applyAddTarget() {
        createImageButton.addTarget(self,
                                    action: #selector(makeImageAction),
                                    for: .touchUpInside)
        deleteButton.addTarget(self,
                               action: #selector(deleteAction),
                               for: .touchUpInside)
    }
    
    // 이미지 생성 버튼 호출 메서드
    @objc func makeImageAction() {
        tappedMakeImageButton?()
    }
    
    // 삭제 버튼 호출 메서드
    @objc func deleteAction() {
        tappedDeleteButton?()
    }
}

//MARK: - TextField Part
extension EnrolView: UITextFieldDelegate {
    
    // 텍스트필드 델리게이트 설정
    private func textFieldSetting() {
        nameTextField.delegate = self
        phoneNumeberTextField.delegate = self
    }
    
    // 텍스트 필드에 있는 값을 변수에 저장
    func inputData() {
        inputName = nameTextField.text ?? ""
        inputPhoneNumber = phoneNumeberTextField.text ?? ""
    }
    
    // 텍스트 필드 입력이 마쳐지면 키보드가 내려가는 메서드
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

