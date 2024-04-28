//
//  detailPageController.swift
//  OttukiDinning
//
//  Created by 김준철 on 4/22/24.
//

import Foundation
import CoreData
import UIKit

var persistentContainer: NSPersistentContainer? {
    (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
}
//파일 클래스 이름 맞추기
class DetailPageController: UIViewController {

    let nameTextField = UITextField()
    let nameText = UILabel()
    let datePicker = UIDatePicker()
    let dateText = UILabel()
    let peopleCounter = UIStepper()
    let peopleCountLabel = UILabel()
    let peopleText = UILabel()
    let reserveButton = UIButton()
    var reservationRestaurantName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        view.backgroundColor = .white
        
        //예약자명
        nameText.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameText)
        NSLayoutConstraint.activate([
            nameText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameText.heightAnchor.constraint(equalToConstant: 40)
            
        ])
        nameText.text = "예약자명"
        
        // 예약자명 입력
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameTextField)
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            //nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextField.widthAnchor.constraint(equalToConstant: 100),
            nameTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        nameTextField.text = "여기에 입력"
        
        
        // 날짜 선택
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(datePicker)
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            //datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            datePicker.heightAnchor.constraint(equalToConstant: 100)
        ])
        // 예약 날짜 label
        dateText.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dateText)
        NSLayoutConstraint.activate([
            dateText.topAnchor.constraint(equalTo: nameText.bottomAnchor, constant: 20),
            dateText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dateText.heightAnchor.constraint(equalToConstant: 100)
            
        ])
        dateText.text = "예약 날짜"
        
        // 인원 수 조절
        peopleCounter.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(peopleCounter)
        NSLayoutConstraint.activate([
            peopleCounter.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
            //peopleCounter.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            peopleCounter.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            peopleCounter.widthAnchor.constraint(equalToConstant: 100),
            peopleCounter.heightAnchor.constraint(equalToConstant: 40)
            
            
        ])
        peopleCounter.addTarget(self, action: #selector(peopleCounterChanged), for: .valueChanged)
        
        //인원 수 라벨
        peopleCountLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(peopleCountLabel)
        NSLayoutConstraint.activate([
            peopleCountLabel.centerYAnchor.constraint(equalTo: peopleCounter.centerYAnchor),
            peopleCountLabel.trailingAnchor.constraint(equalTo: peopleCounter.leadingAnchor, constant: -10),
            //peopleCounter.widthAnchor.constraint(equalToConstant: 100),
            //eopleCounter.heightAnchor.constraint(equalToConstant: 40)
        ])
        peopleCountLabel.text = "0"
        
        
        
        // 예약 인원 Label
        peopleText.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(peopleText)
        NSLayoutConstraint.activate([
            peopleText.topAnchor.constraint(equalTo: dateText.bottomAnchor, constant: 20),
            peopleText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            peopleText.heightAnchor.constraint(equalToConstant: 40)
            
        ])
        peopleText.text = "예약 인원"
        
        // 예약하기 버튼
        reserveButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(reserveButton)
        NSLayoutConstraint.activate([
            reserveButton.topAnchor.constraint(equalTo: peopleCounter.bottomAnchor, constant: 30),
            reserveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            reserveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            reserveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        reserveButton.setTitle("예약하기", for: .normal)
        reserveButton.backgroundColor = UIColor.yellow
        reserveButton.setTitleColor(UIColor.black, for: .normal) // 검은색으로 설정
        reserveButton.addTarget(self, action: #selector(reserveButtonTapped), for: .touchUpInside)

    }

    
    @objc func peopleCounterChanged(_ sender:UIStepper) {
        peopleCountLabel.text = Int(sender.value).description
    }
    
   @objc func reserveButtonTapped() {
       let date: DateFormatter = {
           let df = DateFormatter()
           df.locale = Locale(identifier: "ko_KR")
           df.timeZone = TimeZone(abbreviation: "KST")
           df.dateStyle = .long
           df.timeStyle = .short
           return df
       }()
        //코어데이터에 저장
       guard let context = persistentContainer?.viewContext else { return }
       
       let newReserve = Reserve(context: context)
       
       newReserve.reserveDate = datePicker.date
       newReserve.reserveName = nameTextField.text
       newReserve.reservePeople = Int32(peopleCounter.value)
       newReserve.reserveRestaurantName = reservationRestaurantName
       try? context.save()
       
       let request = Reserve.fetchRequest()
       let reserves = try? context.fetch(request)
       print(newReserve)

       
        // 예약 로직 처리
        // 예약 정보 확인을 위한 간단한 alert 표시
       let alert = UIAlertController(title: "예약 완료", message: "예약자명: \(nameTextField.text!)\n날짜: \(date.string(from: datePicker.date))\n인원: \(Int(peopleCounter.value))명", preferredStyle: .alert)
       alert.addAction(UIAlertAction(title: "확인", style: .default) { [weak self] (_) in
           self?.dismiss(animated: true, completion: {
               // dismiss가 완료된 후, 루트 뷰 컨트롤러로 이동하는 로직을 실행
               ButtonManager.navigationController.popToRootViewController(animated: true)
           })
       })
        self.present(alert, animated: true, completion: nil)
    }
    
}
