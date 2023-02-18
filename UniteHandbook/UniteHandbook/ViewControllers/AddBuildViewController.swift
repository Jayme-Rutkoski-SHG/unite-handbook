//
//  AddBuildViewController.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/16/23.
//

import UIKit
import SnapKit

class AddBuildViewController: UIViewController {

    private var modalPosition: ModalSheetPresentationController.modalPosition = .middle
    private var pokemonName: String = ""
    private var pokemonMoves: [Move] = [Move]()
    
    private var stackViewMoves: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.spacing = 20
        stackView.axis = .horizontal
        stackView.alignment = .center
        
        return stackView
    }()
    private var viewHeldItems: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(hex: 0x312457)
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1.5

        return view
    }()
    private var viewBattleItem: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(hex: 0x312457)
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1.5
        
        return view
    }()
    
    private var imageViewMove1: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "add_new.png")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor(hex: 0x3B276B)
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    private var imageViewMove2: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "add_new.png")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor(hex: 0x3B276B)
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    private var imageViewMove3: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "add_new.png")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor(hex: 0x3B276B)
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    private var imageViewMove4: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "add_new.png")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor(hex: 0x3B276B)
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    private var labelHeldItems: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.font = UIFont(name: "Georgia-Bold", size: 15.0)
        label.textColor = .white
        label.text = "Held Items"
        
        return label
    }()
    
    private var imageViewHeldItem1: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "add_new.png")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor(hex: 0xC0B5E0)
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    private var imageViewHeldItem2: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "add_new.png")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor(hex: 0xC0B5E0)
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    private var imageViewHeldItem3: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "add_new.png")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor(hex: 0xC0B5E0)
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    private var labelBattleItem: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.font = UIFont(name: "Georgia-Bold", size: 15.0)
        label.textColor = .white
        label.text = "Battle Item"
        
        return label
    }()
    
    private var imageViewBattleItem: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "add_new.png")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor(hex: 0xC0B5E0)
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    private lazy var buttonSubmit: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Georgia-Bold", size: 14.0)
        button.addTarget(self, action: #selector(buttonSubmit_TouchUpInside), for: .touchUpInside)
        button.backgroundColor = UIColor(hex: 0xF9CB53)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1.5
        button.layer.cornerRadius = 20.0
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(hex: 0xc0b5e0)
        
        self.setup()
        self.setupTapGestureRecognizers()
    }
    
    public convenience init(pokemonName: String, pokemonMoves: [Move]) {
        self.init(nibName: nil, bundle: nil)
        self.pokemonName = pokemonName
        self.pokemonMoves = pokemonMoves
    }
    
    private func setup() {
        
        // Moves
        self.view.addSubview(self.stackViewMoves)
        self.stackViewMoves.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalTo(self.view.snp.centerX)
            make.height.equalTo(60)
        }
        
        self.stackViewMoves.addArrangedSubview(self.imageViewMove1)
        self.imageViewMove1.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(60)
        }
        self.stackViewMoves.addArrangedSubview(self.imageViewMove2)
        self.imageViewMove2.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(60)
        }
        self.stackViewMoves.addArrangedSubview(self.imageViewMove3)
        self.imageViewMove3.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(60)
        }
        self.stackViewMoves.addArrangedSubview(self.imageViewMove4)
        self.imageViewMove4.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(60)
        }
        
        // Held Items
        self.view.addSubview(self.viewHeldItems)
        self.viewHeldItems.snp.makeConstraints { make in
            make.top.equalTo(self.stackViewMoves.snp.bottom).offset(15)
            make.left.equalTo(self.view.snp.left).offset(20)
            make.right.equalTo(self.view.snp.right).offset(-20)
        }
        self.viewHeldItems.addSubview(self.labelHeldItems)
        self.labelHeldItems.snp.makeConstraints { make in
            make.top.equalTo(self.viewHeldItems.snp.top).offset(10)
            make.centerX.equalTo(self.viewHeldItems.snp.centerX)
        }
        self.viewHeldItems.addSubview(self.imageViewHeldItem2)
        self.imageViewHeldItem2.snp.makeConstraints { make in
            make.top.equalTo(self.labelHeldItems.snp.bottom).offset(5)
            make.centerX.equalTo(self.viewHeldItems.snp.centerX)
            make.bottom.equalTo(self.viewHeldItems.snp.bottom).offset(-15)
            make.height.equalTo(60)
            make.width.equalTo(60)
        }
        self.viewHeldItems.addSubview(self.imageViewHeldItem1)
        self.imageViewHeldItem1.snp.makeConstraints { make in
            make.top.equalTo(self.labelHeldItems.snp.bottom).offset(5)
            make.right.equalTo(self.imageViewHeldItem2.snp.left).offset(-20)
            make.centerY.equalTo(self.imageViewHeldItem2.snp.centerY)
            make.height.equalTo(60)
            make.width.equalTo(60)
        }
        self.viewHeldItems.addSubview(self.imageViewHeldItem3)
        self.imageViewHeldItem3.snp.makeConstraints { make in
            make.top.equalTo(self.labelHeldItems.snp.bottom).offset(5)
            make.left.equalTo(self.imageViewHeldItem2.snp.right).offset(20)
            make.centerY.equalTo(self.imageViewHeldItem2.snp.centerY)
            make.height.equalTo(60)
            make.width.equalTo(60)
        }
        
        // Battle Item
        self.view.addSubview(self.viewBattleItem)
        self.viewBattleItem.snp.makeConstraints { make in
            make.top.equalTo(self.viewHeldItems.snp.bottom).offset(15)
            make.left.equalTo(self.view.snp.left).offset(20)
            make.right.equalTo(self.view.snp.right).offset(-20)
        }
        self.viewBattleItem.addSubview(self.labelBattleItem)
        self.labelBattleItem.snp.makeConstraints { make in
            make.top.equalTo(self.viewBattleItem.snp.top).offset(10)
            make.centerX.equalTo(self.viewBattleItem.snp.centerX)
        }
        self.viewBattleItem.addSubview(self.imageViewBattleItem)
        self.imageViewBattleItem.snp.makeConstraints { make in
            make.top.equalTo(self.labelBattleItem.snp.bottom).offset(5)
            make.centerX.equalTo(self.viewBattleItem.snp.centerX)
            make.bottom.equalTo(self.viewBattleItem.snp.bottom).offset(-10)
            make.height.equalTo(60)
            make.width.equalTo(60)
        }
        
        // Button
        self.view.addSubview(self.buttonSubmit)
        self.buttonSubmit.snp.makeConstraints { make in
            make.top.equalTo(self.viewBattleItem.snp.bottom).offset(15)
            make.centerX.equalTo(self.view.snp.centerX)
            make.height.equalTo(40)
            make.width.equalTo(150)
        }
    }
    
    private func setupTapGestureRecognizers() {
        self.imageViewMove1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.imageViewMove1Or2_Tapped)))
        self.imageViewMove2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.imageViewMove1Or2_Tapped)))
        self.imageViewMove3.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.imageViewMove3_Tapped)))
        self.imageViewMove4.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.imageViewMove4_Tapped)))
    }
    
    private func displayMoveOptions(moves: [Move]) {
        self.modalPosition = .lower
        
        var images: [UIImage?] = [UIImage?]()
        images.append(contentsOf: moves.map { UIImage(named: "\(self.pokemonName.lowercased())_\($0.name.replacingOccurrences(of: " ", with: "").lowercased()).png") })
        
        self.navigateToSelectOptions(images: images)
    }
    
    @objc func buttonSubmit_TouchUpInside(sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @objc func imageViewMove1Or2_Tapped() {
        displayMoveOptions(moves: self.pokemonMoves)
    }
    @objc func imageViewMove3_Tapped() {
        displayMoveOptions(moves: self.pokemonMoves[0].upgrades!)
    }
    @objc func imageViewMove4_Tapped() {
        displayMoveOptions(moves: self.pokemonMoves[1].upgrades!)
    }
    
    private func navigateToSelectOptions(images: [UIImage?]) {
        let vc = SelectOptionsViewController(images: images)
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        
        self.present(vc, animated: true)
    }
}

extension AddBuildViewController : UIViewControllerTransitioningDelegate {
    
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let vc = ModalSheetPresentationController.init(presentedViewController: presented, presenting: presenting, position: self.modalPosition)

        return vc
    }
    
}
