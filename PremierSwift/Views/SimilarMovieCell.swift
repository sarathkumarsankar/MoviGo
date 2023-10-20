import UIKit

/// Cell for Movie collectionView
class SimilarMovieCell: UICollectionViewCell {
    // MARK: - UI Elements
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.Image.cornerRadius
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Body.smallSemiBold
        label.numberOfLines = 1
        label.textColor = UIColor.Text.charcoal
        return label
    }()
    
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Body.small
        label.numberOfLines = 1
        label.textColor = .gray
        return label
    }()
    
    // TagView
    let tagView = TagView()
    var containerStackView = UIStackView()

    private struct Constants {
        static let spacing = 10.0
        struct Image {
            static let width = 144.0
            static let height = 212.0
            static let cornerRadius = 8.0
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        containerStackView.spacing = Constants.spacing
        containerStackView.axis = .vertical
        containerStackView.alignment = .leading
        containerStackView.distribution = .fillProportionally
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerStackView)
        containerStackView.dm_addArrangedSubviews(imageView, titleLabel, bodyLabel, tagView)
        containerStackView.setCustomSpacing(0.1, after: titleLabel)
        setConstraints()
    }
    
    func setConstraints() {
        // Layout constraints
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.heightAnchor.constraint(equalToConstant: Constants.Image.height),
            tagView.heightAnchor.constraint(equalToConstant: 32),
        ])
    }
    
    // MARK: - Configuration
     func configure(with movie: Movie) {
         if let path = movie.posterPath {
             imageView.dm_setImage(posterPath: path)
         } else {
             imageView.image = nil
         }
         tagView.configure(.rating(value: movie.voteAverage))
         titleLabel.text = movie.title
         // TODO Genre not coming from api, hence hard coding
         bodyLabel.text = "Action: Genre"
     }
}
