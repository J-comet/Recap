//
//  NotificationManager.swift
//  Recap
//
//  Created by 장혜성 on 2023/08/19.
//

import UIKit

class NotificationManager {
    static let shared = NotificationManager()
    let notificationCenter = UNUserNotificationCenter.current()
    private init() {}
    
    enum identifier: String {
    case schedule
    }
    
    enum hour: Int {
        case mainSchedule = 8
    }
    
    func authorization(
        successHandler: @escaping () -> Void,
        endHandler: @escaping () -> Void
    ) {
        notificationCenter.requestAuthorization(
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
        identifier: String) {
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
}
