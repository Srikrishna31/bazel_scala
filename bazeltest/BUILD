
scala_library(
    name = "bazeltest",
    srcs = ["src/main/scala/bazeltest/Main.scala"],
    deps = [
        "//othermodule",
        "@beautiful-scala",
        "@joda-time",
        "@scala-js",
        "@scalaz"
    ],
    visibility = ["//:__pkg__"]
)

scala_test(
    name = "test-main",
    srcs = ["src/test/scala/bazeltest/MainSpec.scala"],
    deps = [":bazeltest"]
)
