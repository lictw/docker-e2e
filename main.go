package main

import (
	"fmt"
	"log"
	"net/http"

	"html/template"

	"io/ioutil"

	"github.com/caarlos0/env"
	"github.com/go-redis/redis"
)

var (
	err           error
	indexTemplate *template.Template
	redisClient   *redis.Client
)

type Config struct {
	Port      int    `env:"PORT" envDefault:"1337"`
	RedisHost string `env:"REDIS_HOST" envDefault:"localhost"`
	RedisPort int    `env:"REDIS_PORT" envDefault:"6379"`
}

func main() {

	// Parse environment variables:
	var config Config
	if err := env.Parse(&config); err != nil {
		log.Fatalln(err)
	}

	// Read and parse index template:
	var data []byte
	if data, err = ioutil.ReadFile("index.html"); err != nil {
		log.Fatalln(err)
	}
	if indexTemplate, err = template.New("index").Parse(string(data)); err != nil {
		log.Fatalln(err)
	}

	// Connect to Redis and check connection:
	redisClient = redis.NewClient(&redis.Options{
		Addr: fmt.Sprint(config.RedisHost, ":", config.RedisPort),
	})
	if err = redisClient.Ping().Err(); err != nil {
		log.Fatalln(err)
	}

	// Start HTTP server:
	address := fmt.Sprint(":", config.Port)
	http.HandleFunc("/", handler)
	log.Println("starting listening on " + address)
	if err = http.ListenAndServe(address, nil); err != nil && err != http.ErrServerClosed {
		log.Fatalln(err)
	}
}

func handler(w http.ResponseWriter, r *http.Request) {

	// Create structure for template:
	data := struct {
		Key   string
		Value string
	}{}

	// Read value of requested key and fill template's structure when GET button pressed
	// and set/update key-value pair when SET button pressed:
	if r.Method == "POST" {
		if err := r.ParseForm(); err == nil {
			var value string
			key := r.FormValue("key")
			action := r.FormValue("action")
			if action == "GET" && key != "" {
				if value, err = redisClient.Get(key).Result(); err == nil {
					data.Key = key
					data.Value = value
				}
			} else {
				value = r.FormValue("value")
				if action == "SET" && key != "" && value != "" {
					redisClient.Set(key, value, 0)
				}
			}
		}
	}

	// Template renders always, but in most cases page will have empty fields:
	indexTemplate.Execute(w, data)
}
