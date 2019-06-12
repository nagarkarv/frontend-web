#multistage docker file

# 1st Phase - builder
FROM node:alpine as builder
WORKDIR '/usr/app/frontend'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# 2nd phase
# Copy the required files from builder to this new image, everything else throw away
# new image size is quite less in size
FROM nginx
COPY --from=builder /usr/app/frontend/build /usr/share/nginx/html

