//
//  EnrolView.swift
//  pokePhoneBook
//
//  Created by jae hoon lee on 12/6/24.
//
import UIKit
import SnapKit

class EnrolView: UIView {
    
    private let pokemonImageView: UIImageView = {
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
        return button
    }()
    
    private var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이름을 입력해주세요"
        return textField
    }()
    
    private var phoneNumeberTextView: UITextView = {
        let textView = UITextView()
        return textView
    }()
    
    
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
            phoneNumeberTextView
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
        
        phoneNumeberTextView.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(50)
        }
    }
}
