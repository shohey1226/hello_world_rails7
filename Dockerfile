FROM ruby:3.1.2
RUN apt-get update -qq && apt-get install -y build-essential postgresql-client

#RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash -
#RUN apt-get install -y nodejs
#RUN npm install -g yarn@1.22

WORKDIR /app

#COPY package.json yarn.lock /app/ 
#RUN yarn install

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install

COPY . /app/

# Add a script to be executed every time the container starts.
COPY scripts/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
