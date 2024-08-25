package mail

import (
	"fmt"
	"io"
	"os"
	"text/template"

	"github.com/go-mail/mail"
)

type SendMailOptions struct {
	To       string
	Subject  string
	Template string
	Data     any
}

func SendMail(o SendMailOptions) error {
	m := mail.NewMessage()
	m.SetAddressHeader("From", os.Getenv("EMAIL_ADDRES"), "Family budget")
	m.SetHeader("To", o.To)
	m.SetHeader("Subject", o.Subject)

	html, err := template.ParseFiles(fmt.Sprintf("mail/templates/%v.html", o.Template))

	if err != nil {
		return err
	}

	m.SetBodyWriter("text/html", func(w io.Writer) error {
		return html.Execute(w, o.Data)
	})

	d := mail.NewDialer(os.Getenv("EMAIL_HOST"), 587, os.Getenv("EMAIL_ADDRES"), os.Getenv("EMAIL_PASS"))

	return d.DialAndSend(m)
}
