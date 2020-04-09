# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
def end_of_seed
	puts "\n Success!"
end

def check(item)
	if item.save
		item.succeed
	else
		item.failed
	end
end

def create_language(language=[])
	l = Language.new(name: language[0], code: language[1])
	if check(l)
		return l
	end
end

def create_type(name)
	type = {name: name}
	t = Type.new(type)
	if check(t)
		return t
	end
end

def create_activity(name)
	activity = {name: name}
	a = Activity.new(activity)
	if check(a)
		return a
	end
end

def create_super_admin(super_admin=[])
	s = User.new(
		email: super_admin[0],
		password: super_admin[1],
		password_confirmation: super_admin[1],
		firstname: super_admin[2],
		lastname: super_admin[3],
		language: super_admin[4],
		birthdate: super_admin[5],
		address: super_admin[6],
		gender: super_admin[7],
		role: super_admin[8],
		super_admin: super_admin[9]
	)
	s.skip_confirmation!
	s.confirm
	if check(s)
		return s
	end
end

def create_admin(admin=[])
	a = User.new(
		email: admin[0],
		password: admin[1],
		password_confirmation: admin[1],
		firstname: admin[2],
		lastname: admin[3],
		language: admin[4],
		birthdate: admin[5],
		address: admin[6],
		gender: admin[7],
		role: 'admin',
		admin: true
	)
	a.skip_confirmation!
	a.confirm
	if check(a)
		return a
	end
end

def create_space(space=[])
	admin = User.find(space[0])
	s = Space.new(
		admin_id: space[0],
		name: space[1],
		description: space[2]
	)
	if check(s)
		if space[3]
			add_cover_picture(s, space[3])
		end
		admin.visited_spaces = [s]
		return s
	end
end

def create_user(user=[])
	u = User.new(
		email: user[0],
		password: user[1],
		password_confirmation: user[1],
		firstname: user[2],
		lastname: user[3],
		birthdate: user[4],
		address:  user[5],
		gender: user[6],
		language_id: user[7]
	)
	if check(u)
		u.visited_spaces << Space.where(private: false)
		return u
	end
end

def add_cover_picture(item, cover_picture)
	if item.cover_picture.attach(cover_picture)
		item.succeed
	else
		item.failed
	end
end

def create_idea(idea=[])
	admin = User.find(idea[0])
	space = admin.created_space
	i = Idea.new(
		admin_id: admin.id,
		space_id: space.id,
		type_id: idea[2],
		name: idea[3],
		description: idea[4],
		ready: idea[5]
	)
	if check(i)
		add_cover_picture(i, idea[6])
		return i
	end
end

def create_project(project=[])
	admin = User.find(project[0])
	space = admin.created_space
	i = Project.new(
		admin_id: admin.id,
		space_id: space.id,
		type_id: project[1],
		name: project[2],
		description: project[3],
		deadline: project[4],
		ready: project[5]
	)
	if check(i)
		add_cover_picture(i, project[6])
		return i
	end
end


def create_call_for_idea(call_for_idea=[])
	project = Project.find(call_for_idea[0])
	c = CallForIdea.new(
		project_id: call_for_idea[0],
		name: call_for_idea[1],
		description: call_for_idea[2],
		type_id: project.type.id
	)
	if check(c)
		add_cover_picture(c, call_for_idea[3])
		return c
	end
end

def create_actuality(actuality=[])
	admin = User.find(actuality[0])
	space = admin.created_space
	a = Actuality.new(
		admin_id: admin.id,
		space_id: space.id,
		name: actuality[1],
		description: actuality[2]
	)
	if check(a)
		return a
	end
end

def create_survey(survey=[])
	admin = User.find(survey[0])
	space = admin.created_space
	s = Survey.new(
		admin_id: admin.id,
		space_id: space.id,
		name: survey[1],
		description: survey[2],
		type_id: survey[3],
		end_date:  survey[4],
		ready: survey[5]
	)
	if check(s)
		add_cover_picture(s, survey[6])
		return s
	end
end

def create_question(question=[])
	q = Question.new(
		survey_id: question[0],
		name: question[1]
	)
	if check(q)
		return q
	end
end

def create_option(option=[])
	o = Option.new(
		question_id: option[0],
		name: option[1]
	)
	if check(o)
		return o
	end
end

def create_languages
	languages = [
		['Malagasy', "mg"],
		['English', "en"],
		['Français', "fr"]
	]

	puts "\nCreating Languages"
	languages.each do |language|
		create_language(language)
	end
	@mg = Language.find_by(code: 'mg')
	@fr = Language.find_by(code: 'fr')
	@en = Language.find_by(code: 'en')
end

def create_types
	types = [
		'Affaires étrangères',
		"Développement et construction",
		'Commerces et marchés',
		"Culture, arts et patrimoine",
		'Education, jeunesse et petite enfance',
		'Emploi',
		"Environnement et développement durable",
		'Logement',
		'Numérique',
		'Propreté',
		"Réseaux, énergie et éclairage",
		'Sécurité',
		'Solidarité, social et santé',
		'Sports et loisirs',
		'Transport et déplacement',
		"Travaux et routes",
		'Union européenne',
		'Vie institutionnelle et administrative'
	]
	puts "\nCreating Types"
	types.each do |type|
		create_type(type)
	end
end

def create_activities
	activities = [
		'Student',
		'Employee',
		'Jobless',
		'Retired person',
		'Other'
	]
	puts "\nCreating Activities"
	activities.each do |activity|
		create_activity(activity)
	end
end

def create_super_admins
	super_admins = [
		['plinsy2@gmail.com', 'Lins#01111998', 'Princy', 'A.N.Tsimanarson', @en, DateTime.parse("01 November 1998"), 'Lot FMAI 124 bis 67ha SUD', 'male', 'super-admin', true]
	]

	puts "\nCreating SuperAdmins"
	super_admins.each do |super_admin|
		create_super_admin(super_admin)
	end
	@linx = User.find_by(email: 'plinsy2@gmail.com')
end

def create_admins
	admins = [
		["sayna.staff@gmail.com", "sayna123456", "Sayna", "Staff", @fr, DateTime.parse("01 Janvier 2017"), "La city Ivandry", "female"],
		["plinsy2@gmail.com", "Ivato123456", "Ivato", "Ivato", @fr, DateTime.parse("01 Novembre 1998"), "Ivato", "female"],
		["plinsy2@gmail.com", "Ambohibao123456", "Ambohibao", "Ambohibao", @fr, DateTime.parse("01 Novembre 1998"), "Ambohibao", "female"],
		["plinsy2@gmail.com", "Talatamaty123456", "Talatamaty", "Talatamaty", @fr, DateTime.parse("01 Novembre 1998"), "Talatamaty", "female"],
		["plinsy2@gmail.com", "Andranonahoatra123456", "Andranonahoatra", "Andranonahoatra", @fr, DateTime.parse("01 Novembre 1998"), "Andranonahoatra", "female"],
		["plinsy2@gmail.com", "Itaosy123456", "Itaosy", "Itaosy", @fr, DateTime.parse("01 Novembre 1998"), "Itaosy", "female"],
		["plinsy2@gmail.com", "Anosizato123456", "Anosizato", "Anosizato", @fr, DateTime.parse("01 Novembre 1998"), "Anosizato", "female"],
		["plinsy2@gmail.com", "Andoaranofotsy123456", "Andoaranofotsy", "Andoaranofotsy", @fr, DateTime.parse("01 Novembre 1998"), "Andoaranofotsy", "female"],
		["plinsy2@gmail.com", "Tanjombato123456", "Tanjombato", "Tanjombato", @fr, DateTime.parse("01 Novembre 1998"), "Tanjombato", "female"],
		["plinsy2@gmail.com", "Ilafy123456", "Ilafy", "Ilafy", @fr, DateTime.parse("01 Novembre 1998"), "Ilafy", "female"],
		["plinsy2@gmail.com", "Ankaraobato123456", "Ankaraobato", "Ankaraobato", @fr, DateTime.parse("01 Novembre 1998"), "Ankaraobato", "female"],
		["plinsy2@gmail.com", "Analakely123456", "Analakely", "Analakely", @fr, DateTime.parse("01 Novembre 1998"), "Analakely", "female"],
		["plinsy2@gmail.com", "Antaninandro123456", "Antaninandro", "Antaninandro", @fr, DateTime.parse("01 Novembre 1998"), "Antaninandro", "female"],
		["plinsy2@gmail.com", "Ambanidia123456", "Ambanidia", "Ambanidia", @fr, DateTime.parse("01 Novembre 1998"), "Ambanidia", "female"],
		["plinsy2@gmail.com", "Mahamasina123456", "Mahamasina", "Mahamasina", @fr, DateTime.parse("01 Novembre 1998"), "Mahamasina", "female"],
		["plinsy2@gmail.com", "Ambatomaity123456", "Ambatomaity", "Ambatomaity", @fr, DateTime.parse("01 Novembre 1998"), "Ambatomaity", "female"],
		["plinsy2@gmail.com", "Ambohimanarina123456", "Ambohimanarina", "Ambohimanarina", @fr, DateTime.parse("01 Novembre 1998"), "Ambohimanarina", "female"]
	]
	puts "\nCreating Admins"
	admins.each do |admin|
		create_admin(admin)
	end
	@sayna = User.find_by(email: 'sayna.staff@gmail.com')
	@ivato = User.find_by(email: 'ivato@gmail.com')
	@ambohibao = User.find_by(email: 'ambohibao@gmail.com')
	@talatamaty = User.find_by(email: 'talatamaty@gmail.com')
	@andranonahoatra = User.find_by(email: 'andranonahoatra@gmail.com')
	@itaosy = User.find_by(email: 'itaosy@gmail.com')
	@anosizato = User.find_by(email: 'anosizato@gmail.com')
	@andoaranofotsy = User.find_by(email: 'andoaranofotsy@gmail.com')
	@tanjombato = User.find_by(email: 'tanjombato@gmail.com')
	@ilafy = User.find_by(email: 'ilafy@gmail.com')
	@ankaraobato = User.find_by(email: 'ankaraobato@gmail.com')
	@analakely = User.find_by(email: 'analakely@gmail.com')
	@antaninandro = User.find_by(email: 'antaninandro@gmail.com')
	@ambanidia = User.find_by(email: 'ambanidia@gmail.com')
	@mahamasina = User.find_by(email: 'mahamasina@gmail.com')
	@ambatomainty = User.find_by(email: 'ambatomainty@gmail.com')
	@ambohimanarina = User.find_by(email: 'ambohimanarina@gmail.com')
end

def create_spaces
	spaces = [
		[@sayna.id, "C.U.A", "Commune Urbaine d'Antananarivo"],
		[@linx.id, "Izara", "Tout ce que vous postez ici sera directement vue par les administrateurs de Zarao et pourrons être pris en compte pour d'éventuels mise à jour, donc lachez-vous! Il n'y a pas de mauvaise idée!"],
		[@linx.id, "Ivato", "Ivato  est une commune urbaine située dans la Province d'Antananarivo, au centre de Madagascar. Elle se trouve à 15 km au Nord-Ouest d'Antananarivo, accueillant sur son territoire l'aéroport international d'Ivato, l'aéroport de la capitale. Elle appartient au district d'Ambohidratrimo. ", {io: File.open(Rails.root.join('app', 'assets', 'images', 'ville' , 'ivato.jpg')), filename: 'ivato.jpg', content_type: 'image/jpg'}],
		[@linx.id, "Ambohibao", "Ambohibao est une petite ville située dans la commune d'Antehiroka, district d'Ambohidratrimo, à Antananarivo la capitale de Madagascar. Elle se situe sur la Route nationale N°4 reliant Antananarivo et Mahajanga.", {io: File.open(Rails.root.join('app', 'assets', 'images', 'ville' , 'Ambohibao.jpg')), filename: 'Ambohibao.jpg', content_type: 'image/jpg'}],
		[@linx.id, "Talatamaty", "Talatamaty est une petite commune située dans le district d'Ambohidratrimo, dans la région d'Analamanga, elle-même comprise au sein de la province d'Antananarivo à Madagascar.", {io: File.open(Rails.root.join('app', 'assets', 'images', 'ville' , 'talatamaty.jpg')), filename: 'talatamaty.jpg', content_type: 'image/jpg'}],
		[@linx.id, "Andranonahoatra", "Talatamaty est une petite commune située dans le district d'Ambohidratrimo, dans la région d'Analamanga, elle-même comprise au sein de la province d'Antananarivo à Madagascar.", {io: File.open(Rails.root.join('app', 'assets', 'images', 'ville' , 'andranonahoatra.jpg')), filename: 'andranonahoatra.jpg', content_type: 'image/jpg'}],
		[@linx.id, "Itaosy", "Itaosy est une commune du district d'Atsimondrano , dans la région d'Analamanga . La population est 40701 selon le recensement de 2000. La municipalité est 11703 et le code de district est 117.", {io: File.open(Rails.root.join('app', 'assets', 'images', 'ville' , 'itaosy.jpeg')), filename: 'itaosy.jpeg', content_type: 'image/jpeg'}],
		[@linx.id, "Anosizato", "Anosizato  était la plaine de Betsimitatatra. Actuellement, c’est devenu un grand quartier. De grandes maisons, des usines, de grandes entreprises et des espaces y sont construites.", {io: File.open(Rails.root.join('app', 'assets', 'images', 'ville' , 'anosizato.jpg')), filename: 'anosizato.jpg', content_type: 'image/jpg'}],
		[@linx.id, "Andoaranofotsy", " Andoaranofotsy est un district de Madagascar, situé dans la partie est de la province d'Antananarivo, dans la région d'Analamanga.", {io: File.open(Rails.root.join('app', 'assets', 'images', 'ville' , 'andoaranofotsy.jpg')), filename: 'andoaranofotsy.jpg', content_type: 'image/jpg'}],
		[@linx.id, "Tanjombato", " Tanjombato est une commune du district d' Antsanondo Atsimondrano . La population est 31401 selon le recensement de 2000. La municipalité est 11715 et le code de district est 117.", {io: File.open(Rails.root.join('app', 'assets', 'images', 'ville' , 'tanjombato.jpg')), filename: 'tanjombato.jpg', content_type: 'image/jpg'}],
		[@linx.id, "Ilafy", "Ankadikely Ilafy est une commune rurale malgache, située dans le district d'Antananarivo Avaradrano de la partie centrale de la région d'Analamanga1. ", {io: File.open(Rails.root.join('app', 'assets', 'images', 'ville' , 'Ilafy.jpg')), filename: 'Ilafy.jpg', content_type: 'image/jpg'}],
		[@linx.id, "Ankaraobato", "Ankaraobato est une commune urbaine malgache située dans la partie centre de la région de Boeny. ", {io: File.open(Rails.root.join('app', 'assets', 'images', 'ville' , 'ankaraobato.jpg')), filename: 'ankaraobato.jpg', content_type: 'image/jpg'}],
		[@linx.id, "Analakely", "Lieu emblématique d’Antananarivo, Analakely est depuis toujours un endroit de rendez-vous de toute la population malgache. La « petite forêt » regroupe tous les marchands des quatre coins de la ville. ", {io: File.open(Rails.root.join('app', 'assets', 'images', 'ville' , 'Analakely.jpg')), filename: 'Analakely.jpg', content_type: 'image/jpg'}],
		[@linx.id, "Antaninandro", "Antaninandro est situé dans la région Antananarivo en Madagascar! ", {io: File.open(Rails.root.join('app', 'assets', 'images', 'ville' , 'Antaninandro.jpg')), filename: 'Antaninandro.jpg', content_type: 'image/jpg'}],
		[@linx.id, "Ambanidia", "Ambanidia est situé dans la région Antananarivo en Madagascar! ", {io: File.open(Rails.root.join('app', 'assets', 'images', 'ville' , 'ambanidia.jpg')), filename: 'ambanidia.jpg', content_type: 'image/jpg'}],
		[@linx.id, "Mahamasina", "Mahamasina est situé dans la région Antananarivo en Madagascar! ", {io: File.open(Rails.root.join('app', 'assets', 'images', 'ville' , 'Mahamasina.jpg')), filename: 'Mahamasina.jpg', content_type: 'image/jpg'}],
		[@linx.id, "Ambatomaity", "Ambatomaity est situé dans la région Antananarivo en Madagascar! ", {io: File.open(Rails.root.join('app', 'assets', 'images', 'ville' , 'ambatomainty.gif')), filename: 'ambatomainty.gif', content_type: 'image/gif'}],
		[@linx.id, "Ambohimanarina", "Ambohimanarina est situé dans la région Antananarivo en Madagascar! ", {io: File.open(Rails.root.join('app', 'assets', 'images', 'ville' , 'ambomanarina.jpg')), filename: 'ambomanarina.jpg', content_type: 'image/jpg'}]
	]
	puts "\nCreating Spaces"
	spaces.each do |space|
		create_space(space)
	end
	@cua = Space.find_by(name: "C.U.A")
	@izara = Space.find_by(name: "Izara")
	@izara.update(private: true)
end

def create_users
	users = []
	25.times do |n|
		gender = n.even? ? "female" : "male"
		firstname = Faker::Name.first_name
		lastname = Faker::Name.last_name
		email = "#{firstname}.#{lastname}@yopmail.com"
		users << [email, "000000", firstname, lastname, DateTime.now, Faker::Address.full_address, gender, @fr.id]
	end
	puts "\nCreating Users"
	users.each do |user|
		create_user(user)
	end
end

def create_ideas
	ideas = [
		[@sayna.id, @cua.id, 15, "Embouteillages monstres", "Les embouteillages monstres minent la vie quotidienne des Tananariviens. Ils sapent leur organisation, mettent leurs nerfs à rude épreuve tout en polluant l’environnement et en aggravant l’état des routes. La solution est, entre autres, de chercher du côté de la planification urbaine. Jérôme Chenal. Lors de la « Nuit des Idées 2018 » – consacrée à l’Urbanisme et poétiquement intitulée « Dessine-moi une ville…Utopies réelles pour une ville habitable »-, organisée à l’Institut français de Madagascar (IFM) jeudi 25 janvier dernier, l’intervention aussi bien sarcastique que pertinente d’un jeune architecte et urbaniste suisse fut unanimement appréciée. Jérôme Chenal, car c’est son nom, a époustouflé la salle durant toute sa présentation. Il a entre autres, au fil de sa présentation, présenté des solutions simples pour désengorger les artères d’Antananarivo. Il s’agit de solutions pragmatiques qui n’engagent pas des dépenses budgétaires mirobolantes, souvent prétextées pour expliquer l’état statique de délabrement des routes. Simples et pragmatiques. Il a ainsi proposé de : « Commencer avec ce qu’il y a et non pas se ruer vers la construction d’infrastructures qui au final, ne servent pas tout à fait l’intérêt des usagers  ». Effectivement, Tana ne pourra être autrement que « comme Tana ». Nous pouvons alors commencer par des choses simples, comme : « Consacrer la nuit pour la réfection des routes – comme cela se fait à Lausanne (Suisse) et non la journée pour générer un trafic supplémentaire, mettre une route en sens unique et une autre à double sens. Instaurer et négliger le respect strict des stationnements. Exiger le civisme dans les transports en commun, notamment de la part des conducteurs : sanctionner réellement ceux qui s’attardent dans les arrêts ou ceux qui embarquent des passagers hors arrêts. Et si cela ne marche vraiment pas, c’est là seulement qu’il faut songer à construire des routes, des rocades, qu’on aime bien en Afrique. » L’assistance ne s’est pas ennuyée une seule seconde en écoutant attentivement comment il a défendu sa conviction : celle de réfléchir dans le bon ordre en matière de planification urbaine. Dans le bon ordre, c’est-à-dire en partant de la base : l’être humain, l’usager qui est censé vivre agréablement dans la ville. Comme le disait si bien Lévi Strauss dans Tristes tropiques : « La ville c’est la chose humaine par excellence. ». Nous en reparlerons.", true, {io: File.open(Rails.root.join('app', 'assets', 'images', 'embouteillages.jpg')), filename: 'default-user-avatar-1.png', content_type: 'image/jpg'}],
		[@sayna.id, @cua.id, 11, "Stratégie contre l’insécurité", "Jacaranda Le TGV souhaite restaurer l’Etat de droit, préserver l’unité nationale et renforcer la solidarité entre Malgaches. Historique. C’est la qualification de l’évènement qui s’est déroulé hier au Centre de Conférences Internationales d’Ivato. C’est la première fois depuis l’indépendance qu’un prétendant à la course à la Magistrature suprême expose les tenants et aboutissants de son programme avant même d’être élu. La lutte contre l’insécurité constituant le fer de lance de son programme « Initiative pour l’Emergence de Madagascar » (IEM), Andry Rajoelina a tenu à présenter au peuple malgache les solutions dont il dispose pour éradiquer l’insécurité, aussi bien en milieu rural qu’urbain. Le candidat « numéro 13 » a dévoilé hier sa stratégie contre les attaques des « dahalo », les kidnappings, les attaques à main armée et les délinquances en tout genre. Aussi une démonstration sur écran géant de l’utilisation de drone et des puces intelligentes pour lutter contre les vols de bovidés a-t-elle marqué cette conférence de haut niveau sur la Sécurité et Défense. Faut-il rappeler que cette semaine, Andry Rajoelina a effectué une descente à Tsiroanomandidy, dans la Région Bongolava pour assister à un essai technique sur l’utilisation des drones effectué par des experts américains. « Le temps des paroles en l’air et des discours est révolu, il convient désormais de passer à l’action », a martelé Andry Rajoelina.", true, {io: File.open(Rails.root.join('app', 'assets', 'images', 'dahalo.jpg')), filename: 'default-user-avatar-1.png', content_type: 'image/jpg'}],
		[@sayna.id, @cua.id, 6, "La lutte contre la pollution : une urgence absolue", "Les automobiles de la capitale, du moins dans certaines rues, ont dû s’immobiliser et rester sur place entre 9h et 10h, hier matin. Leurs conducteurs l’ont fait plus ou moins de bonne grâce à l’occasion de la célébration de la Journée mondiale de l’environnement instaurée par les Nations-unies. L’initiative, même si elle pouvait paraître incongrue pour  certains, a permis de sensibiliser la population de la capitale au problème de la pollution générée par les engins motorisés. Cet arrêt de la circulation durant une heure était spectaculaire et il permet de pointer du doigt la dégradation du cadre de vie des Tananariviens. En tout cas, à défaut de convaincre totalement ces derniers, elle a déjà permis d’éveiller leur curiosité.", true, {io: File.open(Rails.root.join('app', 'assets', 'images', 'pollution.jpg')), filename: 'default-user-avatar-1.png', content_type: 'image/jpg'}]
	]
	puts "\nCreating Ideas"
	ideas.each do |idea|
		create_idea(idea)
	end
end

def create_projects
	projects = [
		[@sayna.id, 2, "Projet Tanamasoandro : Accueillir un dixième de la population tananarivienne", "Le titanesque projet du Président Andry Nirina Rajoelina a fait l’objet d’une étude et parait désormais réalisable, d’autant plus que celui-ci a été présenté par les responsables des projets présidentiels.Les responsables des projets présidentiels ont présenté ce jour le projet «Tanamasoandro aux responsables des ministères». Nul n’est sans savoir que le projet concerne la création d’une nouvelle ville ou d’un nouveau pôle urbain afin d’accueillir au minimum le dixième de l’accroissement de la population tananarivienne d’ici dix ans. Selon les explications de Gérard Andriamanohisoa, un des responsables du projet, des infrastructures conformes aux normes internationales y seront construites de la plus petite à celles destinées à accueillir la population. La réalisation de ce gigantesque projet contribuera également selon les premiers responsables à attirer les investisseurs à opérer dans le pays. En effet, toutes les infrastructures et les moyens dont ils auront besoin seront construits et installés dans cette future agglomération. Un vaste terrain dédié à l’extension des zones de constructions pour les industries figure dans le plan du projet indique Gérard Andriamanohisoa. «Tanamasoandro» sera implantée dans l’Atsimondrano sur une superficie de 1000 ha. Une grande avenue de 3,6 km traversera la ville par une ligne à double sens de 4 voies. 50 ha seront dédiés aux locaux des ministères ainsi que des institutions administratives. Parmi les nombreux édifices qui planeront sur la ville, une zone résidentielle sera érigée sur 200 ha avec des logements pouvant accueillir près de 200 000 habitants dont 150 ha destinés aux logements en faveur des familles de la classe moyenne, ainsi qu’aux logements sociaux attribués aux familles défavorisées.", Faker::Date.forward(days: 23), true, {io: File.open(Rails.root.join('app', 'assets', 'images', 'tanamasoandro.jpg')), filename: 'default-user-avatar-1.png', content_type: 'image/jpg'}],
		[@sayna.id, 2, "1°: La paix et la sécurité, une priorité", "Protéger nos frontières et nos ressources naturelles, lutter contre l’insécurité quotidienne, renforcer la défense de notre territoire.", Faker::Date.forward(days: 23), true, {io: File.open(Rails.root.join('app', 'assets', 'images','velirano', 'securite.jpg')), filename: 'default-user-avatar-1.png', content_type: 'image/jpg'}],
		[@sayna.id, 2, "2°: L’énergie et l’eau pour tous ", "Offrir une électricité moins chère, électrifier et raccorder tout Madagascar, apporter de l’eau potable à tous.", Faker::Date.forward(days: 23), true, {io: File.open(Rails.root.join('app', 'assets', 'images','velirano', 'energie.jpg')), filename: 'default-user-avatar-1.png', content_type: 'image/jpg'}],
		[@sayna.id, 2, "3°: La lutte contre la corruption et une justice équitable", "Zéro tolérance pour la corruption, rapprocher les services publics des citoyens, faire de chaque élu, de chaque fonctionnaire, un modèle, réformer et renforcer l’Administration judiciaire.", Faker::Date.forward(days: 23), true, {io: File.open(Rails.root.join('app', 'assets', 'images','velirano', 'corruption.jpeg')), filename: 'default-user-avatar-1.png', content_type: 'image/jpeg'}],
		[@sayna.id, 2, "4°: L’éducation et la culture pour tous ", "Garantir un système éducatif pour tous, promouvoir l’excellence, valoriser l’enseignement technique et professionnel en particulier dans les provinces, instaurer l’éducation civique et la citoyenneté.", Faker::Date.forward(days: 23), true, {io: File.open(Rails.root.join('app', 'assets', 'images','velirano', 'education.jpg')), filename: 'default-user-avatar-1.png', content_type: 'image/jpg'}],
		[@sayna.id, 2, "5°: La santé pour tous et à tout âge", " Assurer l’accès aux soins à tous, améliorer la santé mère-enfant, prévenir les maladies, réformer le système de retraite.", Faker::Date.forward(days: 23), true, {io: File.open(Rails.root.join('app', 'assets', 'images','velirano', 'sante.jpg')), filename: 'default-user-avatar-1.png', content_type: 'image/jpg'}],
		[@sayna.id, 2, "6°: L’emploi décent pour tous", "augmenter le nombre d’emplois, former et aider à trouver un emploi, renforcer les compétences nationales, créer une agence pour l’emploi.", Faker::Date.forward(days: 23), true, {io: File.open(Rails.root.join('app', 'assets', 'images','velirano', 'emploi.jpg')), filename: 'default-user-avatar-1.png', content_type: 'image/jpg'}],
		[@sayna.id, 2, "7°: L’industrialisation de Madagascar", "Soutenir l’entrepreneuriat malgache, favoriser l’investissement dans le secteur industriel, promouvoir le « Made in Madagascar ».", Faker::Date.forward(days: 23), true, {io: File.open(Rails.root.join('app', 'assets', 'images','velirano', 'industrie.jpg')), filename: 'default-user-avatar-1.png', content_type: 'image/jpg'}],
		[@sayna.id, 2, "8°: Nos femmes et nos jeunes pour l’avenir", "Tendre vers l’égalité hommes/femmes dans la société et les institutions, préparer nos jeunes à l’émergence du pays.", Faker::Date.forward(days: 23), true, {io: File.open(Rails.root.join('app', 'assets', 'images','velirano', 'avenir.jpg')), filename: 'default-user-avatar-1.png', content_type: 'image/jpg'}],
		[@sayna.id, 2, "9°: L’autosuffisance alimentaire", "Augmenter la production de riz, développer l’élevage et la production halieutique, soutenir les agriculteurs et innover dans de nouvelles productions agricoles, améliorer les capacités de production régionales.", Faker::Date.forward(days: 23), true, {io: File.open(Rails.root.join('app', 'assets', 'images','velirano', 'nouriture.jpg')), filename: 'default-user-avatar-1.png', content_type: 'image/jpg'}],
		[@sayna.id, 2, "10°: La gestion durable de nos ressources naturelles", "Encourager un tourisme durable, valoriser nos richesses minières, protéger notre faune, notre flore et notre sol, reboiser nos terres, lutter contre la destruction de notre environnement.", Faker::Date.forward(days: 23), true, {io: File.open(Rails.root.join('app', 'assets', 'images','velirano', 'renouvelable.jpg')), filename: 'default-user-avatar-1.png', content_type: 'image/jpg'}],
		[@sayna.id, 2, "11°: La modernisation de Madagascar ", "Créer des villes « nouvelles » pour soulager les grandes villes, rénover nos routes, nos ponts et nos voies ferrées. Construire des logements sociaux et faciliter le crédit au logement. Organiser et sécuriser le transport pour améliorer la circulation des biens et des personnes. Assainir l’espace public et gérer nos déchets. Mettre en place la ville numérique.", Faker::Date.forward(days: 23), true, {io: File.open(Rails.root.join('app', 'assets', 'images','velirano', 'modernisation.jpg')), filename: 'default-user-avatar-1.png', content_type: 'image/jpg'}],
		[@sayna.id, 2, "12°: L’autonomisation et la responsabilisation de nos territoires ", "Créer des pôles de développement spécialisés, impliquer les territoires dans leur développement, favoriser la coopération entre les régions, les districts et les communes.", Faker::Date.forward(days: 23), true, {io: File.open(Rails.root.join('app', 'assets', 'images','velirano', 'teritoire.jpg')), filename: 'default-user-avatar-1.png', content_type: 'image/jpg'}],
		[@sayna.id, 2, "13°: Le sport, une fierté nationale ", "Construire de nouvelles infrastructures sportives en particulier dans les provinces, intégrer nos jeunes par le sport, améliorer la santé par le sport, créer des centres et académies sportifs nationaux, octroyer des bourses sportives.", Faker::Date.forward(days: 23), true, {io: File.open(Rails.root.join('app', 'assets', 'images','velirano', 'sports.jpg')), filename: 'default-user-avatar-1.png', content_type: 'image/jpg'}]
	]
	puts "\nCreating Projects"
	projects.each do |project|
		create_project(project)
	end
	@tanamasoandro = Project.find(1)
end

def create_call_for_ideas
	call_for_ideas = [
		[@tanamasoandro.id, "LA PREMIÈRE PHASE DU PROJET DÉBUTERA BIENTÔT", "Antananarivo, 03 mai 2019 (ANTA) : La réunion  de présentation officielle et  de partage aux ministères techniques  du projet Tanà-Masoandro  s’est déroulée ce vendredi 03 mai 2019 à ‘l’immeuble annexe de la Présidence à Ambohitsirohitra Antananarivo. Les Secrétaires Généraux, les Directeurs de cabinet et les Directeurs Généraux des ministères clés  ont rehaussé de leur présence cette réunion. La nouvelle ville Tanà-Masoandro, projet phare de l’Initiative de l’Emergence de Madagascar (IEM), est née de la vision du Président de la République Andry Rajoelina dont l’objectif est de créer des opportunités  pour changer la situation actuelle de manière rapide et efficace. Ville conçue pour 350 000 habitants et bâtie sur 1000 ha, les travaux débuteront bientôt. Les travaux  commenceront par le remblai et la viabilisation de la première plateforme (aménagements voiries et réseaux divers). Les premières infrastructures attendues seront le pont et plateforme d’échange et parking relais à l’entrée de la ville, la principale place  publique   Madagascar et de l’Afrique, la sphère ministérielle de la zone administrative, les hôtels internationaux, le centre de conférences  et  le palais des expositions  internationaux, l’Académie Nationale des Sports de haut niveau avec un ARENA, les premières plateformes industrielles et une partie de services et commerce. La première phase du projet se fera sur peu moins de 300m2 sur la rive gauche de la rivière d’Ikopa (Ambohitrimanjaka, Ambohidrapeto), pour une durée estimative de 2 ans , a indiqué l’Expert principal Tanà-Masoandro et Conseiller du Président de la République Gérard Andriamanohisoa. Le mécanisme de financement de ce projet est basé sur plusieurs modèles de partenariat financier innovant entre l’Etat et le privé. L’aménagement du bord de la mer de Toamasina  à l’instar de celui de Miami qui commencera aussi très prochainement, a été aussi présenté à cette réunion. Tanà-Masoandro sera une vitrine de l’Océan Indien et de l’Afrique de l’Est", {io: File.open(Rails.root.join('app', 'assets', 'images', 'project-tanamasoandro.jpg')), filename: 'default-user-avatar-1.png', content_type: 'image/jpg'}],
		[@tanamasoandro.id, "A qui profiterait réellement le projet Tanamasoandro ?", "Le programme du Président de la République Andry Rajoelina comporte la construction de plusieurs « villes nouvelles », dont le projet Tanamasoandro (signifiant « rayons de soleil » ou « Antananarivo-soleil »). Ce projet, le premier d’une longue série, est destiné à désengorger la capitale Antananarivo. Des habitants, notamment des cultivateurs et paysans dont les rizières vont être remblayées, vont être expropriés et protestent pour défendre leurs droits de continuer à exploiter ces terres agricoles. En réponse à leurs manifestations, les décideurs annoncent le démarrage imminent et la réalisation inéluctable du projet. En tant que lanceurs d’alerte et défenseurs des droits économiques, sociaux et culturels de la population, le CRAAD-OI et le Collectif TANY tiennent à exprimer leurs points de vue sur les informations partagées dans le domaine public et sur les conséquences déjà notables sur les habitants des espaces concernés par le projet. Les éléments clairs-obscurs du projet Tanamasoandro. Tout comme son emplacement, ni le plan ni le contenu de la nouvelle ville n’a fait l’objet de consultation du public (notamment la communauté affectée par le projet), et pourtant il est censé démarrer fin 2019. Il a fait l’objet d’une série de présentations à la diaspora Malagasy du Kenya en mars 2019, puis aux enseignants et étudiants de l’Université d’Antananarivo en juillet 2019, ainsi qu’à d’autres groupes de personnes qui n’ont pas manqué d’émettre et de partager leurs inquiétudes dans les media. Le titre d’un article relatant cette rencontre avec les Universitaires «  Tanà-Masoandro : plus de questions que de réponses » [1] reflète une insuffisance des informations présentées au grand public au cours de la séance. L’un des soucis concerne le coût énorme de ce projet pharaonique qualifié de « présidentiel  » - un investissement de 2.575 milliards d’Ariary (environ 600 millions d’euros) représentant près de la moitié de tout le budget général de fonctionnement et d’investissement 2019 de l’Etat Malagasy [2] - qui soulève des questions sur les sources et le mode de financement. Les générations futures auront-elles à rembourser, et sous quelle forme, les dettes qui seront probablement à contracter ? En effet, dans un article du 31 juillet 2019, un responsable déclarait que « 21 investisseurs sont déjà engagés  » [3]. Un article du 13 août 2019 révèle que « le projet Tanamasoandro recherche également [encore] des bailleurs comme tous les autres inscrits dans TaTom  » [4]. La presse a mentionné la visite d’un groupe d’opérateurs chinois sur les lieux [5] mais la conclusion d’un contrat quelconque n’a pas été divulguée. La transparence sur ce sujet revêt une importance majeure car l’opacité des informations risque de cacher des « transactions » en échange de terres malagasy, en plus des engagements pris au nom des générations futures si des dettes devront être remboursées.", {io: File.open(Rails.root.join('app', 'assets', 'images', 'qui-profitera-de-tanamasoandro.jpg')), filename: 'default-user-avatar-1.png', content_type: 'image/jpg'}],
		[@tanamasoandro.id, "Aménagement des villes ", "Au dernier moment. La version finale de 900 pages du projet  d’extension des agglomérations d’Antananarivo et de Toamasina (TaTom) contient à son chapitre III, le projet de mise en place du sous centre urbain dénommé « Tana Masoandro». Un projet concocté par le président de la République Andry Rajoelina et annoncé depuis sa campagne présidentielle en 2018, visant à créer une nouvelle ville dans la rive ouest de la rivière Ikopa couvrant 1000ha. Il est prévu d’y construire des logements pour cent mille habitants et d’en générer deux cent mille emplois. « Les premiers documents du projet TaTom ne soulignent pas du tout le projet Tana Masoandro. Il n’a pas été inclus dans les diverses études menées depuis près de trois ans. Grande est ma surprise en voyant ce chapitre où il est écrit une description complète du projet. Ce qui veut dire que Tana Masoandro recherche également des bailleurs comme tous les autres inscrits dans TaTom, pour ne souligner que le projet de mise en place d’autoroute reliant Antananarivo à Toamasina, coûtant près de deux  milliards de dollars »,indique un technicien ayant suivi les étapes d’élaboration de ce projet avec les techniciens japonais. « Les premiers documents du projet TaTom ne soulignent pas du tout le projet Tana Masoandro. Il n’a pas été inclus dans les diverses études menées depuis près de trois ans. Grande est ma surprise en voyant ce chapitre où il est écrit une description complète du projet. Ce qui veut dire que Tana Masoandro recherche également des bailleurs comme tous les autres inscrits dans TaTom, pour ne souligner que le projet de mise en place d’autoroute reliant Antananarivo à Toamasina, coûtant près de deux  milliards de dollars »,indique un technicien ayant suivi les étapes d’élaboration de ce projet avec les techniciens japonais. Le projet comprend la construction d’infrastructures de base telles que les routes, les installations d’approvisionnement en eau et électricité. La construction s’étalera sur cinq ans. Un projet de construction de voie artérielle primaire de 15km avec quatre voies entre le contournement de la RN4 et le centre suburbain d’Ampangabe y est envisagé. Cependant, la zone ouest de l’Ikopa est une zone sujette  aux inondations et qui a protégé la commune urbaine d’Antananarivo des inondations dans le passé. « Les résultats de la simulation du programme intégré d’assainissement d’Antananarivo qui est en cours sont nécessaires afin de déterminer la superficie pouvant être enfouie. Pour l’instant, le ministère de l’Aménagement du territoire, de l’habitat et des travaux publics (MAHTP) a décidé de préparer un décret pour sécuriser un terrain de 289 ha pour le développement de Tana Masoandro », relate la version finale du chapitre III relatif au Projet de développement d’une nouvelle ville dans l’agglomération d’Antananarivo.", {io: File.open(Rails.root.join('app', 'assets', 'images', 'ville-tanamasoandro.jpg')), filename: 'default-user-avatar-1.png', content_type: 'image/jpg'}]
	]
	puts "\nCreating CallForIdeas"
	call_for_ideas.each do |call_for_idea|
		create_call_for_idea(call_for_idea)
	end
end

def create_actualities
	actualities = [
		[@sayna.id, "Carrefour de la formation, des métiers et de l'emploi", "L’Alliance française d’Antananarivo organise le vendredi 18 et samedi 19 octobre prochain dans ses locaux la troisième édition du Carrefour de la formation, des métiers et de l’emploi. Notre but étant de créer une occasion afin de faire rencontrer les jeunes, les étudiants, les diplômés et les centres de formations, universités ainsi que les entreprises chercheuses de talents à recruter. ENTRÉE GRATUITE Participants : Ambatovy, Viseo, Société Générale, Comdata, Hello tanana, Abl outsourcing, Vivetic, Orange Madagascar, BNI Madagascar, Nexta, Sky net, Open flex, Tropic Mada, Sayna, Média click, Linkeo, Etcheck consulting, Eufonie, ISPAG, ISNA, HEDM, CNAM, ACEEM université, G2ACAMAS, UCM, IEP, ESCM. CGM, Fan eduction, Kentia formation, MED (Madagascar Entreprise Développement)."]
	]
	puts "\nCreating Actualities"
	actualities.each do |actuality|
		create_actuality(actuality)
	end
end

def create_surveys
	surveys = [
		[@sayna.id, "Haut-zone à Antananarivo", "Haute-Zone Madagascar est une Startup de WiFi digital marketing fondée en 2017 dont le but est d’amener des nouvelles solutions marketing innovantes pour les entreprises et les PME via le réseau WiFi ", 10, Faker::Date.forward(days: 23), true, {io: File.open(Rails.root.join('app', 'assets', 'images', 'haut-zone.jpg')), filename: 'default-user-avatar-1.png', content_type: 'image/jpg'}]
	]
	puts "\nCreating Surveys"
	surveys.each do |survey|
		create_survey(survey)
	end
end

def create_questions
	questions = [
		[1, "Où est-ce que vous aimerez avoir un réseaux Haute-Zone ?"],
		[1, "Quel âge avez-vous ?"],
		[1, "À quel moment de la journée vous utilisez Haut-Zone ?"]
	]
	puts "\nCreating Questions"
	questions.each do |question|
		create_question(question)
	end
end

def create_options
	options = [
		[1, "À l'aéroport"],
		[1, "Andavamamba"],
		[1, "Tsimbazaza"],
		[1, "Autre"],
		[2, "moins de 10 ans"],
		[2, "entre 10 - 20 ans"],
		[2, "entre 21 - 39 ans"],
		[2, "40 et plus"],
		[3, "Le matin"],
		[3, "L'après midi"],
		[3, "Le soir"]
	]
	puts "\nCreating Options"
	options.each do |option|
		create_option(option)
	end
end

# Seed starts here
create_languages
create_types
create_activities
create_super_admins
create_admins
create_spaces
# create_users
create_ideas
create_projects
create_call_for_ideas
create_actualities
create_surveys
create_questions
create_options

end_of_seed
