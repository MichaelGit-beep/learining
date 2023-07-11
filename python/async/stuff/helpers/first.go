package helpers

const localhelp = "I told you so"

func WillHelpYou() string {
	return localhelp
}

func Evaluate(i string, j string) bool {
	return i == j
}
