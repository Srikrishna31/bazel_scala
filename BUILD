scala_binary(
    name = "App",
    deps = [
        "//bazeltest"
    ],
    main_class = "bazeltest.Main"
)

alias (
    name = "package-app",
    actual = ":App_deploy.jar"
)

test_suite(
    name = "test-app",
    tests = [
        "//othermodule:test-othermodule",
        "//bazeltest:test-main",
    ]
)