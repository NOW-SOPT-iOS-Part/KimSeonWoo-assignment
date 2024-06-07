//
//  DIConteainer.swift
//  Tving-Clone
//
//  Created by Seonwoo Kim on 6/7/24.
//

import Foundation

final class ContentDIContainer {

    struct Dependencies {
        let contentDataSource: ContentDataSource
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func makeContentRepository() -> ContentRepository {
        return DefaultContentRepository(contentDataSource: dependencies.contentDataSource)
    }
    
    func makeContentUseCase() -> ContentUseCase {
        return DefaultContentUseCase(repository: makeContentRepository())
    }
    
    func makeMainContentViewModel() -> MainContentViewModel {
        return MainContentViewModel(contentUseCase: makeContentUseCase())
    }
    
    func makeMainContentViewController() -> MainContentViewController {
        return MainContentViewController(viewModel: makeMainContentViewModel())
    }
    
    func makeTabBarController() -> TabBarController {
        return TabBarController(mainContentViewModel: makeMainContentViewModel())
    }
}
