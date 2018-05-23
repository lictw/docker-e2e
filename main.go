package main

import (
	"io/ioutil"
	"net/http"
    "log"
    "os"
)

var (
	err  error
	page []byte
)

func main() {

    port := os.Getenv("PORT")
    if port == "" {
        port = "1337"
    }

	if page, err = ioutil.ReadFile("index.html"); err != nil {
        log.Fatalln(err)
	}

	address := ":" + port
	http.HandleFunc("/", handler)
	log.Println("starting listening on " + address)
	if err = http.ListenAndServe(address, nil); err != nil && err != http.ErrServerClosed {
	    log.Fatalln(err)
    }
}

func handler(w http.ResponseWriter, r *http.Request) {
    w.Write(page)
}
