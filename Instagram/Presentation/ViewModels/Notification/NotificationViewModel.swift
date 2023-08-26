//
//  NotificationViewModel.swift
//  Instagram
//
//  Created by Jung Choi on 8/25/23.
//

import Foundation

protocol NotificationViewModelDelegate: AnyObject {
    func notificationViewModelDidFetchNotifications(_ notificationViewModel: NotificationViewModel)
}

class NotificationViewModel {
    
    weak var delegate: NotificationViewModelDelegate?
    var thisWeekViewModelCells = [NotificationCellType]()
    var thisMonthViewModelCells = [NotificationCellType]()
    var earlierViewModelCells = [NotificationCellType]()
    
    func fetchNotifications() {
        thisWeekViewModelCells = NotificationViewModel.getThisWeekMockData()
        thisMonthViewModelCells = NotificationViewModel.getThisMonthMockData()
        earlierViewModelCells = NotificationViewModel.getEarlierMockData()
        delegate?.notificationViewModelDidFetchNotifications(self)
    }
}

extension NotificationViewModel {
    static func getThisWeekMockData() -> [NotificationCellType] {
        return [
            NotificationCellType.likes(LikesNotificationCellViewModel(
                username: "dankampe",
                profilePictureURL: URL(string: "https://media.istockphoto.com/id/1296158947/photo/portrait-of-creative-trendy-black-african-male-designer-laughing.jpg?s=612x612&w=0&k=20&c=1Ws_LSzWjYvegGxHYQkkgVytdpDcnmK0upJyGOzEPcg=")!,
                postURL: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcIeIGS_qexOBcAXpQwo4kk_iLuo6mL31RpA&usqp=CAU")!
            )),
            NotificationCellType.follow(FollowNotificationCellViewModel(
                username: "menisecu",
                profilePictureURL: URL(string: "https://st3.depositphotos.com/1017228/18878/i/450/depositphotos_188781580-stock-photo-handsome-cheerful-young-man-standing.jpg")!,
                isFollowing: true
            )),
            NotificationCellType.comment(CommentNotificationCellViewModel(
                username: "batorkou",
                profilePictureURL: URL(string: "https://image.shutterstock.com/mosaic_250/301519563/640011838/stock-photo-handsome-unshaven-young-dark-skinned-male-laughing-out-loud-at-funny-meme-he-found-on-internet-640011838.jpg")!,
                postURL: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcIeIGS_qexOBcAXpQwo4kk_iLuo6mL31RpA&usqp=CAU")!
            ))
        ]
    }
    static func getThisMonthMockData() -> [NotificationCellType] {
        return [
            NotificationCellType.likes(LikesNotificationCellViewModel(
                username: "masineul",
                profilePictureURL: URL(string: "https://st.depositphotos.com/1518767/1390/i/450/depositphotos_13909347-stock-photo-young-employee-standing-upright-in.jpg")!,
                postURL: URL(string: "https://t3.ftcdn.net/jpg/02/70/35/00/360_F_270350073_WO6yQAdptEnAhYKM5GuA9035wbRnVJSr.jpg")!
            )),
            NotificationCellType.likes(LikesNotificationCellViewModel(
                username: "ocluncer",
                profilePictureURL: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwudQ7T6Sx0_QSxURbwS57Lk3lhjCoPAq1_w&usqp=CAU")!,
                postURL: URL(string: "https://t3.ftcdn.net/jpg/02/70/35/00/360_F_270350073_WO6yQAdptEnAhYKM5GuA9035wbRnVJSr.jpg")!
            )),
            NotificationCellType.comment(CommentNotificationCellViewModel(
                username: "nchandon",
                profilePictureURL: URL(string: "https://images.unsplash.com/photo-1542596768-5d1d21f1cf98?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80")!,
                postURL: URL(string: "https://t3.ftcdn.net/jpg/02/70/35/00/360_F_270350073_WO6yQAdptEnAhYKM5GuA9035wbRnVJSr.jpg")!
            )),
            NotificationCellType.likes(LikesNotificationCellViewModel(
                username: "stickent",
                profilePictureURL: URL(string: "https://images.pexels.com/photos/733872/pexels-photo-733872.jpeg?cs=srgb&dl=pexels-andrea-piacquadio-733872.jpg&fm=jpg")!,
                postURL: URL(string: "https://t3.ftcdn.net/jpg/02/70/35/00/360_F_270350073_WO6yQAdptEnAhYKM5GuA9035wbRnVJSr.jpg")!
            )),
            NotificationCellType.comment(CommentNotificationCellViewModel(
                username: "xtrinaba",
                profilePictureURL: URL(string: "https://t4.ftcdn.net/jpg/03/83/25/83/360_F_383258331_D8imaEMl8Q3lf7EKU2Pi78Cn0R7KkW9o.jpg")!,
                postURL: URL(string: "https://t3.ftcdn.net/jpg/02/70/35/00/360_F_270350073_WO6yQAdptEnAhYKM5GuA9035wbRnVJSr.jpg")!
            )),
            NotificationCellType.follow(FollowNotificationCellViewModel(
                username: "sheakent",
                profilePictureURL: URL(string: "https://static.demilked.com/wp-content/uploads/2019/04/5cb6d34f775c2-stock-models-share-weirdest-stories-photo-use-102-5cb5c725bc378__700.jpg")!,
                isFollowing: false
            )),
            NotificationCellType.comment(CommentNotificationCellViewModel(
                username: "ncolditi",
                profilePictureURL: URL(string: "https://img.rawpixel.com/s3fs-private/rawpixel_images/website_content/397-mckinsey-21a3074-jir_1.jpg?w=800&dpr=1&fit=default&crop=default&q=65&vib=3&con=3&usm=15&bg=F4F4F3&ixlib=js-2.2.1&s=bdc5f24b5f6b36b405ef04d2c899efd7")!,
                postURL: URL(string: "https://t3.ftcdn.net/jpg/02/70/35/00/360_F_270350073_WO6yQAdptEnAhYKM5GuA9035wbRnVJSr.jpg")!
            ))
        ]
    }
    static func getEarlierMockData() -> [NotificationCellType] {
        guard let profileURL = URL(string: "https://www.allprodad.com/wp-content/uploads/2021/03/05-12-21-happy-people.jpg"),
              let postURL = URL(string: "https://www.allprodad.com/wp-content/uploads/2021/03/05-12-21-happy-people.jpg")
        else { return [] }
        return [
            NotificationCellType.likes(LikesNotificationCellViewModel(username: "jchoi", profilePictureURL: profileURL, postURL: postURL)),
            NotificationCellType.follow(FollowNotificationCellViewModel(username: "jchoi", profilePictureURL: profileURL, isFollowing: true)),
            NotificationCellType.comment(CommentNotificationCellViewModel(username: "jchoi", profilePictureURL: profileURL, postURL: postURL))
        ]
    }
}

struct LikesNotificationCellViewModel: Hashable {
    let id = UUID()
    let username: String
    let profilePictureURL: URL
    let postURL: URL
}

struct FollowNotificationCellViewModel: Hashable {
    let id = UUID()
    let username: String
    let profilePictureURL: URL
    let isFollowing: Bool
}

struct CommentNotificationCellViewModel: Hashable {
    let id = UUID()
    let username: String
    let profilePictureURL: URL
    let postURL: URL
}
