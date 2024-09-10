#!/bin/bash

project_name=$1
shift
app_names=("$@")

# Step 1: Add "core" to the list of app names
app_names=("core" "${app_names[@]}")

# Step 2: Create the Django project
source .venv/bin/activate
django-admin startproject ${project_name}

# Step 3: Copy essential files to the project folder

cp project_app_files/* ${project_name}/${project_name}/
cp project_files/* ${project_name}/
mkdir -p ${project_name}/static/css
cp tailwind_input.css ${project_name}/static/css/

celery_file_template="celery.py"
celery_destination="${project_name}/${project_name}/celery.py"

# Replace PROJECT_NAME with actual project name and write to destination
sed "s/PROJECT_NAME/${project_name}/g" "$celery_file_template" > "$celery_destination"


mkdir ${project_name}/secrets
cp local.env ${project_name}/secrets/

cd ${project_name}/


# Step 4: Create Django apps specified in the argument list
for app in "${app_names[@]}"; do
    python manage.py startapp $app
    mkdir -p ${app}/templates/${app} ${app}/static/${app}/css
done

# Step 5: Add apps to INSTALLED_APPS in settings.py and update env import
settings_file="${project_name}/settings.py"

for app in "${app_names[@]}"; do
    sed -i "/INSTALLED_APPS = \[/ a\    '${app}'," ${settings_file}
done

# Add the header content at the top of settings.py
settings_header="../settings_header_lines.txt" 
# Remove the first 16 lines of settings.py
sed -i '1,16d' "$settings_file"
cat "$settings_header" | cat - "$settings_file" > temp && mv temp "$settings_file"


# Step 6: Install Python dependencies
make python-requirements

make migrate
