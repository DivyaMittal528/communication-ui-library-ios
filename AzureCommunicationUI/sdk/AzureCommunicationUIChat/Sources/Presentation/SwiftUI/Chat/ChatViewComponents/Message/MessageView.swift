//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//  Licensed under the MIT License.
//

import SwiftUI

struct MessageView: View {
    let messageModel: ChatMessageInfoModel
    let showDateHeader: Bool
    let isConsecutive: Bool
    let showUsername: Bool
    let showTime: Bool

    // Inject localization with environment?

    var body: some View {
        VStack {
            dateHeader
            message
        }
    }

    var dateHeader: some View {
        Group {
            if showDateHeader {
                Text(messageModel.dateHeaderLabel)
                    .font(.caption)
                    .foregroundColor(Color(StyleProvider.color.textSecondary))
            }
        }
    }

    var message: some View {
        Group {
            switch messageModel.type {
            case .text, .html:
                if messageModel.deletedOn == nil || messageModel.content == nil {
                    TextMessageView(messageModel: messageModel,
                                    showUsername: showUsername,
                                    showTime: showTime)
                }
            case .participantsAdded, .participantsRemoved, .topicUpdated:
                SystemMessageView(messageModel: messageModel)
            default:
                EmptyView()
            }
        }
    }
}