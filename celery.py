import os
from celery import Celery

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "PROJECT_NAME.settings")

app = Celery("dag_sites")
app.config_from_object("django.conf:settings", namespace="CELERY")
app.autodiscover_tasks()
