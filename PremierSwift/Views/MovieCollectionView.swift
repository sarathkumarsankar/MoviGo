
import UIKit
 //  reusable MovieCollectionView
 class MovieCollectionView: UIView {

     private struct Contants {
         static let cellIdentifier = "SimilarMovieCell"
         static let headerTitle = "movie.similar.title"
         static let headerHeight = 48.0
         static let interitemSpacing = 10.0
     }
     
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = Contants.interitemSpacing
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    var movies: [Movie] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    let headerView = CustomHeaderView()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        setupCollectionView()
        setConstraints()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    func setupCollectionView() {
        collectionView.dm_registerClassWithDefaultIdentifier(cellClass: SimilarMovieCell.self)
        headerView.setTitleLabelText(LocalizedString(key: Contants.headerTitle))
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(headerView)
        self.addSubview(collectionView)
    }

    func setConstraints() {
        // Set Auto Layout constraints for the UICollectionView
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: Contants.headerHeight),
            
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

extension MovieCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Contants.cellIdentifier, for: indexPath) as! SimilarMovieCell
        cell.configure(with: movies[indexPath.item])
        return cell
    }
}

extension MovieCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Handle item selection
    }
}

extension MovieCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfCellsInRow = 2.5
        let availableWidth = collectionView.frame.width
        let cellWidth = availableWidth / CGFloat(numberOfCellsInRow)
        let cellHeight: CGFloat = collectionView.frame.height
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
