//
//  SionViewController.swift
//  OttukiDinning
//
//  Created by t2023-m0095 on 4/22/24.
//

import UIKit


class SionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let collectionView = UITableView()
    var result : [SearchStoreData] = SearchStoreData.data
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var sortingStyleButton: UIButton!
    @IBOutlet weak var listStyleButton: UIButton!
    @IBOutlet weak var collectionStyleButton: UIButton!
    @IBOutlet weak var searchCollectionView: UICollectionView!
    
    var isCollectionMode = true
    var isListMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            SearchStoreData.data.sort {
                if $0.rate == $1.rate {
                    return $0.name < $1.name
                } else {
                    return $0.rate > $1.rate
                }
            }

        result = SearchStoreData.data
        self.searchCollectionView.reloadData()
        
        setSortingButton(sortingStyleButton)
        
        setCollectionView()
        
        
    }
    
    
    //MARK: - CollectionView
    
    func setCollectionView() {
        searchCollectionView.dataSource = self
        searchCollectionView.delegate = self
        searchCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: isCollectionMode ? "CollectionViewCell" : "ListCell")
        searchCollectionView.register(UINib(nibName: isCollectionMode ? "CollectionViewCell" : "ListCell", bundle: nil), forCellWithReuseIdentifier: isCollectionMode ? "CollectionViewCell" : "ListCell")
        
        self.searchCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return result.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if isCollectionMode == true {
            guard let cell = searchCollectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.setCell(result[indexPath.row])
            return cell
        }
        else {
            guard let cell = searchCollectionView.dequeueReusableCell(withReuseIdentifier: "ListCell", for: indexPath) as? ListCell else {
                return UICollectionViewCell()
            }
            cell.setCell(result[indexPath.row])
            return cell
        }
    }
        
        
            //  collectionView - view 사이즈 설정
            func collectionView(_ collectionView: UICollectionView,
                                layout collectionViewLayout: UICollectionViewLayout,
                                sizeForItemAt indexPath: IndexPath) -> CGSize {
                var size = CGSize(width: 160, height: 170)
                
                if isListMode == true {
                    size = CGSize(width: 380, height: 100)
                }
                return size
            }
        
        
        // collectionView - 좌우 마진 설정
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            
            var interval = UIEdgeInsets(top: 0, left: 25, bottom: 25, right: 25)

            if isListMode == true {
                interval = UIEdgeInsets(top: 0, left: 10, bottom: 20, right: 10)
            }
            
            return interval
        }
        
    
     
        //MARK: - Pop up button (정렬방식)
        
        func setSortingButton(_ button: UIButton) {
            let configuration = UIButton.Configuration.tinted()
            button.configuration = configuration
            
            
            let seletedPriority = {(action: UIAction)  in
                
                // 가나다순으로 정렬
                if action.title == "가나다 순" {
                    SearchStoreData.data.sort { $0.name < $1.name }
                } else if action.title == "별점 높은 순" {
                    SearchStoreData.data.sort {
                        if $0.rate == $1.rate {
                            return $0.name < $1.name
                        } else {
                            return $0.rate > $1.rate
                        }
                    }
                }
                
                self.result = SearchStoreData.data  // 데이터 결과값 변경
                self.searchCollectionView.reloadData()
                print(action.title)}
            
            
            self.sortingStyleButton.menu = UIMenu( children: [
                UIAction(title: "별점 높은 순", handler: seletedPriority),
                UIAction(title: "가나다 순", handler: seletedPriority)])
            self.sortingStyleButton.showsMenuAsPrimaryAction = true
            self.sortingStyleButton.changesSelectionAsPrimaryAction = true
            
        }
        
        
        
        //MARK: - IBAction
        @IBAction func tappedSortingButton(_ sender: UIButton) {
            // 정렬 방식 선택을 바꿀 때마다 변경 방식 적용
            setSortingButton(sortingStyleButton)
        }
        
        @IBAction func tappedButton(_ sender: UIButton) {
            
            // 리스트 형식으로 나타나게 하기
            isCollectionMode = false
            isListMode = true
            setCollectionView()
            
        }
        
        @IBAction func tappedCollectionStyle(_ sender: UIButton) {
            
            // 컬렉션 형식으로 나타나게 하기
            isCollectionMode = true
            isListMode = false
            setCollectionView()
        }
        
        
    
} // class
