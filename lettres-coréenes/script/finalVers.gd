extends Control


var aideVisible= false

var manche =0 #int
var point=0 #int
var PoseLettre #int

var listeDeLettres="res://les_lettres/lettres.json" #string

var lettresParse #dictionnaire
var ListeLettres #liste
 
var lettre_a_trouver # char
var lettrePropo #char
var oldLetter #char


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
	lettresParse = chargement_Json(listeDeLettres)# chargement du dictionnaire des lettres avec leur corresponcances 
	ListeLettres=getliste(1,lettresParse)# récupération d'une liste pour pouvoir utiliser la fonction rand pour avoir un index
	PoseLettre=randomletter(ListeLettres)# récupération d'une position de lettre random
	dicoAide()#affichage du dico d'aide
	affichage()# affichage de la lettre 
	affichagePoints()# initialisation du compteur
	afficherAide(aideVisible)
	#zone test
	
func afficherAide(boulean):
	if boulean==true:
		%Solution.set_visible(true)
		dicoAide()
	if boulean==false:
		%Solution.set_visible(false)

func dicoAide():
	%Solution.text="Solution = " +str(lettresParse [ListeLettres[PoseLettre]])


func _on_line_edit_text_submitted(new_text):
	lettrePropo=new_text
	isTheSame()
	oldLetter=lettre_a_trouver
	generation()
	if(oldLetter==lettre_a_trouver):
		generation()
	%LineEdit.text=""
	aideVisible=false
	afficherAide(aideVisible)


func getliste(sens,dicListe):
	if sens==1:
		return dicListe.keys()
	elif  sens==0:
		return dicListe.values()
	return 1

func randomletter(liste):
	return randi() % len(liste)

func affichage():
	var string = "la lettre recherché, est : "
	%Label.text=string + ListeLettres[PoseLettre]

func isTheSame():
	lettre_a_trouver= lettresParse [ListeLettres[PoseLettre]]
	if lettrePropo==lettre_a_trouver:
		manche+=1
		point+=1
		print("bonne lettre")
		print(lettrePropo," ",lettre_a_trouver)
		%mauvaiseReponse.text="la bonne réponse "
		$win.play()
	elif lettrePropo!=lettre_a_trouver:
		manche+=1
		print("mauvaise lettre")
		print(lettrePropo," ",lettre_a_trouver)
		$wrong.play()
		%mauvaiseReponse.text="la bonne lettre était: "+lettre_a_trouver
	affichagePoints()

func affichagePoints():
	var str="manche: "+str(manche)+"   "+"points: "+str(point) 
	%manchePoints.text=str

func generation():
	PoseLettre=randomletter(ListeLettres)# récupération d'une position de lettre random
	affichage()# affichage de la lettre 
	affichagePoints()# actualisation du compteur
	


func _on_aide_pressed() -> void:
	aideVisible=true
	afficherAide(aideVisible)



func _on_h_slider_value_changed(value: float) -> void:
	$wrong.volume_linear=value
	$win.volume_linear=value
	$testvol.volume_linear=value
	


func _on_h_slider_drag_ended(value_changed: bool) -> void:
	$testvol.play()


func _on_param_pressed():
	
