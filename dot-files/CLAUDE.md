# Style Guidelines

## General

- There should never be trailing whitespace.

## Python

- Imports should always go to the top of the file.

# Running Linters
- Linters and formatters are typically setup with `pre-commit`.
- After making changes, run `pre-commit run -a` to ensure they still pass.

# Writing Tests
- Tests are typically implemented with `pytest`.
- When writing new pytest based tests, try to hide shared logic in fixtures rather than use parametrization. For example:
    
    @pytest.fixture
    def run_code_under_test():

        def inner(*args, **kwargs):
            # setup shared stuff
            result = code_under_test()
            # shared assertions
            return result

        return inner


    def test_code_under_test(run_code_under_test):
        # test specific setup
        result = run_code_under_test()
        # test specific assertions
