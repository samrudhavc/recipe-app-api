FROM python:3.11-alpine3.21
LABEL maintainer="samrudhavc.com"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip &&\
    /py/bin/pip install -r/tmp/requirements.txt &&\
    /py/bin/pip install -r /tmp/requirements.dev.txt ; \
    rm -rf /tmp &&\
    adduser \
        --disabled-password \
        --no-create-home \ 
        django-user

ENV PATH="/py/bin:$PATH"

USER django-user
# Command to run the application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]