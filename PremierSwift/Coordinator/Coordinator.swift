import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get }
    var navigationController: UINavigationController { get }
    func start()
}

class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController = UINavigationController()
    
    func start() {
        let viewModel = MoviesViewModel(apiManager: APIManager())
        navigationController.view.backgroundColor = .white
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.barTintColor = .white
        navigationController.navigationBar.isTranslucent = false
        let vc = MoviesViewController(viewModel: viewModel)
        vc.mainCoordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showMovieDetail(movie: Movie) {
        let viewModel = MoviesDetailsViewModel(movie: movie, apiManager: APIManager())
        let viewController = MovieDetailsViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
