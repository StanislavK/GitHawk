//
//  RepositoryIssueSummaryModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 9/3/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit
import StyledTextKit

class RepositoryIssueSummaryModel: ListDiffable {

    let id: String
    let title: StyledTextRenderer
    let number: Int
    let created: Date
    let author: String
    let status: IssueStatus
    let pullRequest: Bool
    let labels: [RepositoryLabel]
    let ciStatus: RepositoryIssueCIStatus?

    // quicker comparison for diffing rather than scanning the labels array
    let labelSummary: String

    init(
        id: String,
        title: StyledTextRenderer,
        number: Int,
        created: Date,
        author: String,
        status: IssueStatus,
        pullRequest: Bool,
        labels: [RepositoryLabel],
        ciStatus: RepositoryIssueCIStatus?
        ) {
        self.id = id
        self.title = title
        self.number = number
        self.created = created
        self.author = author
        self.status = status
        self.pullRequest = pullRequest
        self.labels = labels
        self.labelSummary = labels.reduce("", { $0 + $1.name })
        self.ciStatus = ciStatus
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? RepositoryIssueSummaryModel else { return false }
        return id == object.id
            && number == object.number
            && pullRequest == object.pullRequest
            && status == object.status
            && author == object.author
            && created == object.created
            && title.string == object.title.string
            && labelSummary == object.labelSummary
            && ciStatus == object.ciStatus
    }
}
