//
//  AppDIContainer.swift
//  Tving-Clone
//
//  Created by Seonwoo Kim on 6/7/24.
//

import Foundation

final class AppDIContainer {
    
    func makeContentSceneDIContainer() -> ContentDIContainer {
        let dependencies = ContentDIContainer.Dependencies(contentDataSource: ContentDataSource())
        return ContentDIContainer(dependencies: dependencies)
    }
}
