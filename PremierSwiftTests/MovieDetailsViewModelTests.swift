
import XCTest
@testable import PremierSwift

class MoviesDetailsViewModelTests: XCTestCase {
    
    var mockAPIManager: MockAPIManager!
    var viewModel: MoviesDetailsViewModel!

    override func setUp() {
        super.setUp()
        mockAPIManager = MockAPIManager()
        let movie = Movie(id: 23, title: "Jams bond", overview: "revenge", posterPath: "/test/img.png", voteAverage: 5.6)
        viewModel = MoviesDetailsViewModel(movie: movie, apiManager: mockAPIManager)
    }

    override func tearDown() {
        super.tearDown()
        mockAPIManager = nil
        viewModel = nil
    }

    // Define a test case for handling an error
    func testFetchDataError() {
        let dispatchGroup = DispatchGroup()

        mockAPIManager.mockResult = .failure(APIError.networkError)

        let expectation = XCTestExpectation(description: "Updated state should be .error")
        viewModel.updatedState = {
            if case .error = self.viewModel.state {
                expectation.fulfill()
            }
        }
        viewModel.fetchData(dispatchGroup: dispatchGroup)
        wait(for: [expectation], timeout: 5)
    }
}
