//
//  MyPageViewController.swift
//  OttukiDinning
//
//  Created by 박준영 on 4/25/24.
//

import UIKit

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
    
    let reserveList: [Reserve] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        setTableView()
        setBottomUIStackView()
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
        
        myInfoButton.addTarget(self, action: #selector(self.myInfoButtonTapped), for: .touchUpInside)
    }
    
    
    @objc func myInfoButtonTapped() {
        let storyboard = UIStoryboard(name: "MyPageView", bundle: nil)
        guard let mypageVC = storyboard.instantiateViewController(withIdentifier: "MyPageView") as? MyPageViewController else { return }
        mypageVC.modalPresentationStyle = .fullScreen
        self.present(mypageVC, animated: true, completion: nil)
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


extension MyPageViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isStatusMode {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookingStatusCell", for: indexPath)
                    as? BookingStatusTableViewCell else { return UITableViewCell() }
            
            cell.configureCell()
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookingHistoryCell", for: indexPath)
                    as? BookingHistoryTableViewCell else { return UITableViewCell() }
            
            cell.configureCell()
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
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

