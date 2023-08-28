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
    
    enum Section {
        case thisWeek
        case thisMonth
        case earlier
    }
    
    private let notificationRepository: NotificationRepositoryProtocol
    
    weak var delegate: NotificationViewModelDelegate?
    var thisWeekViewModelCells = [NotificationCellType]()
    var thisMonthViewModelCells = [NotificationCellType]()
    var earlierViewModelCells = [NotificationCellType]()
    var notifications = [IGNotification]()
    
    init(notificationRepository: NotificationRepositoryProtocol) {
        self.notificationRepository = notificationRepository
    }
    
    func fetchNotifications() {
        Task {
            do {
                notifications = try await notificationRepository.getNotifications()
                createSections(notifications: notifications)
                delegate?.notificationViewModelDidFetchNotifications(self)
            } catch {
                print(error.localizedDescription)
            }
        }
//        thisWeekViewModelCells = NotificationViewModel.getThisWeekMockData()
//        thisMonthViewModelCells = NotificationViewModel.getThisMonthMockData()
//        earlierViewModelCells = NotificationViewModel.getEarlierMockData()
    }
    
    func updateFollowStatus(
        cellViewModel: FollowNotificationCellViewModel
    ) {
        guard let notification = notifications.first(where: { $0.username == cellViewModel.username }) else { return }
        Task {
            do {
                try await notificationRepository.updateFollowStatus(receivingUserID: notification.userID, isFollowing: cellViewModel.isFollowing)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

struct LikesNotificationCellViewModel: Hashable {
    let username: String
    let profilePictureURL: URL
    let postURL: URL
    let timeAgo: String
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.username == rhs.username
        && lhs.profilePictureURL == rhs.profilePictureURL
        && lhs.postURL == rhs.postURL
    }
}

struct FollowNotificationCellViewModel: Hashable {
    let username: String
    let profilePictureURL: URL
    var isFollowing: Bool
    let timeAgo: String
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.username == rhs.username
        && lhs.profilePictureURL == rhs.profilePictureURL
        && lhs.isFollowing == rhs.isFollowing
    }
}

struct CommentNotificationCellViewModel: Hashable {
    let username: String
    let profilePictureURL: URL
    let postURL: URL
    let timeAgo: String
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.username == rhs.username
        && lhs.profilePictureURL == rhs.profilePictureURL
        && lhs.postURL == rhs.postURL
    }
}

extension NotificationViewModel {
    
    private func createSections(notifications: [IGNotification]) {
        notifications.forEach { notification in
            switch notification.type {
            case .like:
                guard let postURLString = notification.postImageURL,
                      let postURL = URL(string: postURLString),
                      let profileURL = URL(string: notification.profilePictureURL)
                else { return }
                let vm = LikesNotificationCellViewModel(username: notification.username, profilePictureURL: profileURL, postURL: postURL, timeAgo: String.timeAgo(dateString: notification.timestamp))
                let cellType = NotificationCellType.likes(vm)
                let section = determineSection(timestamp: notification.timestamp)
                switch section {
                case .thisWeek:
                    thisWeekViewModelCells.append(cellType)
                case .thisMonth:
                    thisMonthViewModelCells.append(cellType)
                case .earlier:
                    earlierViewModelCells.append(cellType)
                }
            case .comment:
                guard let postURLString = notification.postImageURL,
                      let postURL = URL(string: postURLString),
                      let profileURL = URL(string: notification.profilePictureURL)
                else { return }
                let vm = CommentNotificationCellViewModel(username: notification.username, profilePictureURL: profileURL, postURL: postURL, timeAgo: String.timeAgo(dateString: notification.timestamp))
                let cellType = NotificationCellType.comment(vm)
                let section = determineSection(timestamp: notification.timestamp)
                switch section {
                case .thisWeek:
                    thisWeekViewModelCells.append(cellType)
                case .thisMonth:
                    thisMonthViewModelCells.append(cellType)
                case .earlier:
                    earlierViewModelCells.append(cellType)
                }
            case .follow:
                guard let isFollowing = notification.isFollowing,
                      let profileURL = URL(string: notification.profilePictureURL)
                else { return }
                let vm = FollowNotificationCellViewModel(username: notification.username, profilePictureURL: profileURL, isFollowing: isFollowing, timeAgo: String.timeAgo(dateString: notification.timestamp))
                let cellType = NotificationCellType.follow(vm)
                let section = determineSection(timestamp: notification.timestamp)
                switch section {
                case .thisWeek:
                    thisWeekViewModelCells.append(cellType)
                case .thisMonth:
                    thisMonthViewModelCells.append(cellType)
                case .earlier:
                    earlierViewModelCells.append(cellType)
                }
            }
        }
    }
    
    private func determineSection(timestamp: String) -> Section {
        let date = Date.string(from: timestamp)
        let timeInterval = date.timeIntervalSinceNow
        if timeInterval > -1_008_000 {
            return .thisWeek
        } else if timeInterval > -30_240_000 {
            return .thisMonth
        }
        return .earlier
    }
    
    static func getThisWeekMockData() -> [NotificationCellType] {
        return [
            NotificationCellType.likes(LikesNotificationCellViewModel(
                username: "dankampe",
                profilePictureURL: URL(string: "https://media.istockphoto.com/id/1296158947/photo/portrait-of-creative-trendy-black-african-male-designer-laughing.jpg?s=612x612&w=0&k=20&c=1Ws_LSzWjYvegGxHYQkkgVytdpDcnmK0upJyGOzEPcg=")!,
                postURL: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcIeIGS_qexOBcAXpQwo4kk_iLuo6mL31RpA&usqp=CAU")!,
                timeAgo: "6h ago"
            )),
            NotificationCellType.follow(FollowNotificationCellViewModel(
                username: "menisecu",
                profilePictureURL: URL(string: "https://st3.depositphotos.com/1017228/18878/i/450/depositphotos_188781580-stock-photo-handsome-cheerful-young-man-standing.jpg")!,
                isFollowing: true,
                timeAgo: "6h ago"
            )),
            NotificationCellType.comment(CommentNotificationCellViewModel(
                username: "batorkou",
                profilePictureURL: URL(string: "https://image.shutterstock.com/mosaic_250/301519563/640011838/stock-photo-handsome-unshaven-young-dark-skinned-male-laughing-out-loud-at-funny-meme-he-found-on-internet-640011838.jpg")!,
                postURL: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcIeIGS_qexOBcAXpQwo4kk_iLuo6mL31RpA&usqp=CAU")!,
                timeAgo: "6h ago"
            ))
        ]
    }
    static func getThisMonthMockData() -> [NotificationCellType] {
        return [
            NotificationCellType.likes(LikesNotificationCellViewModel(
                username: "masineul",
                profilePictureURL: URL(string: "https://st.depositphotos.com/1518767/1390/i/450/depositphotos_13909347-stock-photo-young-employee-standing-upright-in.jpg")!,
                postURL: URL(string: "https://t3.ftcdn.net/jpg/02/70/35/00/360_F_270350073_WO6yQAdptEnAhYKM5GuA9035wbRnVJSr.jpg")!,
                timeAgo: "6h ago"
            )),
            NotificationCellType.likes(LikesNotificationCellViewModel(
                username: "ocluncer",
                profilePictureURL: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwudQ7T6Sx0_QSxURbwS57Lk3lhjCoPAq1_w&usqp=CAU")!,
                postURL: URL(string: "https://t3.ftcdn.net/jpg/02/70/35/00/360_F_270350073_WO6yQAdptEnAhYKM5GuA9035wbRnVJSr.jpg")!,
                timeAgo: "6h ago"
            )),
            NotificationCellType.comment(CommentNotificationCellViewModel(
                username: "nchandon",
                profilePictureURL: URL(string: "https://images.unsplash.com/photo-1542596768-5d1d21f1cf98?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80")!,
                postURL: URL(string: "https://t3.ftcdn.net/jpg/02/70/35/00/360_F_270350073_WO6yQAdptEnAhYKM5GuA9035wbRnVJSr.jpg")!,
                timeAgo: "6h ago"
            )),
            NotificationCellType.likes(LikesNotificationCellViewModel(
                username: "stickent",
                profilePictureURL: URL(string: "https://images.pexels.com/photos/733872/pexels-photo-733872.jpeg?cs=srgb&dl=pexels-andrea-piacquadio-733872.jpg&fm=jpg")!,
                postURL: URL(string: "https://t3.ftcdn.net/jpg/02/70/35/00/360_F_270350073_WO6yQAdptEnAhYKM5GuA9035wbRnVJSr.jpg")!,
                timeAgo: "6h ago"
            )),
            NotificationCellType.comment(CommentNotificationCellViewModel(
                username: "xtrinaba",
                profilePictureURL: URL(string: "https://t4.ftcdn.net/jpg/03/83/25/83/360_F_383258331_D8imaEMl8Q3lf7EKU2Pi78Cn0R7KkW9o.jpg")!,
                postURL: URL(string: "https://t3.ftcdn.net/jpg/02/70/35/00/360_F_270350073_WO6yQAdptEnAhYKM5GuA9035wbRnVJSr.jpg")!,
                timeAgo: "6h ago"
            )),
            NotificationCellType.follow(FollowNotificationCellViewModel(
                username: "sheakent",
                profilePictureURL: URL(string: "https://static.demilked.com/wp-content/uploads/2019/04/5cb6d34f775c2-stock-models-share-weirdest-stories-photo-use-102-5cb5c725bc378__700.jpg")!,
                isFollowing: false,
                timeAgo: "6h ago"
            )),
            NotificationCellType.comment(CommentNotificationCellViewModel(
                username: "ncolditi",
                profilePictureURL: URL(string: "https://img.rawpixel.com/s3fs-private/rawpixel_images/website_content/397-mckinsey-21a3074-jir_1.jpg?w=800&dpr=1&fit=default&crop=default&q=65&vib=3&con=3&usm=15&bg=F4F4F3&ixlib=js-2.2.1&s=bdc5f24b5f6b36b405ef04d2c899efd7")!,
                postURL: URL(string: "https://t3.ftcdn.net/jpg/02/70/35/00/360_F_270350073_WO6yQAdptEnAhYKM5GuA9035wbRnVJSr.jpg")!,
                timeAgo: "6h ago"
            ))
        ]
    }
    static func getEarlierMockData() -> [NotificationCellType] {
        guard let profileURL = URL(string: "https://www.allprodad.com/wp-content/uploads/2021/03/05-12-21-happy-people.jpg"),
              let postURL = URL(string: "https://www.allprodad.com/wp-content/uploads/2021/03/05-12-21-happy-people.jpg")
        else { return [] }
        return [
            NotificationCellType.likes(LikesNotificationCellViewModel(username: "jchoi", profilePictureURL: profileURL, postURL: postURL, timeAgo: "6h ago")),
            NotificationCellType.follow(FollowNotificationCellViewModel(username: "jchoi", profilePictureURL: profileURL, isFollowing: true, timeAgo: "6h ago")),
            NotificationCellType.comment(CommentNotificationCellViewModel(username: "jchoi", profilePictureURL: profileURL, postURL: postURL, timeAgo: "6h ago"))
        ]
    }
}
