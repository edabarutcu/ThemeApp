//
//  ProfileInteractor.swift
//  ThemeApp
//
//  Created by Eda Barutçu on 20.06.2025.
//

import Foundation
import Combine

class ProfileInteractor: ProfileInteractorProtocol {
    private let userProfileSubject = CurrentValueSubject<UserProfile, Never>(UserProfile.mockProfile)
    private let loadingSubject = CurrentValueSubject<Bool, Never>(false)
    private let errorSubject = CurrentValueSubject<String?, Never>(nil)
    
    var userProfilePublisher: AnyPublisher<UserProfile, Never> {
        userProfileSubject.eraseToAnyPublisher()
    }
    
    var loadingPublisher: AnyPublisher<Bool, Never> {
        loadingSubject.eraseToAnyPublisher()
    }
    
    var errorPublisher: AnyPublisher<String?, Never> {
        errorSubject.eraseToAnyPublisher()
    }
    
    func loadUserProfile() {
        loadingSubject.send(true)
        errorSubject.send(nil)
        
        // Simulate network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.loadingSubject.send(false)
            self?.userProfileSubject.send(UserProfile.mockProfile)
        }
    }
    
    func logout() {
        // Handle logout logic
        print("User logged out")
    }
    
    func updateUserProfile(_ profile: UserProfile) {
        userProfileSubject.send(profile)
    }
} 