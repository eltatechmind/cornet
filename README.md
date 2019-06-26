## Cornet
- This is the task for Cornet Elevated Company
## Registration, Authentication, Authorization
- All is done using a mix of famous devise gem + devise_token_auth gem (since we are talking about a rails api here, so devise is not enough )
- creating many endpoints for signup (in which you register a new user account using email account, password, password_confirmation), signin (you post your email and password, and get auth_token, uid,client back from the request), 
- you use them then to call any endpoint of the other models by add those 3 tokens as headers to postman, and you have to login, else you either get no result from the endpoint or you get a notification "you need to login or signup".
- when you are logged in, you are scoped only to your records that belongs to your user account, you can't display,delete, update, etc records of other users.
- to learn how to use devise_auth_token 
here's a tutorial: https://dev.to/risafj/guide-to-devisetokenauth-simple-authentication-in-rails-api-pfj
or check my older tutorial with photos for a task I finished earlier for another company in readme file: https://github.com/Elta3lab/skolera
- login with facebook can be implemented only on rails web application, not rails api, the idea of logging by facebook, is logging to facebook, and use the email and password of FB to create a new user on the web application, which is done directly through the /auth (signup endpoint) and sending the registration data
- if it was a rails web application, I would use this tutorial for facebook login https://medium.com/@chinnatiptaemkaeo/integrate-omniauth-facebook-to-rails-5-1389d760d92a

## Models
- a user model created using devise, which in relation one to many with project model, which then in one to many with tak model, which is in one to many with commment model
- although user and Project are meant to be nested routes, I created them with separated endpoints, to nested routes of 3 or more levels, so that end points don't look ugly, or having to use graphql to avoid missing the task deadline
- project model has only name of the project
- the task and comment models are nested
- in task model, there's a plevel column, which is used for priority, it's integer column, you can set it either to 1 or 2 or 3 which are our 3 levels of priority for tasks, one is the strongest one
- there's a boolean column called "done" in task model, when creating a new task, the done column is set by default to false, when complete the task you can update it to be true to mark the task as done
- there's a column of datetime type too in task model, which is for the deadline of the task
- the comment model has only content column, for the content of the comment
- indexing is used when setting any one to many relations between any 2 models on database level seeking speed
- model validation is also included, for name, which must present, be unique, and with minimum and maximum number of letters

## Fast Json API

- all responses come with data in fast_json_api gem format, which is much faster, return data with related records from other models, fast_json_api is used by majority of companies working on ruby on rails apis
- for this I created serializers for models project, task, comment

## Rspecs
- Rspecs are created fully for all models
- Request specs are designed to drive behavior through the full stack, including routing. This means they can hit the applications' HTTP endpoints as opposed to controller specs which call methods directly. 
- Since I'm building an API application, this is exactly the kind of behavior I want from tests.
- According to RSpec, the official recommendation of the Rails team and the RSpec core team is to write request specs instead, that's why I'm using requests rspecs instead of controller specs
- Request specs are created for models endpoints, covering most of the scenarios, calling endpoints without login, login and calling endpoints, entering non existing data, trying to access other users data, and more.
- for sure we used factories for testing, created for all models needed, database cleaner gem for database after every spec
, and faker gem for creating dummy data for our factories.

## Importing CSV Files

- for importing csv files records into our web api database, I created a model called Mycsv, which is in a many to one relation with user model.
- since we can't send csv file as a parameter in postman, the csv file will be hosted on amazon aws first, for me I used Dropbox which is free, I uploaded the file there, then I downloaded the file through chrome, copy the download link, then visit the /csvfiles endpoint from postman while sending param of key "url" and value "the download link", this will start importing the csv file content into our Mycsv model, each row in the csv file as a record, and every record will have a user_id column too which show this record was imported by which user (according to which user was logging in when he was importing the file)
- the Mycsv model has no endpoints to call, or controller for sure, as these files are being imported to the database from the csv files.
- the Mycsv model consists of two columns, "first" and "second", you can rename them according to the need of the data being stored in the model

## Exception Handling

- a file was created for handling exceptions

## Future (if there was more time)
- I would add rubocop
- I would get the api on production
- I would connect my rails api to rollbar for catching production errors
- I would use graphql and implementing it from scratch for the first time
- I would create a background service

-- Thanks, feel free to send me any question about the api --




