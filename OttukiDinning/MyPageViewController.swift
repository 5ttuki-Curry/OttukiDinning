//
//  MyPageViewController.swift
//  OttukiDinning
//
//  Created by 박준영 on 4/25/24.
//

import UIKit
import CoreData

class MyPageViewController: UIViewController {

    
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var reservationControl: UISegmentedControl!
    @IBOutlet weak var tableview: UITableView!
    
    var bottomUIStackView = UIStackView()
    let homeButton = UIButton()
    let searchButton = UIButton()
    let myInfoButton = UIButton()
    
    let defaults = UserDefaults.standard
    
    var isStatusMode = true
    var isHistoryMode = true
    
    var persistentContainer: NSPersistentContainer? {
            (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
        }
    var array:[Reserve] = [] //코어데이터에서 가져온 전체!
    var array1:[Reserve] = [] //예약 현황 배열
    var array2:[Reserve] = [] //예약 내역 배열

    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        setTableView()
        setBottomUIStackView()
        setArrays()
    }
    
    
    func configureUI() {
        nicknameLabel.text = readLoginInfo(forKey: "nickname") + " 님"
        nicknameLabel.font = .boldSystemFont(ofSize: 23)
        
        idLabel.text = readLoginInfo(forKey: "id")
        idLabel.font = .systemFont(ofSize: 17)
        
        reservationControl.selectedSegmentIndex = 0
        reservationControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .semibold)], for: .normal)
        
        reservationControl.addUnderlineForSelectedSegment()    // 언더라인 생성
    }
    
    
    func setTableView() {
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(UINib(nibName: "BookingStatusTableViewCell", bundle: nil), forCellReuseIdentifier: "BookingStatusCell")
        tableview.register(UINib(nibName: "BookingHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "BookingHistoryCell")
    }
    
    
    private func setBottomUIStackView() {
        view.addSubview(bottomUIStackView)
        bottomUIStackView.axis = .horizontal
        bottomUIStackView.distribution = .equalSpacing
        bottomUIStackView.isLayoutMarginsRelativeArrangement = true
        bottomUIStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 39, bottom: 0, trailing: 39)
        
        homeButton.setImage(UIImage(named: "HomeEmpty"), for: .normal)
        searchButton.setImage(UIImage(named: "Search"), for: .normal)
        myInfoButton.setImage(UIImage(named: "MyInfo"), for: .normal)
        
        bottomUIStackView.addArrangedSubview(homeButton)
        bottomUIStackView.addArrangedSubview(searchButton)
        bottomUIStackView.addArrangedSubview(myInfoButton)
        
        bottomUIStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomUIStackView.heightAnchor.constraint(equalToConstant: 40),
            bottomUIStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomUIStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomUIStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        homeButton.addTarget(self, action: #selector(self.homeButtonTapped), for: .touchUpInside)
        searchButton.addTarget(self, action: #selector(self.searchButtonTapped), for: .touchUpInside)
        myInfoButton.addTarget(self, action: #selector(self.myInfoButtonTapped), for: .touchUpInside)
    }
    
    
    func setArrays() {
        let calendar = Calendar.current
        let present = Date()
        print(present)
        
        guard let context = self.persistentContainer?.viewContext else { return }
        
        let request = Reserve.fetchRequest()
        guard let reserveList = try? context.fetch(request) else { return }
        
        array = reserveList
        self.array1 = array.filter{
            calendar.compare(present, to: $0.reserveDate!, toGranularity: .day) == .orderedAscending
        }.sorted{
            $0.reserveDate! < $1.reserveDate!
        }
        self.array2 = array.filter{
            calendar.compare(present, to: $0.reserveDate!, toGranularity: .day) == .orderedDescending
        }.sorted{
            $0.reserveDate! < $1.reserveDate!
        }
        
    }
    
    
    @objc func homeButtonTapped() {
        let storyboard = UIStoryboard(name: "HomeView", bundle: nil)
        guard let nextVC = storyboard.instantiateViewController(identifier: "HomeView") as? HomeViewController else {
            return
        }
        LogInViewController.navigationController = UINavigationController(rootViewController: nextVC)
        LogInViewController.navigationController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        self.present(LogInViewController.navigationController, animated: true)
    }
    
    
    @objc func searchButtonTapped() {
        let storyboard = UIStoryboard(name: "Sion", bundle: nil)
        guard let nextVC = storyboard.instantiateViewController(identifier: "SionViewController") as? SionViewController else {
            return
        }
        LogInViewController.navigationController = UINavigationController(rootViewController: nextVC)
        LogInViewController.navigationController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        self.present(LogInViewController.navigationController, animated: true)
    }
    
    
    @objc func myInfoButtonTapped() {
        let storyboard = UIStoryboard(name: "MyPageView", bundle: nil)
        guard let mypageVC = storyboard.instantiateViewController(withIdentifier: "MyPageView") as? MyPageViewController else { return }
        mypageVC.modalPresentationStyle = .fullScreen
        self.present(mypageVC, animated: false, completion: nil)
    }

   
    @IBAction func controlSelected(_ sender: UISegmentedControl) {
        reservationControl.changeUnderlinePosition()     // 언더라인 위치 이동
        
        switch sender.selectedSegmentIndex {
        case 0:
            // 예약 현황 보여주기
            isStatusMode = true
            isHistoryMode = false
            self.tableview.reloadData()
        case 1:
            // 예약 내역 보여주기
            isStatusMode = false
            isHistoryMode = true
            self.tableview.reloadData()
        default:
            break
        }
    }
    
    // userdefaults 데이터 읽어오기
    func readLoginInfo(forKey: String) -> String {
        if let value = defaults.string(forKey: forKey) {
            return value
        } else { return "" }
    }

}



extension MyPageViewController: UITableViewDataSource, UITableViewDelegate, ButtonTappedDelegate {
    //데이터 가지고 그려보기
    //테이블에 원하는 갯수를 조건 맞춰주기
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(array1)
        print(array2)
        if isStatusMode {
            return array1.count
        } else {
            return array2.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isStatusMode {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookingStatusCell", for: indexPath)
                    as? BookingStatusTableViewCell else { return UITableViewCell() }
            
            cell.configureCell()
            let status = array1[indexPath.row]//엔티티 접근
            //애트리뷰트
            cell.placeNameLabel.text = status.reserveRestaurantName             //식당이름
            cell.personNameLabel.text = status.reserveName              //예약자 명
            cell.bookingDateLabel.text = "\(String(describing: status.reserveDate!))"        //예약 날짜
            cell.personCountLabel.text = String(status.reservePeople) + " 명"  //예약 인원
            cell.delegate = self
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookingHistoryCell", for: indexPath)
                    as? BookingHistoryTableViewCell else { return UITableViewCell() }
            
            cell.configureCell()
            let status = array2[indexPath.row]//엔티티 접근
            //애트리뷰트
            cell.placeNameLabel.text = status.reserveRestaurantName //식당이름
            cell.bookingDateLabel.text = "\(String(describing: status.reserveDate!))" //예약 날짜
            cell.personCountLabel.text = String(status.reservePeople) + " 명" //예약 인원
            
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
    
    
    func cellButtonTapped() {
        print("cancel")
        // 배열 삭제하기
        // 코어데이터 삭제하기
        // 셀 삭제하기
        //guard let cell = tableview.dequeueReusableCell(withIdentifier: "BookingHistoryCell", for: IndexPath)

    }
    
}


// 세그먼트컨트롤 배경 흰색, 테두리 삭제, 언더라인 생성, 언더라인 이동
extension UISegmentedControl{

    func removeBorder(){
        let backgroundImage = UIImage.getColoredRectImageWith(color: UIColor.white.cgColor, andSize: self.bounds.size)
        self.setBackgroundImage(backgroundImage, for: .normal, barMetrics: .default)
        self.setBackgroundImage(backgroundImage, for: .selected, barMetrics: .default)
        self.setBackgroundImage(backgroundImage, for: .highlighted, barMetrics: .default)

        let deviderImage = UIImage.getColoredRectImageWith(color: UIColor.white.cgColor, andSize: CGSize(width: 1.0, height: self.bounds.size.height))
        self.setDividerImage(deviderImage, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
    }

    func addUnderlineForSelectedSegment(){
        removeBorder()
        let underlineWidth: CGFloat = self.bounds.size.width / CGFloat(self.numberOfSegments)
        let underlineHeight: CGFloat = 3.0
        let underlineXPosition = CGFloat(selectedSegmentIndex * Int(underlineWidth))
        let underLineYPosition = self.bounds.size.height - 1.0
        let underlineFrame = CGRect(x: underlineXPosition, y: underLineYPosition, width: underlineWidth, height: underlineHeight)
        let underline = UIView(frame: underlineFrame)
        underline.backgroundColor = UIColor(named: "ShadowColor")
        underline.tag = 1
        self.addSubview(underline)
    }

    func changeUnderlinePosition(){
        guard let underline = self.viewWithTag(1) else {return}
        let underlineFinalXPosition = (self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(selectedSegmentIndex)
        UIView.animate(withDuration: 0.1, animations: {
            underline.frame.origin.x = underlineFinalXPosition
        })
    }
}

//세그먼트 컨트롤 배경 흰색 설정
extension UIImage{

    class func getColoredRectImageWith(color: CGColor, andSize size: CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let graphicsContext = UIGraphicsGetCurrentContext()
        graphicsContext?.setFillColor(color)
        let rectangle = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        graphicsContext?.fill(rectangle)
        let rectangleImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return rectangleImage!
    }
}



//1. 코어데이터에서 모든거 다 가져오기 -> array viewdidload
//현황 array1= 예약 내역 < array2 = 예약 현황
//2. 필터(고차함수)를 통해서 array1 or array2 값을 집어넣기 -> 값을 현황,내역 각 배열 만들고 넣기
//출력 tabelview에서 관리
//3. 애트리뷰트 date 부분 처리
