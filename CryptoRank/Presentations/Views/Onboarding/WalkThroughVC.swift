//
//  WalkThroughVC.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 23/02/2025.
//
import UIKit
class WalkThroughVC: UIViewController {
    private let viewmodel = OnboardViewModel()
    var timer:Timer?
    var currentIndex = 0 {
        didSet {
            dotIndicator.currentPage = currentIndex
        }
    }
    private let skipBtn: UIButton = {
        return UIButton(btnTit: .localizable(.onboardingSkip),
                        backgroundolor: .clear,
                        font: .sourceSanBold())
    }()
    
    private lazy var lbTitle: UILabel = {
        return UILabel(text: .localizable(.onboardingWelcome),
                       font: .sourceSanMedium(),
                       alignment: .center)
    }()
    private let collView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isPagingEnabled = true
        cv.backgroundColor = .background
        return cv
    }()
    private let dotIndicator: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .systemGray
        pageControl.currentPageIndicatorTintColor = .primaryApp
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    private let nextBtn: UIButton = {
        let btn =  UIButton(btnTit: .localizable(.onboardingNext),
                            titleColor: .white)
        btn.layer.cornerRadius = 8
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .background
        setUpUI()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }
    
    private func setUpUI(){
        setConstraints()
        collView.delegate = self
        collView.dataSource = self
        collView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        viewmodel.fetchOnboardingItems()
        dotIndicator.numberOfPages = viewmodel.numberOfPages
        nextBtn.addTarget(self, action: #selector(navigateToHome), for: .touchUpInside)
        skipBtn.addTarget(self, action: #selector(navigateToHome), for: .touchUpInside)
        setupTimer()
    }
    private func setupTimer() {
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.changeCell), userInfo: nil, repeats: true)
        }
    }
    @objc private func changeCell() {
        currentIndex = (currentIndex + 1) % viewmodel.numberOfPages
        let indexPath = IndexPath(item: currentIndex, section: 0)
        collView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    @objc private func navigateToHome(){
        let tabContoller = NavTabBarController()
        AppRouter.setRootViewController(tabContoller)
        UserDefaultConfig.saveValue(value: true, forKey: CacheKeys.KEY_WALKTHROUGH_DONE)
    }
    
}
//MARK: - Configure Constraints
extension WalkThroughVC {
    private func setConstraints(){
        view.addSubview(skipBtn)
        view.addSubview(lbTitle)
        view.addSubview(dotIndicator)
        view.addSubview(collView)
        view.addSubview(nextBtn)
        NSLayoutConstraint.activate([
            skipBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            skipBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            lbTitle.topAnchor.constraint(equalTo: skipBtn.bottomAnchor, constant: 8),
            lbTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            collView.topAnchor.constraint(equalTo: lbTitle.bottomAnchor, constant: 16),
            collView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collView.bottomAnchor.constraint(equalTo: dotIndicator.topAnchor, constant: -16),
            
            dotIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dotIndicator.bottomAnchor.constraint(equalTo: nextBtn.topAnchor, constant: -8),
            
            nextBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            nextBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nextBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nextBtn.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}

extension WalkThroughVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewmodel.numberOfPages
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OnboardingCollectionViewCell
        cell.configure(with: viewmodel.getOnboardingModel(at: indexPath.row))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame
        return CGSize(width: size.width, height: size.height)
    }
    
}
