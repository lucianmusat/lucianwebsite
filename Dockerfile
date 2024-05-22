FROM python:3.10

COPY nginx/conf/nginx.conf /etc/nginx/conf.d/default.conf
COPY nginx/conf/website.conf /etc/nginx/sites-available/
COPY nginx/conf/mancala.conf /etc/nginx/sites-available/
COPY nginx/conf/parastas.conf /etc/nginx/sites-available/
COPY nginx/conf/spellchecker.conf /etc/nginx/sites-available/

RUN mkdir /etc/nginx/sites-enabled

RUN ln -s /etc/nginx/sites-available/website.conf /etc/nginx/sites-enabled/
RUN ln -s /etc/nginx/sites-available/mancala.conf /etc/nginx/sites-enabled/
RUN ln -s /etc/nginx/sites-available/parastas.conf /etc/nginx/sites-enabled/
RUN ln -s /etc/nginx/sites-available/spellchecker.conf /etc/nginx/sites-enabled/

RUN apt update && apt install -y nginx openssl

# RUN nginx -t && service nginx restart

WORKDIR /code

COPY ./requirements.txt /code/requirements.txt

RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

COPY ./*.py /code/

COPY ./static/ /code/static/

COPY ./templates /code/templates/

CMD ["uvicorn", "main:app", "--proxy-headers", "--host", "0.0.0.0", "--port", "8000", "--forwarded-allow-ips", "*"]
