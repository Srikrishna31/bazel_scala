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

#Steps for adding a new third party dependency
We will take the example of adding "joda-time" dependency, and then outline the steps:
- Navigate to third_party folder and create a new folder with name "joda-time"(make sure the name is consistent)
- Add files "BUILD", "joda_time.bzl" into the foldee. Note that the name for .bzl file is the same as the folder name(and dependency name).
- Add the following code in the "joda-time.bzl" file, replace the "dependency_name" with "joda_time":
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
- Next, in the dependencies.bzl file:
    - Add the line: load("//third_party/<dependency_name>:<dependency_name.bzl>", "load_<dependency_name>")
    - At the end of the file, add: "load_<dependency_name>()"
- Add this dependency_name as a dependency to the App target
- Build and check that the dependency is being downloaded, without any errors.