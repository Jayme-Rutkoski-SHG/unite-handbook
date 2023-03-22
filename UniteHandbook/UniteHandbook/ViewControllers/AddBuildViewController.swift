//
//  AddBuildViewController.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/16/23.
//

import UIKit
import SnapKit

protocol AddBuildDelegate: AnyObject {
    func addBuild(pokemonName: String, build: Build)
}
class AddBuildViewController: UIViewController {

    private var modalPosition: ModalSheetPresentationController.modalPosition = .middle
    private var pokemonName: String = ""
    private var pokemonMoves: [Move] = [Move]()
    private var heldItems: [HeldItem] = [HeldItem]()
    private var battleItems: [BattleItem] = [BattleItem]()
    private var currentBuild: Build = Build()
    private weak var delegate: AddBuildDelegate?
    
    private lazy var buttonClose: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "close")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(buttonClose_TouchUpInside), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.placeholder = "Enter Build Title:"
        textField.backgroundColor = .white
        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 1.0))
        textField.leftViewMode = .always
        textField.rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 40.0, height: 1.0))
        textField.rightViewMode = .always
        textField.layer.cornerRadius = 6.0
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.black.cgColor
        textField.delegate = self
        textField.returnKeyType = .next
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.font = UIFont(name: "Georgia", size: 14.0)
        
        return textField
    }()
    
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
    
    public convenience init(pokemonName: String, pokemonMoves: [Move], delegate: AddBuildDelegate?) {
        self.init(nibName: nil, bundle: nil)
        self.pokemonName = pokemonName
        self.pokemonMoves = pokemonMoves
        self.delegate = delegate
        self.currentBuild.moveOrders = ["", "", "", ""]
        self.currentBuild.heldItems = ["", "", ""]
        self.heldItems = HeldItemLoader.loadHeldItems()
        self.battleItems = BattleItemLoader.loadBattleItems()
    }
    
    private func setup() {
        
        // TextField
        self.view.addSubview(self.buttonClose)
        self.buttonClose.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalTo(self.view.snp.left).offset(20)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        // TextField
        self.view.addSubview(self.textField)
        self.textField.snp.makeConstraints { make in
            make.top.equalTo(self.buttonClose.snp.bottom).offset(20)
            make.left.equalTo(self.view.snp.left).offset(20)
            make.right.equalTo(self.view.snp.right).offset(-20)
            make.height.equalTo(40)
        }
        
        // Moves
        self.view.addSubview(self.stackViewMoves)
        self.stackViewMoves.snp.makeConstraints { make in
            make.top.equalTo(self.textField.snp.bottom).offset(20)
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
        // Tap Gesture
        let gestureTap: UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(gestureTap(gesture:)))
        gestureTap.cancelsTouchesInView = false
        
        self.view.addGestureRecognizer(gestureTap)
        
        
        self.imageViewMove1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.imageViewMove1_Tapped)))
        self.imageViewMove2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.imageViewMove2_Tapped)))
        self.imageViewMove3.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.imageViewMove3_Tapped)))
        self.imageViewMove4.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.imageViewMove4_Tapped)))
        
        if (self.pokemonName.lowercased() == "zacian") {
            self.imageViewHeldItem1.image = UIImage(named: "rusted_sword")
            self.currentBuild.heldItems[0] = "Rusted Sword"
        } else {
            self.heldItems.removeAll(where: { $0.name.lowercased() == "rusted sword" })
            self.imageViewHeldItem1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.imageViewHeldItem1_Tapped)))
        }
        self.imageViewHeldItem2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.imageViewHeldItem2_Tapped)))
        self.imageViewHeldItem3.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.imageViewHeldItem3_Tapped)))
        
        self.imageViewBattleItem.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.imageViewBattleItem_Tapped)))
    }
    
    private func displayMove1Options(moves: [Move]) {
        self.modalPosition = .lower
        
        var images: [MultiImage] = [MultiImage]()
        images.append(contentsOf: moves.filter { self.pokemonName.lowercased() == "mew" ? !self.currentBuild.moveOrders.contains($0.name) : true }.map { MultiImage(
            image: UIImage(named: "\(self.pokemonName.lowercased())_\($0.name.replacingOccurrences(of: " ", with: "").lowercased()).png"),
            text: $0.name,
            key: $0) { image, model in
                self.imageViewMove1.image = image
                guard let move = model as? Move else { return }
                self.currentBuild.moveOrders[0] = move.name
                if let secondMove = self.pokemonMoves.first(where: { $0.name != move.name }) {
                    if secondMove.upgrades != nil {
                        self.currentBuild.moveOrders[1] = secondMove.name
                        self.imageViewMove2.image = UIImage(named: "\(self.pokemonName.lowercased())_\(secondMove.name.replacingOccurrences(of: " ", with: "").lowercased()).png")
                    }
                }
            }
            
        })
        
        self.navigateToSelectOptions(images: images)
    }
    private func displayMove2Options(moves: [Move]) {
        self.modalPosition = .lower
        
        var images: [MultiImage] = [MultiImage]()
        images.append(contentsOf: moves.filter { self.pokemonName.lowercased() == "mew" ? !self.currentBuild.moveOrders.contains($0.name) : true }.map { MultiImage(
            image: UIImage(named: "\(self.pokemonName.lowercased())_\($0.name.replacingOccurrences(of: " ", with: "").lowercased()).png"),
            text: $0.name,
            key: $0) { image, model in
                self.imageViewMove2.image = image
                guard let move = model as? Move else { return }
                self.currentBuild.moveOrders[1] = move.name
                if let secondMove = self.pokemonMoves.first(where: { $0.name != move.name }) {
                    self.currentBuild.moveOrders[0] = secondMove.name
                    self.imageViewMove1.image = UIImage(named: "\(self.pokemonName.lowercased())_\(secondMove.name.replacingOccurrences(of: " ", with: "").lowercased()).png")
                }
            }
            
        })
        
        self.navigateToSelectOptions(images: images)
    }
    private func displayMove3Options(moves: [Move]) {
        self.modalPosition = .lower
        
        var images: [MultiImage] = [MultiImage]()
        images.append(contentsOf: moves.filter { self.pokemonName.lowercased() == "mew" ? !self.currentBuild.moveOrders.contains($0.name) : true }.map { MultiImage(
            image: UIImage(named: "\(self.pokemonName.lowercased())_\($0.name.replacingOccurrences(of: " ", with: "").lowercased()).png"),
            text: $0.name,
            key: $0) { image, model in
                self.imageViewMove3.image = image
                guard let move = model as? Move else { return }
                self.currentBuild.moveOrders[2] = move.name
            }
            
        })
        
        self.navigateToSelectOptions(images: images)
    }
    private func displayMove4Options(moves: [Move]) {
        self.modalPosition = .lower
        
        var images: [MultiImage] = [MultiImage]()
        images.append(contentsOf: moves.filter { self.pokemonName.lowercased() == "mew" ? !self.currentBuild.moveOrders.contains($0.name) : true }.map { MultiImage(
            image: UIImage(named: "\(self.pokemonName.lowercased())_\($0.name.replacingOccurrences(of: " ", with: "").lowercased()).png"),
            text: $0.name,
            key: $0) { image, model in
                self.imageViewMove4.image = image
                guard let move = model as? Move else { return }
                self.currentBuild.moveOrders[3] = move.name
            }
            
        })
        
        self.navigateToSelectOptions(images: images)
    }
    
    private func displayHeldItem1Options(options: [HeldItem]) {
        self.modalPosition = .middle
        
        var images: [MultiImage] = [MultiImage]()
        images.append(contentsOf: options.filter { !self.currentBuild.heldItems.contains($0.name) }.map { MultiImage(
            image: UIImage(named: "\($0.name.replacingOccurrences(of: " ", with: "_").lowercased()).png"),
            key: $0) { image, model in
                self.imageViewHeldItem1.image = image
                guard let heldItem = model as? HeldItem else { return }
                self.currentBuild.heldItems[0] = heldItem.name
            }
        })
        
        self.navigateToSelectOptions(images: images)
    }
    private func displayHeldItem2Options(options: [HeldItem]) {
        self.modalPosition = .middle
        
        var images: [MultiImage] = [MultiImage]()
        images.append(contentsOf: options.filter { !self.currentBuild.heldItems.contains($0.name) }.map { MultiImage(
            image: UIImage(named: "\($0.name.replacingOccurrences(of: " ", with: "_").lowercased()).png"),
            key: $0) { image, model in
                self.imageViewHeldItem2.image = image
                guard let heldItem = model as? HeldItem else { return }
                self.currentBuild.heldItems[1] = heldItem.name
            }
        })
        
        self.navigateToSelectOptions(images: images)
    }
    private func displayHeldItem3Options(options: [HeldItem]) {
        self.modalPosition = .middle
        
        var images: [MultiImage] = [MultiImage]()
        images.append(contentsOf: options.filter { !self.currentBuild.heldItems.contains($0.name) }.map { MultiImage(
            image: UIImage(named: "\($0.name.replacingOccurrences(of: " ", with: "_").lowercased()).png"),
            key: $0) { image, model in
                self.imageViewHeldItem3.image = image
                guard let heldItem = model as? HeldItem else { return }
                self.currentBuild.heldItems[2] = heldItem.name
            }
        })
        
        self.navigateToSelectOptions(images: images)
    }
    
    private func displayBattleItemOptions(options: [BattleItem]) {
        self.modalPosition = .lower
        
        var images: [MultiImage] = [MultiImage]()
        images.append(contentsOf: options.filter { self.currentBuild.battleItem != $0.name }.map { MultiImage(
            image: UIImage(named: "\($0.name.replacingOccurrences(of: " ", with: "_").lowercased()).png"),
            key: $0) { image, model in
                self.imageViewBattleItem.image = image
                guard let heldItem = model as? BattleItem else { return }
                self.currentBuild.battleItem = heldItem.name
            }
        })
        
        self.navigateToSelectOptions(images: images)
    }
    
    @objc private func buttonClose_TouchUpInside(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func buttonSubmit_TouchUpInside(sender: UIButton) {
        self.currentBuild.name = self.textField.text ?? ""
        
        self.delegate?.addBuild(pokemonName: self.pokemonName, build: self.currentBuild)
        self.dismiss(animated: true)
    }
    
    @objc func imageViewMove1_Tapped() {
        displayMove1Options(moves: self.pokemonMoves)
    }
    @objc func imageViewMove2_Tapped() {
        displayMove2Options(moves: self.pokemonMoves)
    }
    @objc func imageViewMove3_Tapped() {
        if let moves = self.pokemonMoves[0].upgrades {
            displayMove3Options(moves: moves)
        } else {
            displayMove3Options(moves: self.pokemonMoves)
        }
    }
    @objc func imageViewMove4_Tapped() {
        if let moves = self.pokemonMoves[1].upgrades {
            displayMove4Options(moves: moves)
        } else {
            displayMove4Options(moves: self.pokemonMoves)
        }
    }
    
    @objc func imageViewHeldItem1_Tapped() {
        displayHeldItem1Options(options: self.heldItems)
    }
    @objc func imageViewHeldItem2_Tapped() {
        displayHeldItem2Options(options: self.heldItems)
    }
    @objc func imageViewHeldItem3_Tapped() {
        displayHeldItem3Options(options: self.heldItems)
    }
    
    @objc func imageViewBattleItem_Tapped() {
        displayBattleItemOptions(options: self.battleItems)
    }
    
    @objc private func gestureTap(gesture: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    private func navigateToSelectOptions(images: [MultiImage]) {
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

extension AddBuildViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.init(hex: 0x3C9ADC).cgColor
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.black.cgColor
        textField.resignFirstResponder()
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
