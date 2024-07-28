FROM golang:1.22.5 as base
WORKDIR /app
COPY main.go .
RUN go mod download
COPY . .
RUN go build -o main .

# distroless image or runtime image
FROM gcr.io/distroless/base
COPY --from=base /app/main .
COPY --from=base /app/static ./static
EXPOSE 8080
CMD ["./main"]
