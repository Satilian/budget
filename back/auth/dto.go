package auth

type SignupDto struct {
	Email string `from:"email"`
	Login string `from:"login"`
	Pass  string `from:"pass"`
}
