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
- for this I created serializers for model projects, tasks, comments



