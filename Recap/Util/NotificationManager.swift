//
//  NotificationManager.swift
//  Recap
//
//  Created by 장혜성 on 2023/08/19.
//

import UIKit

class NotificationManager {
    static let shared = NotificationManager()
    static let notificationCenter = UNUserNotificationCenter.current()
    private init() {}
    
    enum identifier: String {
        case schedule
        case test
    }
    
    enum hour: Int {
        case mainSchedule = 8
    }
    
    // 알림 권한
    func authorization(
        successHandler: @escaping () -> Void,
        endHandler: @escaping () -> Void
    ) {
        NotificationManager.notificationCenter.requestAuthorization(
            options: [.alert, .sound, .badge]) { success, error in
                print(success, error)
                if success {
                    successHandler()
                }
                endHandler()
            }
    }
    
    func pushScheduledByHour(
        title: String,
        body: String,
        hour: Int,
        identifier: String
    ) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        //        content.badge = 100
        
        // 2. 언제 보낼지
        // 최소시간 60초 - 애플 정책
        //            let timeTrigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: true)
        
        //            let dateComponets = Calendar.current.dateComponents([.year,.month,.day,.hour], from: date)
        var dateComponets = DateComponents()
        dateComponets.hour = hour           // 24시간 형식 ( ex) 12시, 13시, 23시..)
        
        let dateTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponets, repeats: true)
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: dateTrigger)
        UNUserNotificationCenter.current().add(request) { error in
            print(error)
        }
    }
    
    func pushTest() {
        // 1. 컨텐츠 설정
        let content = UNMutableNotificationContent()
        content.title = "오이오이"
        content.body = "믿고 있었다구"
        content.badge = 100
        
        // 2. 언제 보낼지
        // 최소시간 60초 - 애플 정책
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        
        let request = UNNotificationRequest(identifier: "test", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            print(error)
        }
    }
}
