# Bedingungen zum Schließen
- Muss zum Schließen eines Fensters eine Bedingung erfüllt werden?
- Soll vor dem Schließen eines Fensters ein Vorgang angestoßen werden?

Durch überschreiben der Methode "isCloseable", der JFXSceneController-Klasse, kann beides bewerkstelligt werden. Die Methode wird vor dem Schließen des Fensters ausgeführt und erlaubt, in ihrem Body, das Prüfen einer Bedingung oder das Anstpßen eines Vorgangs. Liefert "isCloseable" true an den Aufrufer zurück, so wird das Fenster geschlossen, andernfalls bleibt das Fenster offen.
