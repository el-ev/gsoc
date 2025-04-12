#let justify_align(left_body, right_body) = {
  block[
    #box(width: 1fr)[
      #align(left)[
        #left_body
      ]
    ]
    #box(width: 1fr)[
      #align(right)[
        #right_body
      ]
    ]
  ]
}


#let pr(repo, pr, ..args) = {
  let show_name = args.at(0, default: false)
  if show_name {
    [
      #link("https://github.com/" + repo + "/pull/" + str(pr), repo + "#" + str(pr))
    ]
  } else {
    [
      #link("https://github.com/" + repo + "/pull/" + str(pr), "#" + str(pr))
    ]
  }
}

#set page(
  paper: "a4",
  margin: (
    top: 2cm,
    bottom: 2cm,
    left: 2cm,
    right: 2cm,
  ),
  footer: [
    #set text(fill: gray, size: 8pt)
    #pad(top: 0pt, bottom: 0pt, [])

    #justify_align[
      #smallcaps[#datetime.today().display("Compiled at [year]-[month]-[day]")]
    ][
      #context [
        #counter(page).display()
      ]
    ]
  ],
  footer-descent: 0pt,
)
#set par(justify: true)

#show link : underline

#align(
  center,
  text(size: 24pt, weight: "bold")[
    #pad(top: 0pt, bottom: -10pt, [ Proposal for GSoC 2025 ])
  ],
)

#align(
  center,
  text(size: 24pt, weight: "medium")[
    Participate in ClangIR Upstreaming
  ],
)
#pad(top: 0pt, bottom: -10pt, [])

= Project Abstract
#pad(top: 0pt, bottom: -10pt, [])

This project focuses on participating in the process of bringing ClangIR, currently an LLVM incubator project, into the main LLVM monorepo. 

#link("https://github.com/llvm/clangir", "Project Repo") #text("") #link("https://discourse.llvm.org/t/clangir-gsoc-2025-clangir-upstreaming/84766", "Description")

= Applicant Information
#pad(top: 0pt, bottom: -10pt, [])

- #strong("Name"): [REDACTED]
- #strong("GitHub"): #link("https://github.com/el-ev", "el-ev (Iris)")
- #strong("Email"): #link("mailto:0.0@owo.li", "0.0@owo.li")
- #strong("Education"):
  - 2022-Present: *Beihang University*, Computer Science and Technology
- #strong("Contributions to ClangIR") \(till April 2#super[nd], #link("https://github.com/llvm/clangir/pulls?q=sort%3Aupdated-desc+is%3Apr+author%3Ael-ev", "Link")\):
 - #pr("llvm/clangir", 1502) [CIR][CIRGen][Builtin] add `__builtin_tan`
 - #pr("llvm/clangir", 1504) [CIR] Refactor `StructType` with TableGen
 - #pr("llvm/clangir", 1508) [CIR] Add `AddressPointAttr`
 - #pr("llvm/clangir", 1521) [CIR][CIRGen][NFC] Handle `PragmaComment` in `emitTopLevelDecl`
 - #pr("llvm/llvm-project", 133385, true) [mlir][llvm] Add `LLVM_DependentLibrariesAttr`
 - #pr("llvm/clangir", 1532) [CIR][LowerToLLVM] Support for LinkerOptions lowering
 - #pr("llvm/clangir", 1543) [CIR][CIRGen][Builtin] Add `__builtin_elementwise_{log, log2, log10}`
- #strong("Related Experience"):
  - Have 2 years of experience in C, modern C++, and Rust programming, and basic knowledge of several other languages. 
  - Finished Compiler Principle course, with a simplfied C compiler as the final project.
  - Have some previous contributions to llvm-project. #link("https://github.com/llvm/llvm-project/pulls?q=is%3Apr+author%3Ael-ev", "Link"). Have basic understanding of LLVM IR and llvm internals.
  - Have previous experince in other open source projects, like #link("https://github.com/files-community/Files/pulls?q=sort%3Aupdated-desc+is%3Apr+author%3Ael-ev+is%3Aclosed", "files-community/Files") (in C\#) and #link("https://github.com/web3infra-foundation/mega/pulls?q=sort%3Aupdated-desc+is%3Apr+is%3Aclosed+author%3Ael-ev", "web3infra-foundation/mega") (in Rust).
  - Teaching Assistant of Operating System course in Beihang University. 

= Proposal

=== Project Name

Participate in ClangIR Upstreaming

=== Synopsis

The project consists of three main objectives:
+ Migrate ClangIR support for C and C++ language features into the main LLVM repository.
+ While migrating, refactor the codebase to meet the LLVM coding standards.
+ Suggestions for future improvements to ClangIR migration process.

=== Motivation

ClangIR is a MLIR dialect for C/C++ based languages. It is designed to express high level C/C++ semantics, enabling a class of idiomatic diagnostics and performance optimizations that are hard to explore on Clang AST or LLVM IR level.

After two years of development, ClangIR has started the process of upstreaming. This process will make ClangIR more accessible to the LLVM community, encouraging more contributions. Additionally, the upstreaming process will involve high-quality refactoring and code reviews, enhancing the overall quality of the codebase.

=== Concrete Deliverables

For coding parts, this project will deliver the following:
- *At least eight* feature parts (pull requests, each of about 500 lines of code) merged into the llvm-project repository.
- Enhancements to the ClangIR codebase, such as refactoring, code cleanup, and implementing NYI parts of the features.

As ClangIR is under active development and the upstreaming process is in progress, it is uncertain which features will be ready for upstreaming when the coding period officially starts. Therefore, the exact features to be migrated will be determined later in collaboration with the community. Project success will be determined by successful upstreaming of the feature or set of features agreed up by the project mentor. 

=== Development Plan

The following plan outlines the steps to have a single feature migrated into the llvm-project repository. After one feature is successfully migrated, the process will be repeated for the next feature.

+ *Feature Identification:* Collaborate with mentors to select a specific C/C++ language feature within the ClangIR codebase for migration.
+ *Code Locating and Understanding:* Thoroughly examine the existing ClangIR codebase to identify code sections related to the chosen feature. Understand the structure, functionality and dependencies of the code.
+ *Decomposition:* Depending on the size and complexity, divide the code into smaller units that are independently reviewable and testable.
+ *Refactoring:* Choose one of the units. Refactor the code to ensure it adheres to the LLVM coding standards. 
+ *Testing:* Locate and adapt existing ClangIR tests that directly exercise the migrated feature. Write new tests to improve coverage if necessary.
+ *Review and Refinement:* Submit the refactored code along with the tests to llvm-project for review. Actively participate in the review process, addressing feedback and making necessary changes, until the code is approved and merged.
+ Iteratively repeat Step 4 to 6 for the remaining units of the feature.

// #pagebreak()

=== Expected Timeline

#table(
  columns: 2,
  align: horizon,
  [*Date*], [*Work*],
  [Prior to May 8#super[th]], [
    - Set up development environment.
    - Get familiar with the ClangIR bodebase.
    - Fix issues in the ClangIR repository.
  ],
  [May 9#super[th]-May 31#super[st]], [
    - Select a specific feature for migration with the mentors.
    - Locate and understand the relevant code sections.
    - Aim for at least one patch submitted (if not merged).
  ],
  [June 1#super[st]-July 14#super[th]], [
    - Continue refactoring, testing, and submitting patches related to the feature.
    - Follow up on the review process.
    - Have 4 patches submitted and merged by the end of this period.
    - Prepare documents for midterm evaluation.
  ],
  [July 15#super[th]-August 25#super[th]],[
    - Continue working on the selected feature, or, if completed, begin a new one.
    - Prioritize merging existing patches.
    - Have another 4 patches submitted and merged.
    - Prepare documents for final evaluation.
  ]
)

= Extra Information

=== Working Hours

I will be based in Beijing, China during the coding period. Therefore, I will be working in the UTC+8 timezone. 

I believe I can finish the project in 12 weeks, which is the size of a *large-scale project*. If I finish the original plan earlier than expected, I would like to work on upstreaming more features.

I will be taking final exams in the last two weeks of June, when I may be less available (but still progressing). Other than that, I will be able to fully commit to the project.

=== Reason for Participation

I am an undergraduate student majoring in Computer Science and Technology and have a strong interest in compilers and programming languages. LLVM is a well-known compiler infrastructure which provides a lot of opportunities for learning compiler techniques. Among the projects provided by LLVM for GSoC 2025, ClangIR is a relatively new and fast evolving project, which I believe will be easier for me to make significant contribution to, as well as learn a lot from. 

I've completed the Compiler Principle course in my university, have concrete C++ programming experience, and my previous contributions to LLVM and ClangIR could demonstrate my ability to write clear and well-tested code.

In the future, I hope to work in the field of compilers and programming languages. I believe that participating in GSoC 2025, especially in the ClangIR project, will be a great opportunity for me to learn more about compiler design, and further help me to achieve my career goals.

If I had the opportunity to participate in GSoC with LLVM community, I would do my best to complete this project. I am looking forward to working with the LLVM community and contributing to the ClangIR project.