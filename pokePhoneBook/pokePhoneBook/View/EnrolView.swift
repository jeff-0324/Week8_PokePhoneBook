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
    
    var pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.cornerRadius = 100
        return imageView
    }()
    
    private let creatImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("랜덤 이미지 생성", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        return button
    }()
    
     var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이름을 입력해주세요"
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.cornerRadius = 10
        textField.clearButtonMode = .always
        textField.returnKeyType = .done
        return textField
    }()
     var phoneNumeberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "전화번호를 입력해주세요"
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.cornerRadius = 10
        textField.clearButtonMode = .always
        textField.returnKeyType = .done
        return textField
    }()
        
    //MARK: - setting
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .white
        
        [
            pokemonImageView,
            creatImageButton,
            nameTextField,
            phoneNumeberTextField
        ].forEach { addSubview($0) }
        
        pokemonImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(200)
        }
        
        creatImageButton.snp.makeConstraints { make in
            make.top.equalTo(pokemonImageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(70)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(creatImageButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(50)
        }
        
        phoneNumeberTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(50)
        }
        
        nameTextField.delegate = self
        phoneNumeberTextField.delegate = self
        creatImageButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
}

//MARK: - method Part
extension EnrolView: UITextFieldDelegate {
    
    // 이미지 생성 버튼 메서드
    @objc func buttonTapped() {
        tappedMakeImageButton?()
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
