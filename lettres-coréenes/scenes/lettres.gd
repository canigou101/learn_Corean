extends Node2D

var listeDeLettres="res://les_lettres/lettres.json"
var lettresParse
var sens=0
#lecteur de dialogue 
func chargement_Json(file_path):
	if FileAccess.file_exists(file_path):
		var dataFile =FileAccess.open(file_path,FileAccess.READ)
		
		var resultat_parse = JSON.parse_string(dataFile.get_as_text())
		
		if resultat_parse is Dictionary:
			return resultat_parse
		else:
			print("erreur à la lecture")
	else: 
		print("le fichier n'existe pas")


func _ready():
	lettresParse = chargement_Json(listeDeLettres)
	
	
func _on_line_edit_text_submitted(new_text):
	pass
	
func getliste(sens):
	if sens==1:
		var liste_de_lettres=[]
		for i in lettresParse.keys():
			liste_de_lettres.append(i)
			return liste_de_lettres
	elif  sens==-1:
		var liste_de_lettres=[]
		for i in lettresParse.value():
			liste_de_lettres.append(i)
			return liste_de_lettres
	return 1

func randomletter(liste):
	return randi() % len(liste)

func isTheSame():
	pass
