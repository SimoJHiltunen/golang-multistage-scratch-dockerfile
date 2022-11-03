# step 1 - build golang app
FROM golang:1.19-alpine AS builder

# path to the source folder as an argument. 
# for default assumes the app is in an src folder and Dockerfile is in a project root.
ARG source_path=src

# Ca-certificates is required to call HTTPS endpoints.
RUN apk update && apk add --no-cache git ca-certificates tzdata && update-ca-certificates

# create a working directory inside the image
WORKDIR /app
# copy Go modules and dependencies to image
COPY ${source_path}/go.mod ./

# download Go modules and dependencies
RUN go mod download

# copy directory files i.e all files ending with .go
COPY ${source_path} ./

# compile application
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /go-app

# step 2 - create image
FROM scratch

WORKDIR /

COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /go-app /go-app

EXPOSE 8080

CMD ["/go-app"]