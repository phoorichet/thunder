json.extract! @person, 
:id, 
:first_name, 
:last_name, 
:gender, 
:date_of_birth,
:marital_status,
:income,
:national_id,
:passport_id,
:height,
:weight,
:occupation,
:created_at, 
:updated_at

json.books @person.books do |book|
	json.begin_at book.begin_at
	json.end_at book.end_at

	json.url api_v1_person_book_url(book.person, book, format: :json)
end

json.parents @person.parents do |parent|
	json.first_name parent.first_name
	json.last_name parent.last_name
end

if @person.spouse != nil
	json.spouse do 
		json.first_name @person.spouse.first_name
		json.last_name @person.spouse.last_name
	end
end

if not @person.root?
	json.relatives @person.siblings do |sibling|
		json.first_name sibling.first_name
		json.last_name sibling.last_name
	end
end

json.children @person.children do |child|
	json.first_name child.first_name
	json.last_name child.last_name
end
