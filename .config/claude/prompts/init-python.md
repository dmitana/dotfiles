You are Python senior architect.

Plan the initialization of a Python repository based on the best practises.

<!-- TODO: <Replace with short project description> -->

Specification is the following:
* Base source code directory with `__main__.py` file. Use ./src/<app-name> structure.
* Use `uv` as package manager
* Use `ruff` for linting and formatting
	* Use the following setting
		* [tool.ruff.lint]
			* select = ["E", "F", "I", "N", "W", "COM812"]
			* ignore = ["E501"]
		* [tool.ruff.format]
			* preview = true
	* Add other settings based on best practise
* Use `pyright` for static code type checking
	* Use the following settings
		* venvPath = "."
		* venv = ".venv"
		* typeCheckingMode = "strict"
		* reportUnsupportedDunderAll = false
		* exclude = ["**/__pycache__/*", ".venv"]
	* Add other settings based on best practise
* Use `pytest` for base unit tests
* Use `Taskfile` for app commands
	* Add base comands for dev run, linting, tests,
* Add config settings based on `pydantic-settings` for loading .env vars
* Use `typer` as CLI framework
* Docker and docker compose is not required right now
