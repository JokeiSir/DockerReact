# base image
FROM node:12.16.1-alpine AS build

WORKDIR /app

# ########---WAY 1---##########
#ENV PATH /app/node_modules/.bin:$PATH
COPY package.json .
COPY package-lock.json .
RUN npm install --silent
RUN npm install react-scripts@3.4.1 -g --silent
COPY ./ ./

# start app
#CMD ["npm", "start"]
RUN npm run build

FROM nginx:1.17.9-alpine
COPY --from=build /app/build /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx/nginx.conf /etc/nginx/conf.d
#EXPOSE 80
#CMD ["nginx", "-g", "daemon off;"]



# ########---WAY 2---##########

#COPY . .
#RUN npm install react-scripts@3.4.1 -g --silent
#RUN yarn install 
#RUN yarn run build

#FROM node:12.16.1-alpine
#RUN yarn global add serve
#WORKDIR /app
#COPY --from=builder /app/build .
#CMD ["serve", "-p", "80", "-s", "."]doc
