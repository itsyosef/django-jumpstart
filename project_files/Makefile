PYTHON_VERSION := 3.11
PROJECT_NAME := 

# Set Fly App Names
PROD_APP_NAME := 
DEV_APP_NAME := 

start-celery:
	. .venv/bin/activate && \
	celery -A $(PROJECT_NAME) worker --loglevel=debug

run:
	. .venv/bin/activate && \
	python manage.py runserver 

python-requirements:
	pyenv install -s $(PYTHON_VERSION) && \
	pyenv local $(PYTHON_VERSION) && \
	python -m venv .venv && \
	. .venv/bin/activate && \
	pip install pip-tools && \
	pip-compile --resolver=backtracking -o requirements-dev.txt requirements-dev.in && \
	pip-compile --resolver=backtracking -o requirements.txt requirements.in && \
	pip install -r requirements-dev.txt

migrate:
	. .venv/bin/activate && \
	python manage.py makemigrations $(PROJECT_NAME) && \
	python manage.py migrate

createsuperuser:
	. .venv/bin/activate && \
	python manage.py createsuperuser

tailwind:
	. .venv/bin/activate && \
	tailwindcss -i static/css/tailwind_input.css -o static/css/tailwind_output.css --watch --minify

check-docker-context:
	rsync -avnh . /dev/shm --exclude-from .dockerignore

# Deploy to Production
deploy-prod:
	./set_commit_hash_env_var.sh secrets/prod.env
	flyctl secrets import --app $(PROD_APP_NAME) < secrets/prod.env
	flyctl deploy --app $(PROD_APP_NAME) -c fly-prod.toml

# Deploy to Development
deploy-dev:	
	./set_commit_hash_env_var.sh secrets/dev.env
	flyctl secrets import --app $(DEV_APP_NAME) < secrets/dev.env
	flyctl deploy --app $(DEV_APP_NAME) -c fly-dev.toml

connect-to-dev:
	fly ssh console -a $(DEV_APP_NAME)

connect-to-prod:
	fly ssh console -a $(PROD_APP_NAME)
