//
//  SourceEditorCommand.swift
//  Formatter
//
//  Created by Simon Anreiter on 29.01.20.
//  Copyright © 2020 Simon Anreiter. All rights reserved.
//

import Foundation
import SwiftFormat
import SwiftFormatConfiguration
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {

    func perform(
        with invocation: XCSourceEditorCommandInvocation,
        completionHandler: @escaping (Error?) -> Void
    ) {

        var output = ""

        do {
            
            let configData = """
                {
                  "blankLineBetweenMembers" : {
                    "ignoreSingleLineProperties" : true
                  },
                  "indentation" : {
                    "spaces" : 4
                  },
                  "indentConditionalCompilationBlocks" : false,
                  "lineBreakBeforeControlFlowKeywords" : false,
                  "lineBreakBeforeEachArgument" : true,
                  "lineLength" : 100,
                  "maximumBlankLines" : 1,
                  "respectsExistingLineBreaks" : true,
                  "rules" : {
                    "AllPublicDeclarationsHaveDocumentation" : true,
                    "AlwaysUseLowerCamelCase" : true,
                    "AmbiguousTrailingClosureOverload" : true,
                    "BeginDocumentationCommentWithOneLineSummary" : true,
                    "BlankLineBetweenMembers" : true,
                    "CaseIndentLevelEqualsSwitch" : true,
                    "DoNotUseSemicolons" : true,
                    "DontRepeatTypeInStaticProperties" : true,
                    "FullyIndirectEnum" : true,
                    "GroupNumericLiterals" : true,
                    "IdentifiersMustBeASCII" : true,
                    "MultiLineTrailingCommas" : true,
                    "NeverForceUnwrap" : true,
                    "NeverUseForceTry" : true,
                    "NeverUseImplicitlyUnwrappedOptionals" : true,
                    "NoAccessLevelOnExtensionDeclaration" : true,
                    "NoBlockComments" : true,
                    "NoCasesWithOnlyFallthrough" : true,
                    "NoEmptyTrailingClosureParentheses" : true,
                    "NoLabelsInCasePatterns" : true,
                    "NoLeadingUnderscores" : true,
                    "NoParensAroundConditions" : true,
                    "NoVoidReturnOnFunctionSignature" : true,
                    "OneCasePerLine" : true,
                    "OneVariableDeclarationPerLine" : true,
                    "OnlyOneTrailingClosureArgument" : true,
                    "OrderedImports" : true,
                    "ReturnVoidInsteadOfEmptyTuple" : true,
                    "UseEnumForNamespacing" : true,
                    "UseLetInEveryBoundCaseVariable" : true,
                    "UseShorthandTypeNames" : true,
                    "UseSingleLinePropertyGetter" : true,
                    "UseSynthesizedInitializer" : true,
                    "UseTripleSlashForDocumentationComments" : true,
                    "ValidateDocumentationComments" : true
                  },
                  "tabWidth" : 8,
                  "version" : 1
                }
                """.data(using: .utf8)!
            
            let config = try JSONDecoder().decode(
                Configuration.self,
                from: configData
            )

            let formatter = SwiftFormatter(configuration: config)

            let assumingFileURL = URL(fileURLWithPath: "<stdin>")
            try formatter.format(
                source: invocation.buffer.completeBuffer,
                assumingFileURL: assumingFileURL,
                to: &output
            )

            invocation.buffer.completeBuffer = output

            completionHandler(nil)
        } catch {

            completionHandler(error)
        }
    }

}
