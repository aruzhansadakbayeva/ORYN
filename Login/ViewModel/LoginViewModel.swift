//
//  LoginViewModel.swift
//  BCR
//
//  Created by Aruzhan  on 17.12.2022.
//

import Foundation
import Combine

enum LoginState {
    case successful
    case failed(error: Error)
    case na
}

protocol LoginViewModel {
    func login()
    var service: LoginService { get }
    var state: LoginState { get }
    var credentials: LoginCredentials { get }
    var hasError: Bool { get }
    init(service: LoginService)
}
final class LoginViewModelImpl: ObservableObject, LoginViewModel {
    @Published var hasError: Bool = false
    @Published var state: LoginState = .na
    @Published var credentials: LoginCredentials = LoginCredentials.new
    private var subscription = Set<AnyCancellable>()
    let service: LoginService
    init(service: LoginService) {
        self.service = service
        setupErrorSubscriptions()
    }
    func login() {
        service.login(with: credentials).sink { res in switch res {
        case .failure(let err): self.state = .failed(error: err)
        default: break
        }}
    receiveValue: { [weak self] in self?.state = .successful}
            .store(in: &subscription)

    }
}
private extension LoginViewModelImpl {
    func setupErrorSubscriptions() {
        $state .map { state -> Bool in switch state {
        case .successful, .na: return false
        case .failed:
            return true
        }}.assign(to: &$hasError)
    }
}
