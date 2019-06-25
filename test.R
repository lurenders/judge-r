test_equal <- function(description, generated, expected) {
    get_reporter()$start_test(expected, description)

    tryCatch({
        expected_val <- expected
        generated_val <- generated(test_env$clean_env)
        if (expected_val == generated_val) {
            get_reporter()$end_test(generated_val, "correct")
        } else {
            get_reporter()$end_test(generated_val, "wrong")
        }
    },
    error = function(e) {
        get_reporter()$end_test("", "wrong")
        get_reporter()$start_test("", description)
        get_reporter()$end_test(e, "runtime error")
    },
    warning = function(w) {
        get_reporter()$add_message(paste("Warning while evaluating test: ", w, sep = ''))
    },
    message = function(m) {
        get_reporter()$add_message(paste("Message while evaluating test: ", m, sep = ''))
    })
}