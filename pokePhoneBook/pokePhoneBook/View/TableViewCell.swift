//
//  TableViewCell.swift
//  pokePhoneBook
//
//  Created by jae hoon lee on 12/6/24.
//

import UIKit
import SnapKit

class TableViewCell: UITableViewCell {
    
    // 프로필 이미지 뷰
    var profilesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 30
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.gray.cgColor
        return imageView
    }()
    
    // 이름 라벨
    var name: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    // 전화번호 라벨
    var phoneNumber: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - setting
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        [
            profilesImageView,
            name,
            phoneNumber
        ].forEach{ contentView.addSubview($0) }
        
        // 포켓몬 이미지 뷰 Layout
        profilesImageView.snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        
        //  이름 라벨 Layout
        name.snp.makeConstraints { make in
            make.width.equalTo(70)
            make.centerY.equalToSuperview()
            make.leading.equalTo(profilesImageView.snp.trailing).offset(20)
        }
        
        // 전화번호 라벨 Layout
        phoneNumber.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.centerY.equalToSuperview()
            make.leading.equalTo(name.snp.trailing).offset(30)
        }
    }
}
