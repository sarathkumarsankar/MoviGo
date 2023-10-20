import UIKit

// Custom header view for Similar movie collectionView
class CustomHeaderView: UIView {

    private struct Constants {
        static let rigthArrowImageName = "ArrowRight"
    }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.Heading.xtraSmall
        label.textColor = UIColor.Text.lightGrey
        return label
    }()

    private let viewAllButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(LocalizedString(key: "movie.viewall.text"), for: .normal)
        button.titleLabel?.font = UIFont.Body.small
        button.setTitleColor(UIColor.Brand.popsicle40, for: .normal)
        return button
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: Constants.rigthArrowImageName)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    // Initializer to set up the header view
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    // Set up the UI elements and constraints
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(viewAllButton)
        addSubview(imageView)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 20),
            imageView.heightAnchor.constraint(equalToConstant: 20),

            viewAllButton.trailingAnchor.constraint(equalTo: imageView.leadingAnchor),
            viewAllButton.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    // Set the title label text
    func setTitleLabelText(_ text: String) {
        titleLabel.text = text
    }

    // Add a target to the view all button
    func addTargetForViewAllButton(_ target: Any?, action: Selector, for event: UIControl.Event) {
        viewAllButton.addTarget(target, action: action, for: event)
    }
}
