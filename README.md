# Setting up scala with bazel
This project sets up the scala development environment with bazel build system.
It follows the instructions mentioned here: https://scalac.io/set-up-bazel-build-tool-for-scala-project/

# Prerequisites:
Bazel - It is the only prerequisite for setting up this project. Please refer to this page for instructions about
setting up bazel for specific platforms: https://docs.bazel.build/versions/2.1.0/install.html

# Updating Scala Compiler:
This needs three libraries:
- scala compiler : https://repo1.maven.org/maven2/org/scala-lang/scala-compiler/
- scala library : https://repo1.maven.org/maven2/org/scala-lang/scala-library/
- scala reflect : https://repo1.maven.org/maven2/org/scala-lang/scala-reflect/
Navigate to maven repo for each, goto appropriate version, and download the jar, and find its sha256sum, and
paste it in the scala_repositories method.
Note: if the rules_scala doesn't have the scala compiler version, it will create an error in the build.

# Steps for adding a new third party dependency
- Navigate to third_party folder and create a new folder with name <dependency_name>(make sure the name is consistent)
- Add files "BUILD", "<dependency_name>.bzl" into the foldee. Note that the name for .bzl file is the same as the folder name(and dependency name).
- Add the following code in the "<dependency_name>.bzl" file, replace the "<dependency_name>" with the third party library/dependency name:
```
load("@bazel_tools//tools/build_defs/repo:java.bzl", "java_import_external")

def load_<dependency_name>():
    if "dependency_name" not in native.existing_rules():
        java_import_external(
            name = "dependency_name",
            jar_sha256 = "",
            jar_urls = [
                "<appropriate url here>",
            ],
```
- Replace the <dependency_name> with the actual third party library name in the above code.
- Next, in the dependencies.bzl file:
    - Add the line:
    ```
    load("//third_party/<dependency_name>:<dependency_name.bzl>", "load_<dependency_name>")
    ```
    - At the end of the file, add:
    ```
    load_<dependency_name>()
    ```
- Add this <dependency_name> as a dependency to the App target
- Build and check that the dependency is being downloaded, without any errors.

# Folder tree
│   .gitignore
│   BUILD
│   README.md
│   WORKSPACE
│
├───bazeltest
│   │   BUILD
│   │
│   └───src
│       ├───main
│       │   └───scala
│       │       └───bazeltest
│       │               Main.scala
│       │
│       └───test
│           └───scala
│               └───bazeltest
│                       MainSpec.scala
│
├───othermodule
│   │   BUILD
│   │
│   └───src
│       ├───main
│       │   └───scala
│       │       └───othermodule
│       │               Worker.scala
│       │
│       └───test
│           └───scala
│               └───othermodule
│                       WorkerSpec.scala
│
├───third_party
│   │   BUILD
│   │   dependencies.bzl
│   │
│   ├───beautiful_scala
│   │       beautiful_scala.bzl
│   │       BUILD
│   │
│   ├───joda_time
│   │       BUILD
│   │       joda_time.bzl
│   │
│   ├───scalaz
│   │       BUILD
│   │       scalaz.bzl
│   │
│   └───scala_js
│           BUILD
│           scala_js.bzl
│
└───tools
    └───build_rules
            BUILD
            prelude_bazel

# Compiling, testing and running
All the commands below assume the project root directory as the current directory.
1. To compile the entire application use:
```
bazel build App
```
2. To run the tests use:
```
bazel test test-app
```
3. To run the app itself, use:
```
bazel run App
```
4. To package the application, run the following:
```
bazel build package-app
```
This will build the app_deploy.jar file that contains all the dependencies bundled together, that is ready for deployment.
It can be run as follows:
```
java -jar <path-to-jar>/App_deploy.jar
```
