extends Node2D

var listeDeLettres="res://les_lettres/lettres.json"
var lettresParse
var sens=0
var manche =0 
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
	print(lettresParse)
	var ListeLettres=getliste(1,lettresParse)
	var NumLettre=randomletter(ListeLettres)
	var string = "la lettre recherché, est : "
	$Label.text=string + ListeLettres[NumLettre]
	
	
func _process(delta):
	
func _on_line_edit_text_submitted(new_text):
	if (new_text==lettresParse[]):
		
	
func getliste(sens,dicListe):
	if sens==1:
		return dicListe.keys()
	elif  sens==-1:
		return dicListe.values()
	return 1

func randomletter(liste):
	return randi() % len(liste)

func isTheSame():
	pass
