//
//  TaskManagerAppUITests.swift
//  TaskManagerAppUITests
//
//  Created by Edward Houser on 1/6/26.
//

import XCTest

final class TaskManagerAppUITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    func testLaunchInEnglish() {
        app.launchArguments = ["-AppleLanguages", "(en)"]
        app.launch()
        
        let header = app.staticTexts["select the working profile"]
        XCTAssertTrue(header.exists, "the English header of 'Select the working profile' does not exist")
    }
    
    func testLaunchinSpanish() {
        app.launchArguments = ["-AppleLanguages", "(es)"]
        app.launch()
        
        let header = app.staticTexts["seleccionar perfil"]
        XCTAssertTrue(header.exists, "the Spanish header of 'Select the working profile' does not exist")
    }
    
    func testNewGroupCreation() {
        let firstProfile = app.buttons.firstMatch
        if firstProfile.exists {
            firstProfile.tap()
            
            let newGroupButton = app.buttons["Add"]
            if newGroupButton.waitForExistence(timeout: 2) {
                newGroupButton.tap()
                XCTAssertTrue(app.staticTexts["Group Name"].exists)
                XCTAssertTrue(app.staticTexts["Select Icon"].exists)

            }
            
        }
    }

    
}
