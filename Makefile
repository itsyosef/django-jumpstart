PYTHON_VERSION := 3.11

python-requirements:
	pyenv install -s $(PYTHON_VERSION) && \
	pyenv local $(PYTHON_VERSION) && \
	python -m venv .venv && \
	. .venv/bin/activate && \
	pip install pip-tools && \
	pip-compile --resolver=backtracking -o requirements.txt requirements.in && \
	pip install -r requirements.txt
