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
    // 비밀번호 찾기 버튼은 추후 구현 여부 결정
    @IBOutlet weak var reservationControl: UISegmentedControl!
    @IBOutlet weak var tableview: UITableView!
    
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        setTableView()
    }
    
    
    func configureUI() {
        nicknameLabel.text = readLoginInfo(forKey: "nickname") + " 님"
        nicknameLabel.font = .boldSystemFont(ofSize: 23)
        
        idLabel.text = readLoginInfo(forKey: "id")
        idLabel.font = .systemFont(ofSize: 17)
        
        reservationControl.selectedSegmentIndex = 0
        reservationControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 23, weight: .semibold)], for: .normal)
        reservationControl.addUnderlineForSelectedSegment()    // 언더라인 생성
        
    }
    
    
    func setTableView() {
        tableview.register(UINib(nibName: "BookingStatusTableViewCell", bundle: nil), forCellReuseIdentifier: "BookingStatusCell")
        tableview.register(UINib(nibName: "BookingHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "BookingHistoryCell")
    }

   
    @IBAction func controlSelected(_ sender: UISegmentedControl) {
        reservationControl.changeUnderlinePosition()         // 언더라인 입력값 따라 바꾸기
        
        switch sender.selectedSegmentIndex {
        case 0:
            // 예약 현황 보여주기
            print("예약 현황")
        case 1:
            // 예약 내역 보여주기
            print("예약 내역")
        default:
            break
        }
        
    }
    
    
    func readLoginInfo(forKey: String) -> String {
        if let value = defaults.string(forKey: forKey) {
            return value
        } else { return "" }
    }

}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1  /// 에러 방지 목적으로 임시 값 넣었습니다!!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookingHistoryCell", for: indexPath)
                as? BookingHistoryTableViewCell else { return UITableViewCell() }
        
        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 5
        cell.layer.borderColor = UIColor(named: "shadowColor")?.cgColor
        
        return cell
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

