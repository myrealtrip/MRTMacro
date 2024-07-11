import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

@main
struct MRTMacroPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        ServerDrivenTypeMacro.self
    ]
}
