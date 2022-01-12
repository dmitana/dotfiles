.PHONY: lint eslint tsc

# Lint project using eslint and then compile using tsc
lint: eslint tsc

eslint:
	npx eslint --max-warnings 0 . --ext .ts,.tsx,.js

tsc:
	tsc --skipLibCheck
	cd cypress && tsc
