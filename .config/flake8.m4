[flake8]
# E129: visually indented line with same indent as next logical line
# E203: whitespace before ':'. False positive bug in flake8.
# W503: line break before binary operator. PEP8 recommends the opposite now.
ignore = E129,E203,W503
import-order-style = google
