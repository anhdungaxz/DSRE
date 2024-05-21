//
//  DSRE.swift
//  DSRE
//
//  Created by Dũng Phạm Tiến  on 29/03/2024.
//

import Foundation
import Alamofire
import Reachability

public class DSRE {
    
    private let domainDSRE = "http://10.144.39.154:8899/"
    
    public static let share = DSRE()
    
    private var apiKey: String?
    
    private var clientId: String?
    
    private var delegate: DSREDelegate?
    
    private var cpInfo: DSRE_CPModel?
    
    public func initialize(apiKey: String, clientId: String) {
        self.apiKey = apiKey
        self.clientId = clientId
        getCPInfo()
    }
    
    private func getCPInfo() {
        let url = domainDSRE + "cpInfo"
        DSRENetwork.post(url: url, parameters: nil, header: getDefaultHeader()) { (response: AFDataResponse<DSRE_DataResponse<DSRE_CPModel>>) in
            switch response.result{
            case .failure(let error):
                print("DSRE getCPInfo fail")
                
                break
            case .success(let value):
                self.cpInfo = value.data
                break
            }
        }
    }
    
    public func fetchOtp(msisdn: String, completion: @escaping((_ responseCode: DSREResponse, _ otpID: String?, _ otp: String?) -> Void)) {
        let url = domainDSRE + "sendOtp"
        let param = ["msisdn": msisdn.dsreConvert0to84]
        DSRENetwork.post(url: url, parameters: param, header: getDefaultHeader()) { (response: AFDataResponse<DSRE_DataResponse<String>>) in
            switch response.result{
            case .failure(let error):
                completion(DSREResponse(code: -1, message: error.localizedDescription), nil, nil)
                print("DSRE sendOtp fail")
                break
            case .success(let value):
                completion(DSREResponse(code: value.statusCode ?? -1, message: value.message), value.requestId, value.data)
                break
            }
        }
    }
    
    public func verifyOtp(otpId: String, otp: String,  completion: @escaping((_ responseCode: DSREResponse, _ authen: DSRE_Authen?) -> Void)) {
        let url = domainDSRE + "verifyOtp"
        let param = ["otpId": otpId, "otp": otp]
        DSRENetwork.post(url: url, parameters: param, header: getDefaultHeader()) { (response: AFDataResponse<DSRE_DataResponse<DSRE_Authen>>) in
            switch response.result{
            case .failure(let error):
                completion(DSREResponse(code: -1, message: error.localizedDescription), nil)
                print("DSRE verifyOtp fail")
                break
            case .success(let value):
                completion(DSREResponse(code: value.statusCode ?? -1, message: value.message), value.data)
                break
            }
        }
    }
    
    public func loginViaCellular(completion: @escaping((_ responseCode: DSREResponse, _ authen: DSRE_Authen?) -> Void)) {
        checkCellular { isUsingCellular in
            if isUsingCellular {
                let url = self.domainDSRE + "login4G"
                DSRENetwork.post(url: url, parameters: nil, header: self.getDefaultHeader()) { (response: AFDataResponse<DSRE_DataResponse<DSRE_Authen>>) in
                    switch response.result{
                    case .failure(let error):
                        completion(DSREResponse(code: -1, message: error.localizedDescription), nil)
                        print("DSRE verifyOtp fail")
                        break
                    case .success(let value):
                        completion(DSREResponse(code: value.statusCode ?? -1, message: value.message), value.data)
                        break
                    }
                }
            } else {
                completion(DSREResponse(code: 11, message: "Thiết bị không sử dụng mạng 3G/4G. Vui lòng kiểm tra lại"), nil)
            }
        }
    }
    
    public func loginViaMasterApp(completion: @escaping((_ responseCode: DSREResponse, _ authen: DSRE_Authen?) -> Void)) {
        
    }
    
    private func checkCellular(completion: @escaping ((Bool) -> Void)) {
        let reachability = try! Reachability()
        var callback: ((Bool) -> Void)? = completion
        reachability.whenReachable = { reachability in
            reachability.stopNotifier()
            if reachability.connection == .cellular {
                callback?(true)
            } else {
                callback?(false)
            }
            callback = nil
        }
        reachability.whenUnreachable = { _ in
            reachability.stopNotifier()
            callback?(false)
            callback = nil
        }

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    private func getDefaultHeader() -> [String: String] {
        return ["api_key": apiKey ?? "", "client_id": clientId ?? ""];
    }
    
}
