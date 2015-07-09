local twilio = require('twilio')
 
local ACCOUNTSID = '<<YOUR TWILIO ACCOUNT ID GOES HERE>>'
local AUTHTOKEN = '<<YOUR TWILIO AUTH TOKEN GOES HERE>>'
local PHONENUMBER = '<<YOUR TWILIO PHONE NUMBER GOES HERE>>'
 
local scripturl = 'https://soctw.webscript.io/sms'
 
if request.form.Body=="HELP ME" then 
	msg = "Just text me the name of any restaurant in New York City. I'll tell you the grade and score (points). Lower scores are better. A (0-13 points); B (14-37 points); C (28 points or more)"
else
	base = "https://data.cityofnewyork.us/resource/xx67-kt59.json?dba="
	query = request.form.Body
	local response = http.request {
    url = base .. query,
	}
	local tr = json.parse(response.content)
	o = tr[1]
	if o == nil then
		msg =	"Sorry. I had a problem finding information about " .. request.form.Body .. ". Try texting HELP ME"
	else
		msg = "Found! " .. o.dba .. " @ " .. o.street  ..  " Grade: " .. o.grade .. " Score: " .. o.score .. " pts. Text HELP ME for more details."	
	end
end
return msg